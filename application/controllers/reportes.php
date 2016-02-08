<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

/** Include PHPExcel */
class Reportes extends MY_Controller {

    public function consumointer($mes, $year) {
        if (!$year || $year === '%') {
            $year = date("Y");
        }
        if (!$mes || $mes === '%' || $mes == -1) {
            $mes = date("m");
        }
        $temp = $year . '-' . $mes . '%';

        $headers = $this->headers_consumointer($temp);

        $entidades = $this->entidades_consumointer($temp);

        $cantidades = $this->matrix_de_valores_consumointer($temp);

        $arr = $this->create_matrix($headers, $entidades, $cantidades);

        // Estas variables son para crear un grid dinamico
        $fields = "[ {name: 'REEUP'},{name: 'org_nombre'},{name: 'nombre'}";
        $columns = "[ "
                . "{text: 'REEUP', dataIndex: 'REEUP'},"
                . "{text: 'ENTIDAD/COMEDOR',flex:1,minWidth:170,dataIndex: 'nombre'}";
        foreach ($headers as $value) {
            $data = $value['nombre_producto'];
            $fields = $fields . ",{name: '" . str_replace(" ", "", $data) . "',type: 'float'}";
            $columns = $columns . ",{text: '" . $data . "',flex:1,summaryType: 'sum',dataIndex: '" . str_replace(" ", "", $data) . "'}";
        }
        $fields = $fields . "]";
        $columns = $columns . "]";

        $data = "[";
        foreach ($entidades as $value) {
            $item = "['" . $value['reeup'] . "','" . $value['org_nombre'] . "','" . $value['nombre_entidad'] . "'";
            foreach ($headers as $v) {
                $item = $item . ",'" . $arr[$value['nombre_entidad']][$v['nombre_producto']] . "'";
            }
            $item = $item . "],";
            $data = $data . $item;
        }
        $data = $data . "]";
        $this->output->set_content_type('application/json')
                ->set_output(json_encode(array('fields' => $fields, 'columns' => $columns, 'data' => $data)));
    }

    private function headers_consumointer($time) {
        return Doctrine_Query::create()->select('consumo_inter.id, producto.nombre '
                                . 'as nombre_producto, proveedor.nombre as nombre_proveedor'
                                . ',consumo_inter.cant as cantidad, ent.nombre as nombre_entidad')
                        ->from('ConsumoInter consumo_inter')
                        ->innerJoin('consumo_inter.Producto producto')
                        ->innerJoin('consumo_inter.Entidad ent')
                        ->innerJoin('producto.Proveedor proveedor')
                        ->where('consumo_inter.fecha like "' . $time . '"')
                        ->groupBy('producto.id')
                        ->orderBy('proveedor.nombre, producto.nombre')->execute()->toArray(true);
    }

    private function entidades_consumointer($time) {
        return Doctrine_Query::create()->select('consumo_inter.id, ent.reeup as reeup, ent.nombre '
                                . 'as nombre_entidad, org.nombre as org_nombre')
                        ->from('ConsumoInter consumo_inter')
                        ->innerJoin('consumo_inter.Entidad ent')
                        ->innerJoin('consumo_inter.Producto producto')
                        ->innerJoin('ent.Organismo org')
                        ->where('consumo_inter.fecha like "' . $time . '"')
                        ->groupBy('ent.id')
                        ->orderBy('nombre_entidad')
                        ->execute()->toArray(true);
    }

    private function matrix_de_valores_consumointer($time) {
        return Doctrine_Query::create()->select('consumo_inter.id, producto.nombre '
                                . 'as nombre_producto, proveedor.nombre as nombre_proveedor'
                                . ',consumo_inter.cant as cantidad, ent.nombre as nombre_entidad')
                        ->from('ConsumoInter consumo_inter')
                        ->innerJoin('consumo_inter.Producto producto')
                        ->innerJoin('consumo_inter.Entidad ent')
                        ->innerJoin('producto.Proveedor proveedor')
                        ->where('consumo_inter.fecha like "' . $time . '"')
                        ->orderBy('proveedor.nombre, producto.nombre')
                        ->execute()->toArray(true);
    }

    private function organismos_consumointer($time) {
        return Doctrine_Query::create()->select('ci.id, org.nombre as org_nombre')
                        ->from('ConsumoInter ci')
                        ->innerJoin('ci.Entidad ent')
                        ->innerJoin('ci.Producto producto')
                        ->innerJoin('ent.Organismo org')
                        ->where('ci.fecha like "' . $time . '"')
                        ->groupBy('org.id')
                        ->orderBy('org_nombre')
                        ->execute()->toArray(true);
    }

    private function organismos_consumointer2($time) {
        return Doctrine_Query::create()->select('ci.id, org.nombre as org_nombre')
                        ->from('ConsumoInter ci')
                        ->innerJoin('ci.Entidad ent')
                        ->innerJoin('ci.Producto producto')
                        ->innerJoin('ent.Organismo org')
                        ->where('ci.fecha like "' . $time . '"')
                        ->groupBy('ent.id')
                        ->execute()->toArray(true);
    }

    private function proveedores_consumointer($time) {
        return Doctrine_Query::create()
                        ->select('producto.id, proveedor.nombre as nombre')
                        ->from('NomProducto producto')->innerJoin('producto.Proveedor proveedor')
                        ->innerJoin('producto.ConsumoInter ci')
                        ->where('ci.fecha like "' . $time . '"')
                        ->groupBy('proveedor.id')
                        ->orderBy('proveedor.nombre, producto.nombre')
                        ->execute()->toArray(true);
    }

    private function proveedores_consumointer2($time) {
        return Doctrine_Query::create()
                        ->select('producto.id, proveedor.nombre as nombre')
                        ->from('NomProducto producto')->innerJoin('producto.Proveedor proveedor')
                        ->innerJoin('producto.ConsumoInter ci')
                        ->where('ci.fecha like "' . $time . '"')
                        ->groupBy('producto.id')
                        ->orderBy('proveedor.nombre, producto.nombre')
                        ->execute()->toArray(true);
    }

    public function generar_xls_consumointer($mes, $year) {
        $excel = $this->generar_reporte_consumointer($mes, $year);
        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        if (!$mes || $mes === '%' || $mes == -1) {
            $mes = date("m");
        }
        $mes = $this->mes($mes);
        header('Content-Disposition: attachment;filename="consumointer-' . $mes . '.xlsx"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($excel, 'Excel2007');
        $objWriter->save('php://output');
    }

    public function generar_pdf_consumointer($mes, $year) {
        $this->load->library('mpdf');
        $excel = $this->generar_reporte_consumointer($mes, $year);
        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/pdf');
        if (!$mes || $mes === '%' || $mes == -1) {
            $mes = date("m");
        }
        $mes = $this->mes($mes);
        header('Content-Disposition: attachment;filename="consumointer-' . $mes . '.pdf"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($excel, 'PDF');
        $objWriter->save('php://output');
    }

    private function entidades_por_organismo_consumointer($time, $organ) {
        return Doctrine_Query::create()->select('ci.id, ent.reeup as reeup, ent.nombre '
                                . 'as nombre_entidad, org.nombre as org_nombre')
                        ->from('ConsumoInter ci')
                        ->innerJoin('ci.Entidad ent')
                        ->innerJoin('ci.Producto producto')
                        ->innerJoin('ent.Organismo org')
                        ->where('ci.fecha like "' . $time . '"' . ' and org.nombre like "' . $organ . '"')
                        ->groupBy('ent.id')
                        ->orderBy('nombre_entidad')
                        ->execute()->toArray(true);
    }

    private function generar_reporte_consumointer($mes, $year) {
        if (!$year || $year === '%') {
            $year = date("Y");
        }
        if (!$mes || $mes === '%' || $mes == -1) {
            $mes = date("m");
        }
        $temp = $year . '-' . $mes . '%';

        $headers = $this->headers_consumointer($temp);

        $items3 = $this->entidades_consumointer($temp);

        $org = $this->organismos_consumointer($temp);
        $org2 = $this->organismos_consumointer2($temp);
        $organismos = $this->count_distinct($org, $org2, 'org_nombre');

        $pr1 = $this->proveedores_consumointer($temp);
        $pr2 = $this->proveedores_consumointer2($temp);
        $proveedores = $this->count_distinct($pr1, $pr2, 'nombre');

        $items4 = $this->matrix_de_valores_consumointer($temp);

        $arr = $this->create_matrix($headers, $items3, $items4);
        $this->load->library('phpexcel');
        $this->phpexcel->getProperties()->setCreator("PHPExcel")
                ->setLastModifiedBy("PHPExcel")
                ->setTitle("Office 2007 XLSX Report Document")
                ->setSubject("Office 2007 XLSX Report Document")
                ->setDescription("Report document for Office 2007 XLSX, generated using PHP classes.")
                ->setKeywords("office 2007 openxml php")
                ->setCategory("Report result file");
        $this->phpexcel->getActiveSheet()->setCellValue('B1', 'CONSUMO INTERMEDIO');
        $this->phpexcel->getActiveSheet()->mergeCells('B1:C1');
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getProtection()->setLocked(PHPExcel_Style_Protection::PROTECTION_UNPROTECTED);
        // Set fonts
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getFont()->setName('Candara');
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getFont()->setSize(20);
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getFont()->setBold(true);
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getFont()->setUnderline(PHPExcel_Style_Font::UNDERLINE_SINGLE);
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);


        $this->phpexcel->getActiveSheet()->setCellValue('E1', PHPExcel_Shared_Date::PHPToExcel(gmmktime(0, 0, 0, date('m'), date('d'), date('Y'))));
        $this->phpexcel->getActiveSheet()->getStyle('E1')->getNumberFormat()->setFormatCode(PHPExcel_Style_NumberFormat::FORMAT_DATE_XLSX15);
        $this->phpexcel->getActiveSheet()->setCellValue('B3', 'ENTIDAD/COMEDOR');
        $this->phpexcel->getActiveSheet()->setCellValue('A3', 'REEUP');
        $this->phpexcel->getActiveSheet()->getColumnDimension('B')->setAutoSize(true);
        $this->phpexcel->getActiveSheet()->setCellValue('B4', 'TOTAL');
        $this->phpexcel->getActiveSheet()->getStyle('B4')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $this->phpexcel->getActiveSheet()->getStyle('A4')->applyFromArray($this->styles('blackStyle'));
        $this->phpexcel->getActiveSheet()->getStyle('B4')->applyFromArray($this->styles('blackStyle'));

        $this->phpexcel->getActiveSheet()->getStyle('A3')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getActiveSheet()->getStyle('B3')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getActiveSheet()->getStyle('A2:B2')->applyFromArray($this->styles('headerStyle'));

        $total_cap = array();
        $i = 5;
        foreach ($organismos as $value) {
            $firstCell = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(0, $i);
            $this->phpexcel->getActiveSheet()->getStyle($firstCell->getCoordinate())->applyFromArray($this->styles('borderStyle'));
            $coor = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(1, $i, $value[0], true);
            $this->phpexcel->getActiveSheet()->getStyle($coor->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);
            $this->phpexcel->getActiveSheet()->getStyle($coor->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $total_cap_por_org = array();
            for ($index = 2; $index <= count($headers) + 1; $index++) {
                $z = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, $i);
                $this->phpexcel->getActiveSheet()->getStyle($z->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                $next = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, $i + 1);
                $coord1 = $next->getCoordinate();
                $last = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, $i + $value[1]);
                $coord2 = $last->getCoordinate();
                $sum_coord = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($index, $i, '=SUM(' . $coord1 . ':' . $coord2 . ')', true);
                $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                array_push($total_cap_por_org, $sum_coord->getCoordinate());
            }
            array_push($total_cap, $total_cap_por_org);
            $i = $i + 1;
            $entidades = $this->entidades_por_organismo_consumointer($temp, $value[0]);
            foreach ($entidades as $value2) {
                $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(1, $i, $value2['nombre_entidad'], true);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setIndent(1);
                $b = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(0, $i, $value2['reeup'], true);
                $this->phpexcel->getActiveSheet()->getStyle($b->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $x = 2;
                foreach ($arr[$value2['nombre_entidad']] as $v2) {
                    $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($x, $i, $v2, true);
                    $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                    $x = $x + 1;
                }
                $i = $i + 1;
            }
        }
        $t = 2;
        foreach ($proveedores as $value) {
            $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($t, 2, $value[0], true);
            $coordA = $a->getCoordinate();
            $b = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($t + $value[1] - 1, 2);
            $coordB = $b->getCoordinate();
            $this->phpexcel->getActiveSheet()->mergeCells($coordA . ':' . $coordB);
            $this->phpexcel->getActiveSheet()->getStyle($coordA . ':' . $coordB)->applyFromArray($this->styles('headerStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($coordA . ':' . $coordB)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

            $t = $t + $value[1];
        }
        $j = 2;
        foreach ($headers as $value) {
            $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($j, 3, $value['nombre_producto'], true);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setTextRotation(90);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('headerStyle'));
            $j = $j + 1;
        }
        $this->phpexcel->getActiveSheet()->getStyle('E1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);

        //Crear formula para el total general
        $row_four = 4;
        $total = array();
        foreach ($total_cap[0] as $value) {
            array_push($total, $value);
        }
        //quitar el primer elemento de la lista
        array_shift($total_cap);
        foreach ($total_cap as $arr) {
            for ($index = 0; $index < count($arr); $index++) {
                $total[$index] = $total[$index] . '+' . $arr[$index];
            }
        }
        for ($index = 2; $index <= count($headers) + 1; $index++) {
            $sum_coord = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($index, $row_four, '=' . $total[$index - 2], true);
            $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLACK);
            $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->applyFromArray($this->styles('blackStyle'));
        }

        $lastColumn_row1 = count($headers) + 1;
        $lastCell = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($lastColumn_row1, 1);
        $this->phpexcel->getActiveSheet()->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getActiveSheet()->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->getStartColor()->setARGB('FF808080');
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddHeader('&RFecha &D');
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddFooter('&L&B' . $this->phpexcel->getProperties()->getTitle() . '&RPage &P of &N');
        $this->phpexcel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
        $this->phpexcel->getActiveSheet()->getPageSetup()->setPaperSize(PHPExcel_Worksheet_PageSetup::PAPERSIZE_LETTER);
        $this->phpexcel->getActiveSheet()->setTitle('CONSUMO INTERMEDIO');
        $this->phpexcel->setActiveSheetIndex(0);

        return $this->phpexcel;
    }

    //-----------------------------------------------------------------------------------------

    /**
     * Buscar los nombres de las columnas del reporte. 
     * En este caso son los productos del inventario
     * @param type $time
     * @return array
     */
    private function headers_inv($time) {
        return Doctrine_Query::create()->select('inventario.id, producto.nombre '
                                . 'as nombre_producto, proveedor.nombre as nombre_proveedor'
                                . ',inventario.cant as cantidad, ent.nombre as nombre_entidad')
                        ->from('Inventario inventario')
                        ->innerJoin('inventario.Producto producto')
                        ->innerJoin('inventario.Entidad ent')
                        ->innerJoin('producto.Proveedor proveedor')
                        ->where('inventario.fecha like "' . $time . '"')
                        ->groupBy('producto.id')
                        ->orderBy('proveedor.nombre, producto.nombre')->execute()->toArray(true);
    }

    /**
     * Buscar los proveedores de los productos del inventario agrupados por producto
     * @param type $time
     * @return type
     */
    private function proveedores_inv2($time) {
        return Doctrine_Query::create()
                        ->select('producto.id, proveedor.nombre as nombre')
                        ->from('NomProducto producto')->innerJoin('producto.Proveedor proveedor')
                        ->innerJoin('producto.Inventario inventario')
                        ->where('inventario.fecha like "' . $time . '"')
                        ->groupBy('producto.id')
                        ->orderBy('proveedor.nombre, producto.nombre')
                        ->execute()->toArray(true);
    }

    /**
     * Buscar los proveedores de los productos del inventario agrupados por proveedor
     * @param type $time
     * @return type
     */
    private function proveedores_inv($time) {
        return Doctrine_Query::create()
                        ->select('producto.id, proveedor.nombre as nombre')
                        ->from('NomProducto producto')->innerJoin('producto.Proveedor proveedor')
                        ->innerJoin('producto.Inventario inventario')
                        ->where('inventario.fecha like "' . $time . '"')
                        ->groupBy('proveedor.id')
                        ->orderBy('proveedor.nombre, producto.nombre')
                        ->execute()->toArray(true);
    }

    /**
     * Buscar las entidades del inventario
     * @param type $time
     * @return type
     */
    private function entidades_inv($time) {
        return Doctrine_Query::create()->select('inv.id, ent.reeup as reeup, ent.nombre '
                                . 'as nombre_entidad, org.nombre as org_nombre')
                        ->from('Inventario inv')
                        ->innerJoin('inv.Entidad ent')
                        ->innerJoin('inv.Producto producto')
                        ->innerJoin('ent.Organismo org')
                        ->where('inv.fecha like "' . $time . '"')
                        ->groupBy('ent.id')
                        ->orderBy('nombre_entidad')
                        ->execute()->toArray(true);
    }

    /**
     * Buscar las entidades del inventario dado el organismo
     * @param type $time
     * @return type
     */
    private function entidades_por_organismo_inv($time, $organ) {
        return Doctrine_Query::create()->select('inv.id, ent.reeup as reeup, ent.nombre '
                                . 'as nombre_entidad, org.nombre as org_nombre')
                        ->from('Inventario inv')
                        ->innerJoin('inv.Entidad ent')
                        ->innerJoin('inv.Producto producto')
                        ->innerJoin('ent.Organismo org')
                        ->where('inv.fecha like "' . $time . '"' . ' and org.nombre like "' . $organ . '"')
                        ->groupBy('ent.id')
                        ->orderBy('nombre_entidad')
                        ->execute()->toArray(true);
    }

    /**
     * Buscar los organismos del inventario
     * @param type $time
     * @return type
     */
    private function organismos_inv($time) {
        return Doctrine_Query::create()->select('inv.id, org.nombre as org_nombre')
                        ->from('Inventario inv')
                        ->innerJoin('inv.Entidad ent')
                        ->innerJoin('inv.Producto producto')
                        ->innerJoin('ent.Organismo org')
                        ->where('inv.fecha like "' . $time . '"')
                        ->groupBy('org.id')
                        ->orderBy('org_nombre')
                        ->execute()->toArray(true);
    }

    private function organismos_inv2($time) {
        return Doctrine_Query::create()->select('inv.id, org.nombre as org_nombre')
                        ->from('Inventario inv')
                        ->innerJoin('inv.Entidad ent')
                        ->innerJoin('inv.Producto producto')
                        ->innerJoin('ent.Organismo org')
                        ->where('inv.fecha like "' . $time . '"')
                        ->groupBy('ent.id')
                        ->execute()->toArray(true);
    }

    /**
     * Buscar los valores por cada entidad y por cada producto
     * @param type $time
     * @return type
     */
    private function matrix_de_valores_inv($time) {
        return Doctrine_Query::create()->select('inventario.id, producto.nombre '
                                . 'as nombre_producto, proveedor.nombre as nombre_proveedor'
                                . ',inventario.cant as cantidad, ent.nombre as nombre_entidad')
                        ->from('Inventario inventario')
                        ->innerJoin('inventario.Producto producto')
                        ->innerJoin('inventario.Entidad ent')
                        ->innerJoin('producto.Proveedor proveedor')
                        ->where('inventario.fecha like "' . $time . '"')
                        ->orderBy('proveedor.nombre, producto.nombre')
                        ->execute()->toArray(true);
    }

    public function inventario($mes, $year) {
        if (!$year || $year === '%') {
            $year = date("Y");
        }
        if (!$mes || $mes === '%' || $mes == -1) {
            $mes = date("m");
        }
        $temp = $year . '-' . $mes . '%';

        $headers = $this->headers_inv($temp);

        $entidades = $this->entidades_inv($temp);

        $cantidades = $this->matrix_de_valores_inv($temp);

        $arr = $this->create_matrix($headers, $entidades, $cantidades);

        // Estas variables son para crear un grid dinamico
        $fields = "[ {name: 'REEUP'},{name: 'org_nombre'},{name: 'nombre'}";
        $columns = "[ "
                . "{text: 'REEUP', dataIndex: 'REEUP'},"
                . "{text: 'ENTIDAD/COMEDOR',flex:1,minWidth:170,dataIndex: 'nombre'}";
        foreach ($headers as $value) {
            $data = $value['nombre_producto'];
            $fields = $fields . ",{name: '" . str_replace(" ", "", $data) . "',type: 'float'}";
            $columns = $columns . ",{text: '" . $data . "',flex:1,summaryType: 'sum',dataIndex: '" . str_replace(" ", "", $data) . "'}";
        }
        $fields = $fields . "]";
        $columns = $columns . "]";

        $data = "[";
        foreach ($entidades as $value) {
            $item = "['" . $value['reeup'] . "','" . $value['org_nombre'] . "','" . $value['nombre_entidad'] . "'";
            foreach ($headers as $v) {
                $item = $item . ",'" . $arr[$value['nombre_entidad']][$v['nombre_producto']] . "'";
            }
            $item = $item . "],";
            $data = $data . $item;
        }
        $data = $data . "]";
        $this->output->set_content_type('application/json')
                ->set_output(json_encode(array('fields' => $fields, 'columns' => $columns, 'data' => $data)));
    }

    public function generar_xls_inventario($mes, $year) {
        $excel = $this->generar_reporte_inventario($mes, $year);
        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        if (!$mes || $mes === '%' || $mes == -1) {
            $mes = date("m");
        }
        $mes = $this->mes($mes);
        header('Content-Disposition: attachment;filename="inventario-' . $mes . '.xlsx"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($excel, 'Excel2007');
        $objWriter->save('php://output');
    }

    public function generar_pdf_inventario($mes, $year) {
        $this->load->library('mpdf');
        $excel = $this->generar_reporte_inventario($mes, $year);
        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/pdf');
        if (!$mes || $mes === '%' || $mes == -1) {
            $mes = date("m");
        }
        $mes = $this->mes($mes);
        header('Content-Disposition: attachment;filename="inventario-' . $mes . '.pdf"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($excel, 'PDF');
        $objWriter->save('php://output');
    }

    public function generar_reporte_inventario($mes, $year) {
        if (!$year || $year === '%') {
            $year = date("Y");
        }
        if (!$mes || $mes === '%' || $mes == -1) {
            $mes = date("m");
        }
        $temp = $year . '-' . $mes . '%';

        $headers = $this->headers_inv($temp);

        $items3 = $this->entidades_inv($temp);

        $org = $this->organismos_inv($temp);
        $org2 = $this->organismos_inv2($temp);
        $organismos = $this->count_distinct($org, $org2, 'org_nombre');

        $pr1 = $this->proveedores_inv($temp);
        $pr2 = $this->proveedores_inv2($temp);
        $proveedores = $this->count_distinct($pr1, $pr2, 'nombre');

        $items4 = $this->matrix_de_valores_inv($temp);

        $arr = $this->create_matrix($headers, $items3, $items4);


// Create new PHPExcel object
        $this->load->library('phpexcel');

// Set document properties
        $this->phpexcel->getProperties()->setCreator("PHPExcel")
                ->setLastModifiedBy("PHPExcel")
                ->setTitle("Office 2007 XLSX Report Document")
                ->setSubject("Office 2007 XLSX Report Document")
                ->setDescription("Report document for Office 2007 XLSX, generated using PHP classes.")
                ->setKeywords("office 2007 openxml php")
                ->setCategory("Report result file");


// Add some data
        $this->phpexcel->getActiveSheet()->setCellValue('B1', 'INVENTARIOS');
        $this->phpexcel->getActiveSheet()->mergeCells('B1:C1');
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getProtection()->setLocked(PHPExcel_Style_Protection::PROTECTION_UNPROTECTED);
        // Set fonts
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getFont()->setName('Candara');
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getFont()->setSize(20);
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getFont()->setBold(true);
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getFont()->setUnderline(PHPExcel_Style_Font::UNDERLINE_SINGLE);
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);


        $this->phpexcel->getActiveSheet()->setCellValue('E1', PHPExcel_Shared_Date::PHPToExcel(gmmktime(0, 0, 0, date('m'), date('d'), date('Y'))));
        $this->phpexcel->getActiveSheet()->getStyle('E1')->getNumberFormat()->setFormatCode(PHPExcel_Style_NumberFormat::FORMAT_DATE_XLSX15);
        $this->phpexcel->getActiveSheet()->setCellValue('B3', 'ENTIDAD/COMEDOR');
        $this->phpexcel->getActiveSheet()->setCellValue('A3', 'REEUP');
        $this->phpexcel->getActiveSheet()->getColumnDimension('B')->setAutoSize(true);
        $this->phpexcel->getActiveSheet()->setCellValue('B4', 'TOTAL CAP');
        $this->phpexcel->getActiveSheet()->getStyle('B4')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $this->phpexcel->getActiveSheet()->getStyle('A4')->applyFromArray($this->styles('blackStyle'));
        $this->phpexcel->getActiveSheet()->getStyle('B4')->applyFromArray($this->styles('blackStyle'));

        $this->phpexcel->getActiveSheet()->getStyle('A3')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getActiveSheet()->getStyle('B3')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getActiveSheet()->getStyle('A2:B2')->applyFromArray($this->styles('headerStyle'));

        $total_cap = array();
        $i = 5;
        foreach ($organismos as $value) {
            $firstCell = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(0, $i);
            $this->phpexcel->getActiveSheet()->getStyle($firstCell->getCoordinate())->applyFromArray($this->styles('borderStyle'));
            $coor = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(1, $i, $value[0], true);
            $this->phpexcel->getActiveSheet()->getStyle($coor->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);
            $this->phpexcel->getActiveSheet()->getStyle($coor->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $total_cap_por_org = array();
            for ($index = 2; $index <= count($headers) + 1; $index++) {
                $z = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, $i);
                $this->phpexcel->getActiveSheet()->getStyle($z->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                $next = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, $i + 1);
                $coord1 = $next->getCoordinate();
                $last = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, $i + $value[1]);
                $coord2 = $last->getCoordinate();
                $sum_coord = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($index, $i, '=SUM(' . $coord1 . ':' . $coord2 . ')', true);
                $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                array_push($total_cap_por_org, $sum_coord->getCoordinate());
            }
            array_push($total_cap, $total_cap_por_org);
            $i = $i + 1;
            $entidades = $this->entidades_por_organismo_inv($temp, $value[0]);
            foreach ($entidades as $value2) {
                $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(1, $i, $value2['nombre_entidad'], true);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setIndent(1);
                $b = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(0, $i, $value2['reeup'], true);
                $this->phpexcel->getActiveSheet()->getStyle($b->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $x = 2;
                foreach ($arr[$value2['nombre_entidad']] as $v2) {
                    $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($x, $i, $v2, true);
                    $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                    $x = $x + 1;
                }
                $i = $i + 1;
            }
        }
        $t = 2;
        foreach ($proveedores as $value) {
            $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($t, 2, $value[0], true);
            $coordA = $a->getCoordinate();
            $b = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($t + $value[1] - 1, 2);
            $coordB = $b->getCoordinate();
            $this->phpexcel->getActiveSheet()->mergeCells($coordA . ':' . $coordB);
            $this->phpexcel->getActiveSheet()->getStyle($coordA . ':' . $coordB)->applyFromArray($this->styles('headerStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($coordA . ':' . $coordB)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

            $t = $t + $value[1];
        }
        $j = 2;
        foreach ($headers as $value) {
            $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($j, 3, $value['nombre_producto'], true);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setTextRotation(90);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('headerStyle'));
            $j = $j + 1;
        }
        //$this->phpexcel->getActiveSheet()->fromArray($arr, null, 'B5', false);
        $this->phpexcel->getActiveSheet()->getStyle('E1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);

        //Crear formula para el total general
        $row_four = 4;
        $total = array();
        foreach ($total_cap[0] as $value) {
            array_push($total, $value);
        }
        //quitar el primer elemento de la lista
        array_shift($total_cap);
        foreach ($total_cap as $arr) {
            for ($index = 0; $index < count($arr); $index++) {
                $total[$index] = $total[$index] . '+' . $arr[$index];
            }
        }
        for ($index = 2; $index <= count($headers) + 1; $index++) {
            $sum_coord = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($index, $row_four, '=' . $total[$index - 2], true);
            $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLACK);
            $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->applyFromArray($this->styles('blackStyle'));
        }


// Set fills
        $lastColumn_row1 = count($headers) + 1;
        $lastCell = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($lastColumn_row1, 1);
        $this->phpexcel->getActiveSheet()->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getActiveSheet()->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->getStartColor()->setARGB('FF808080');

// Set header and footer. When no different headers for odd/even are used, odd header is assumed.
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddHeader('&RFecha &D');
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddFooter('&L&B' . $this->phpexcel->getProperties()->getTitle() . '&RPage &P of &N');

// Set page orientation and size
        $this->phpexcel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
        $this->phpexcel->getActiveSheet()->getPageSetup()->setPaperSize(PHPExcel_Worksheet_PageSetup::PAPERSIZE_LETTER);

// Rename first worksheet
        $this->phpexcel->getActiveSheet()->setTitle('INVENTARIOS');


// Set active sheet index to the first sheet, so Excel opens this as the first sheet
        $this->phpexcel->setActiveSheetIndex(0);

        return $this->phpexcel;
    }

    private function headers_nominalizados($time) {
        $query = Doctrine_Query::create()->select('org_nominalizado.id, producto.id as producto_id, producto.nombre '
                        . 'as nombre_producto, proveedor.nombre as nombre_proveedor'
                        . ',org_nominalizado.ctd as cantidad, ent.nombre as nombre_entidad')
                ->from('OrgNominalizado org_nominalizado')
                ->innerJoin('org_nominalizado.Producto producto')
                ->innerJoin('org_nominalizado.Entidad ent')
                ->innerJoin('producto.Proveedor proveedor')
                ->where('org_nominalizado.fecha like "' . $time . '"')
                ->groupBy('producto.id')
                ->orderBy('proveedor.nombre, producto.nombre');
        return $query->execute()->toArray(true);
    }

    private function organismos_nominalizados($time) {
        $query = Doctrine_Query::create()->select('org.id, ent.reeup as reeup, ent.nombre as nombre_entidad')
                ->from('OrgNominalizado org')
                ->innerJoin('org.Entidad ent')
                ->innerJoin('org.Producto producto')
                ->innerJoin('ent.Organismo organ')
                ->where('org.fecha like "' . $time . '"')
                ->groupBy('ent.id')
                ->orderBy('nombre_entidad');
        return $query->execute()->toArray(true);
    }

    private function data_nominalizados($time) {
        $query = Doctrine_Query::create()->select('org.id, producto.nombre '
                        . 'as nombre_producto, proveedor.nombre as nombre_proveedor'
                        . ',org.ctd as cantidad, ent.nombre as nombre_entidad')
                ->from('OrgNominalizado org')
                ->innerJoin('org.Producto producto')
                ->innerJoin('org.Entidad ent')
                ->innerJoin('producto.Proveedor proveedor')
                ->where('org.fecha like "' . $time . '"')
                ->orderBy('proveedor.nombre, producto.nombre');
        return $query->execute()->toArray(true);
    }

    /**
     * Buscar los proveedores de los productos de los organismos nominalizados
     * @param type $time
     * @return type
     */
    private function proveedores_nominalizados2($time) {
        return Doctrine_Query::create()->select('org.id, proveedor.nombre as nombre')
                        ->from('OrgNominalizado org')
                        ->innerJoin('org.Producto producto')
                        ->innerJoin('org.Entidad ent')
                        ->innerJoin('producto.Proveedor proveedor')
                        ->where('org.fecha like "' . $time . '"')
                        ->groupBy('producto.id')
                        ->orderBy('proveedor.nombre, producto.nombre')
                        ->execute()->toArray(true);
    }

    private function proveedores_nominalizados($time) {
        return Doctrine_Query::create()->select('org.id, proveedor.nombre as nombre')
                        ->from('OrgNominalizado org')
                        ->innerJoin('org.Producto producto')
                        ->innerJoin('org.Entidad ent')
                        ->innerJoin('producto.Proveedor proveedor')
                        ->where('org.fecha like "' . $time . '"')
                        ->groupBy('proveedor.id')
                        ->orderBy('proveedor.nombre, producto.nombre')
                        ->execute()->toArray(true);
    }

    private function create_matrix($headers, $items3, $items4) {
        $arr = array();
        foreach ($items3 as $value) {
            $arr2 = array();
            foreach ($headers as $value2) {
                $arr2[$value2['nombre_producto']] = 0;
            }
            $arr[$value['nombre_entidad']] = $arr2;
        }
        foreach ($items4 as $value) {
            $arr[$value['nombre_entidad']][$value['nombre_producto']] = $value['cantidad'];
        }
        return $arr;
    }

    public function nominalizados_y_otros($mes, $year) {
        if (!$year || $year === '%') {
            $year = date("Y");
        }
        if (!$mes || $mes === '%' || $mes == -1) {
            $mes = date("m");
        }
        $time = $year . '-' . $mes . '%';
        $headers = $this->headers_nominalizados($time);

        $items3 = $this->organismos_nominalizados($time);

        $items4 = $this->data_nominalizados($time);

        $arr = $this->create_matrix($headers, $items3, $items4);

        $fields = "[{name: 'nombre'}";
        $columns = "[ "
                . "{text: 'NOMINALIZADOS',flex:1,summaryRenderer: function(value, summaryData, dataIndex) {
            return 'TOTAL'; 
        },minWidth:170,dataIndex: 'nombre'}";
        foreach ($headers as $value) {
            $data = $value['nombre_producto'];
            $fields = $fields . ",{name: '" . str_replace(" ", "", $data) . "',type: 'float'}";
            $columns = $columns . ",{text: '" . $data . "',flex:1,summaryType: 'sum',dataIndex: '" . str_replace(" ", "", $data) . "'}";
        }
        $fields = $fields . "]";
        $columns = $columns . "]";

        $data = "[";
        foreach ($items3 as $value) {
            $item = "['" . $value['nombre_entidad'] . "'";
            foreach ($headers as $v) {
                $item = $item . ",'" . $arr[$value['nombre_entidad']][$v['nombre_producto']] . "'";
            }
            $item = $item . "],";
            $data = $data . $item;
        }
        $data = $data . "]";
        $this->output->set_content_type('application/json')
                ->set_output(json_encode(array('fields' => $fields, 'columns' => $columns, 'data' => $data)));
    }

    public function generar_xls_nominalizados($mes, $year) {
        $excel = $this->generar_reporte_nominalizados($mes, $year);
        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        if (!$mes || $mes === '%' || $mes == -1) {
            $mes = date("m");
        }
        $mes = $this->mes($mes);
        header('Content-Disposition: attachment;filename="nominalizados-' . $mes . '.xlsx"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($excel, 'Excel2007');
        $objWriter->save('php://output');
    }

    public function generar_pdf_nominalizados($mes, $year) {
        $this->load->library('mpdf');
        $excel = $this->generar_reporte_nominalizados($mes, $year);
        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/pdf');
        if (!$mes || $mes === '%' || $mes == -1) {
            $mes = date("m");
        }
        $mes = $this->mes($mes);
        header('Content-Disposition: attachment;filename="nominalizados-' . $mes . '.pdf"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($excel, 'PDF');
        $objWriter->save('php://output');
    }

    private function generar_reporte_nominalizados($mes, $year) {
        if (!$year || $year === '%') {
            $year = date("Y");
        }
        if (!$mes || $mes === '%' || $mes == -1) {
            $mes = date("m");
        }
        $time = $year . '-' . $mes . '%';
        $headers = $this->headers_nominalizados($time);

        $items3 = $this->organismos_nominalizados($time);

        $pr1 = $this->proveedores_nominalizados($time);
        $pr2 = $this->proveedores_nominalizados2($time);
        $proveedores = $this->count_distinct($pr1, $pr2, 'nombre');

        $items4 = $this->data_nominalizados($time);

        $arr = $this->create_matrix($headers, $items3, $items4);


// Create new PHPExcel object
        $this->load->library('phpexcel');

// Set document properties
        $this->phpexcel->getProperties()->setCreator("PHPExcel")
                ->setLastModifiedBy("PHPExcel")
                ->setTitle("Office 2007 XLSX Report Document")
                ->setSubject("Office 2007 XLSX Report Document")
                ->setDescription("Report document for Office 2007 XLSX, generated using PHP classes.")
                ->setKeywords("office 2007 openxml php")
                ->setCategory("Report result file");


// Add some data
        $this->phpexcel->getActiveSheet()->setCellValue('A1', 'Organismos Nominalizados');
        $this->phpexcel->getActiveSheet()->mergeCells('A1:B1');
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getProtection()->setLocked(PHPExcel_Style_Protection::PROTECTION_UNPROTECTED);
        // Set fonts
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->setName('Candara');
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->setSize(20);
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->setBold(true);
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->setUnderline(PHPExcel_Style_Font::UNDERLINE_SINGLE);
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);


//        $this->phpexcel->getActiveSheet()->setCellValue('D1', PHPExcel_Shared_Date::PHPToExcel(gmmktime(0, 0, 0, date('m'), date('d'), date('Y'))));
//        $this->phpexcel->getActiveSheet()->getStyle('D1')->getNumberFormat()->setFormatCode(PHPExcel_Style_NumberFormat::FORMAT_DATE_XLSX15);

        $this->phpexcel->getActiveSheet()->setCellValue('A3', 'Nombre');
        $this->phpexcel->getActiveSheet()->getColumnDimension('A')->setAutoSize(true);
        $this->phpexcel->getActiveSheet()->setCellValue('A4', 'Total');
        $this->phpexcel->getActiveSheet()->getStyle('A4')->applyFromArray($this->styles('blackStyle'));

        for ($index = 1; $index <= count($headers); $index++) {
            $a = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, 4);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $next = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, 5);
            $coord1 = $next->getCoordinate();
            $last = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, count($items3) + 4);
            $coord2 = $last->getCoordinate();
            $formula = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($index, 4, '=SUM(' . $coord1 . ':' . $coord2 . ')', true);
            $this->phpexcel->getActiveSheet()->getStyle($formula->getCoordinate())->getNumberFormat()->setFormatCode('#,##0.000');
        }
        $this->phpexcel->getActiveSheet()->getStyle('A3')->applyFromArray($this->styles('headerStyle'));
        $i = 5;
        foreach ($items3 as $value) {
            $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(0, $i, $value['nombre_entidad']);
            $a = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(0, $i);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
            $i = $i + 1;
        }

        $t = 1;
        foreach ($proveedores as $value) {
            $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($t, 2, $value[0], true);
            $coordA = $a->getCoordinate();
            $b = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($t + $value[1] - 1, 2);
            $coordB = $b->getCoordinate();
            $this->phpexcel->getActiveSheet()->mergeCells($coordA . ':' . $coordB);
            $this->phpexcel->getActiveSheet()->getStyle($coordA . ':' . $coordB)->applyFromArray($this->styles('headerStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($coordA . ':' . $coordB)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

            $t = $t + $value[1];
        }

        $j = 1;
        foreach ($headers as $value) {
            $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($j, 3, $value['nombre_producto']);
            $a = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($j, 3);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setTextRotation(90);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('headerStyle'));
            $j = $j + 1;
        }

        $y = 5;
        foreach ($arr as $v) {
            $x = 1;
            foreach ($v as $v2) {
                $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($x, $y, $v2);
                $a = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($x, $y);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getNumberFormat()->setFormatCode('#,##0.000');
                $x = $x + 1;
            }$y = $y + 1;
        }

        //MERCADOS
        $mercados = NomMercadoTable::getInstance()->mercados($time);
        foreach ($mercados as $value) {
            $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(0, $i, $value['nombre']);
            $a = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(0, $i);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setIndent(2);
            $j = 1;
            foreach ($headers as $v) {
                $cantidad = 0;
                $arr = ProductoMercadoTable::getInstance()->cantidad($time, $v['producto_id'], $value['mercado_id']);
                if ($arr && $arr[0]) {
                    $obj = $arr[0];
                    $cantidad = $obj['cantidad'];
                }
                $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($j, $i, $cantidad);
                $a = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($j, $i);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getNumberFormat()->setFormatCode('#,##0.000');
                $j = $j + 1;
            }
            $i = $i + 1;
        }

        //$this->phpexcel->getActiveSheet()->fromArray($arr, null, 'B5', false);
        $this->phpexcel->getActiveSheet()->getStyle('D1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);

// Set fills
        $lastColumn_row1 = count($headers);
        $lastCell = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($lastColumn_row1, 1);
        $this->phpexcel->getActiveSheet()->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getActiveSheet()->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->getStartColor()->setARGB('FF808080');
        $this->phpexcel->getActiveSheet()->getStyle('A2')->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getActiveSheet()->getStyle('A2')->getFill()->getStartColor()->setARGB('FF808080');

// Set header and footer. When no different headers for odd/even are used, odd header is assumed.
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddHeader('&RFecha &D');
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddFooter('&L&B' . $this->phpexcel->getProperties()->getTitle() . '&RPage &P of &N');

// Set page orientation and size
        $this->phpexcel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
        $this->phpexcel->getActiveSheet()->getPageSetup()->setPaperSize(PHPExcel_Worksheet_PageSetup::PAPERSIZE_LETTER);

// Rename first worksheet
        $this->phpexcel->getActiveSheet()->setTitle('NOMINALIZADOS Y OTROS');


// Set active sheet index to the first sheet, so Excel opens this as the first sheet
        $this->phpexcel->setActiveSheetIndex(0);

        return $this->phpexcel;
    }

    private function generar_reporte_nivel_actividad($year) {
        $time = $year . '%';

        $organismos = BalanceAlimTable::getInstance()->organismos($time);
// Create new PHPExcel object
        $this->load->library('phpexcel');

// Set document properties
        $this->phpexcel->getProperties()->setCreator("PHPExcel")
                ->setLastModifiedBy("PHPExcel")
                ->setTitle("Office 2007 XLSX Report Document")
                ->setSubject("Office 2007 XLSX Report Document")
                ->setDescription("Report document for Office 2007 XLSX, generated using PHP classes.")
                ->setKeywords("office 2007 openxml php")
                ->setCategory("Report result file");


// Add some data
        $this->phpexcel->getActiveSheet()->setCellValue('A1', 'NIVELES DE ACTIVIDAD');
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getAlignment()->setIndent(1);
        $this->phpexcel->getActiveSheet()->mergeCells('A1:D1');
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getProtection()->setLocked(PHPExcel_Style_Protection::PROTECTION_UNPROTECTED);
        // Set fonts
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->setName('Candara');
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->setSize(20);
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->setBold(true);
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->setUnderline(PHPExcel_Style_Font::UNDERLINE_SINGLE);
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);

        $this->phpexcel->getActiveSheet()->getColumnDimension('A')->setAutoSize(true);
        $this->phpexcel->getActiveSheet()->setCellValue('A4', 'TOTAL PROVINCIAL');
        $this->phpexcel->getActiveSheet()->getStyle('A4')->getAlignment()->setHorizontal(
                PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $this->phpexcel->getActiveSheet()->getStyle('A4')->applyFromArray($this->styles('blackStyle'));

        $this->phpexcel->getActiveSheet()->getStyle('A3')->applyFromArray($this->styles('headerStyle'));
        //NOMBRE DE LAS COLUMNAS
        $this->phpexcel->getActiveSheet()->setCellValue('A3', 'ENTIDAD/COMEDOR');
        $this->phpexcel->getActiveSheet()->getStyle('A3')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getActiveSheet()->setCellValue('B3', 'T.C.');
        $this->phpexcel->getActiveSheet()->getStyle('B3')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getActiveSheet()->setCellValue('C3', 'NIVEL DE ACT. PLAN');
        $this->phpexcel->getActiveSheet()->getStyle('C3')->getAlignment()->setTextRotation(90);
        $this->phpexcel->getActiveSheet()->getStyle('C3')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getActiveSheet()->setCellValue('D3', 'NIVEL DE ACT. REAL');
        $this->phpexcel->getActiveSheet()->getStyle('D3')->getAlignment()->setTextRotation(90);
        $this->phpexcel->getActiveSheet()->getStyle('D3')->applyFromArray($this->styles('headerStyle'));

        $this->phpexcel->getActiveSheet()->setCellValue('E2', 'EVENTOS');
        $this->phpexcel->getActiveSheet()->mergeCells('E2:G2');
        $this->phpexcel->getActiveSheet()->getStyle('E2')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getActiveSheet()->getStyle('E2')->getAlignment()->applyFromArray(array(
            'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER));
        $this->phpexcel->getActiveSheet()->getStyle('F2')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getActiveSheet()->getStyle('G2')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getActiveSheet()->setCellValue('E3', 'ALMUERZO');
        $this->phpexcel->getActiveSheet()->getStyle('E3')->getAlignment()->setTextRotation(90);
        $this->phpexcel->getActiveSheet()->getStyle('E3')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getActiveSheet()->setCellValue('F3', 'COMIDAS');
        $this->phpexcel->getActiveSheet()->getStyle('F3')->getAlignment()->setTextRotation(90);
        $this->phpexcel->getActiveSheet()->getStyle('F3')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getActiveSheet()->setCellValue('G3', 'MERIENDAS');
        $this->phpexcel->getActiveSheet()->getStyle('G3')->getAlignment()->setTextRotation(90);
        $this->phpexcel->getActiveSheet()->getStyle('G3')->applyFromArray($this->styles('headerStyle'));

        $indice_organismos = array();
        $x = 5;
        foreach ($organismos as $org) {
            $entityNames = BalanceAlimTable::getInstance()->entidadesPorOrganismo($time, $org['organismo_id']);
            $organism = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(0, $x, $org['organismo_nombre'], true);
            $this->phpexcel->getActiveSheet()->getStyle($organism->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($organism->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);

            $row_org = $x;
            $arr_temp = array();
            for ($index = 2; $index <= 6; $index++) {
                $total_coord = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, $x);
                array_push($arr_temp, $total_coord->getCoordinate());
            }
            array_push($indice_organismos, $arr_temp);

            $x = $x + 1;
            $total_1 = array();
            foreach ($entityNames as $en) {
                $arr = BalanceAlimTable::getInstance()->balance_alimentacion_tabla($en['entidad_id']);
                $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(0, $x, $en['entidad_nombre'], true);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setIndent(1);
                $a1 = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(1, $x);
                $this->phpexcel->getActiveSheet()->getStyle($a1->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                $total_cap_por_org = array();
                for ($index = 2; $index <= 6; $index++) {
                    $aa = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, $x);
                    $this->phpexcel->getActiveSheet()->getStyle($aa->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                    $this->phpexcel->getActiveSheet()->getStyle($aa->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                    $next = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, $x + 1);
                    $coord1 = $next->getCoordinate();
                    $last = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, count($arr) + $x);
                    $coord2 = $last->getCoordinate();
                    $total_coord = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($index, $x, '=SUM(' . $coord1 . ':' . $coord2 . ')', true);
                    array_push($total_cap_por_org, $total_coord->getCoordinate());
                }
                array_push($total_1, $total_cap_por_org);
                $x = $x + 1;
                foreach ($arr as $value) {
                    $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(0, $x, $value['comedor_nombre']);
                    $a = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(0, $x);
                    $coord_a = $a->getCoordinate();
                    $this->phpexcel->getActiveSheet()->getStyle($coord_a)->applyFromArray($this->styles('borderStyle'));
                    $this->phpexcel->getActiveSheet()->getStyle($coord_a)->getAlignment()->setIndent(2);

                    $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(1, $x, $value['comedor_tc']);
                    $b = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(1, $x);
                    $this->phpexcel->getActiveSheet()->getStyle($b->getCoordinate())->applyFromArray($this->styles('borderStyle'));

                    $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(2, $x, $value['fisico']);
                    $c = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(2, $x);
                    $this->phpexcel->getActiveSheet()->getStyle($c->getCoordinate())->applyFromArray($this->styles('borderStyle'));

                    $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(3, $x, $value['nivel_act']);
                    $d = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(3, $x);
                    $this->phpexcel->getActiveSheet()->getStyle($d->getCoordinate())->applyFromArray($this->styles('borderStyle'));

                    $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(4, $x, $value['almuerzo_evt']);
                    $e = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(4, $x);
                    $this->phpexcel->getActiveSheet()->getStyle($e->getCoordinate())->applyFromArray($this->styles('borderStyle'));

                    $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(5, $x, $value['comida_evt']);
                    $f = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(5, $x);
                    $this->phpexcel->getActiveSheet()->getStyle($f->getCoordinate())->applyFromArray($this->styles('borderStyle'));

                    $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(6, $x, $value['merienda_evt']);
                    $g = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(6, $x);
                    $this->phpexcel->getActiveSheet()->getStyle($g->getCoordinate())->applyFromArray($this->styles('borderStyle'));

                    $x = $x + 1;
                }
            }


            $total = array();
            foreach ($total_1[0] as $value) {
                array_push($total, $value);
            }
            //quitar el primer elemento de la lista
            array_shift($total_1);
            foreach ($total_1 as $arr) {
                for ($index = 0; $index < count($arr); $index++) {
                    $total[$index] = $total[$index] . '+' . $arr[$index];
                }
            }
            for ($index = 2; $index < 7; $index++) {
                $sum_coord = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($index, $row_org, '=' . $total[$index - 2], true);
                $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLACK);
                $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);
            }
        }
        //TOTAL GENERAL
        $total = array();
        foreach ($indice_organismos[0] as $value) {
            array_push($total, $value);
        }
        //quitar el primer elemento de la lista
        array_shift($indice_organismos);
        foreach ($indice_organismos as $arr) {
            for ($index = 0; $index < count($arr); $index++) {
                $total[$index] = $total[$index] . '+' . $arr[$index];
            }
        }

        for ($index = 2; $index < 7; $index++) {
            $sum_coord = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($index, 4, '=' . $total[$index - 2], true);
            $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLACK);
            $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->applyFromArray($this->styles('blackStyle'));
        }
        $coord = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(1, 4);
        $this->phpexcel->getActiveSheet()->getStyle($coord->getCoordinate())->applyFromArray($this->styles('blackStyle'));


        //$this->phpexcel->getActiveSheet()->fromArray($query, null, 'B5', false);
// Set fills
        $this->phpexcel->getActiveSheet()->getStyle('A1:G1')->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getActiveSheet()->getStyle('A1:G1')->getFill()->getStartColor()->setARGB('FF808080');
        $this->phpexcel->getActiveSheet()->getStyle('A2:D2')->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getActiveSheet()->getStyle('A2:D2')->getFill()->getStartColor()->setARGB('FF808080');

// Set header and footer. When no different headers for odd/even are used, odd header is assumed.
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddHeader('&RFecha &D');
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddFooter('&L&B' . $this->phpexcel->getProperties()->getTitle() . '&RPage &P of &N');

// Set page orientation and size
        $this->phpexcel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
        $this->phpexcel->getActiveSheet()->getPageSetup()->setPaperSize(PHPExcel_Worksheet_PageSetup::PAPERSIZE_LETTER);

// Rename first worksheet
        $this->phpexcel->getActiveSheet()->setTitle('NIVEL DE ACTIVIDAD');


// Set active sheet index to the first sheet, so Excel opens this as the first sheet
        $this->phpexcel->setActiveSheetIndex(0);

        return $this->phpexcel;
    }

    public function generar_xls_nivel_actividad($year) {
        $excel = $this->generar_reporte_nivel_actividad($year);
        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="nivel_actividad.xlsx"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($excel, 'Excel2007');
        $objWriter->save('php://output');
    }

    public function generar_pdf_nivel_actividad($year) {
        $this->load->library('mpdf');
        $excel = $this->generar_reporte_nivel_actividad($year);
        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/pdf');
        header('Content-Disposition: attachment;filename="nivel_actividad.pdf"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($excel, 'PDF');
        $objWriter->save('php://output');
    }

    public function test() {
        $time = date("Y") . '%';
        $result_query = BaseDatosTable::getInstance()->valor_producto_mes(11, 21);
        print_r($result_query[0]['norma']);
    }

    private function count_distinct($array, $array2, $nombre_columna) {
        $result = array();
        foreach ($array as $value) {
            $row = array();
            $count = 0;
            foreach ($array2 as $value2) {
                if ($value2[$nombre_columna] === $value[$nombre_columna]) {
                    $count = $count + 1;
                }
            }
            array_push($row, $value[$nombre_columna], $count);
            array_push($result, $row);
        }
        return $result;
    }

    public function boleta() {
        $proveedorid = $this->input->get_post('proveedor', TRUE);
        $mes = $this->input->get_post('mes', TRUE);
        $year = $this->input->get_post('year', TRUE);
        $mes_desc = $this->input->get_post('month_desc', TRUE);
        if ($year === '%') {
            $year = date("Y");
        }
        if ($mes === '%') {
            $mes = date("m");
        }
        if ($mes_desc === '%') {
            $mes_desc = "mes actual";
        }

        $time = $year . '-' . $mes . '%';

        $this->load->library('reports');
        $headers = $this->reports->headers_boleta($time, $proveedorid);

        $items3 = $this->entidades_boleta($time, $proveedorid);

        $valores = $this->matrix_de_valores_boleta($time, $proveedorid);

        $arr = $this->create_matrix_boleta($headers, $items3, $valores);


        $fields = "[{name: 'fecha', type: 'date',dateFormat: 'Y-m-d'},{name: 'consecutivo'},{name: 'nombre'}";
        $columns = "[ "
                . "{text: 'Fecha', width:75, dataIndex: 'fecha',xtype: 'datecolumn', format: 'd/m/Y'},"
                . "{text: '# de Boleta', width:65, dataIndex: 'consecutivo'},"
                . "{text: 'ENTIDAD',flex:1,summaryRenderer: function(value, summaryData, dataIndex) {
            return 'TOTAL'; 
        },minWidth:170,dataIndex: 'nombre'}";
        foreach ($headers as $value) {
            $data = $value['nombre_producto'];
            $fields = $fields . ",{name: '" . str_replace(" ", "", $data) . "',type: 'float'}";
            $columns = $columns . ",{text: '" . $data . "',flex:1,summaryType: 'sum',dataIndex: '" . str_replace(" ", "", $data) . "'}";
        }
        $fields = $fields . "]";
        $columns = $columns . "]";

        $data = "[";
        foreach ($items3 as $value) {
            $item = "['" . $value['fecha'] . "','" . $value['consecutivo'] . "','" . $value['nombre_entidad'] . "'";
            foreach ($headers as $v) {
                $item = $item . ",'" . $arr[$value['consecutivo']][$v['nombre_producto']] . "'";
            }
            $item = $item . "],";
            $data = $data . $item;
        }
        $data = $data . "]";

        $this->output->set_content_type('application/json')
                ->set_output(json_encode(array('fields' => $fields, 'columns' => $columns, 'data' => $data, 'fecha' => $mes_desc)));
    }

    private function headers_disponibilidad($time, $proveedor) {
        return Doctrine_Query::create()->select('disp.id, producto.nombre '
                                . 'as nombre_producto, proveedor.nombre as nombre_proveedor'
                                . ',producto.id as producto_id')
                        ->from('Disponibilidad disp')
                        ->innerJoin('disp.Producto producto')
                        ->innerJoin('producto.Proveedor proveedor')
                        ->where('disp.fecha like "' . $time . '"')
                        ->andWhere('proveedor.id = ?', $proveedor)
                        ->groupBy('producto.id')
                        ->orderBy('proveedor.nombre, producto.nombre')->execute()->toArray(true);
    }

    //REPORTE DISPONIBILIDAD
    private function proveedores_disponibilidad($mes, $year) {
        if ($mes === -1) {
            $mes = date("m");
        }
        $time = $year . '-' . $mes . '%';
        return Doctrine_Query::create()->select('proveedor.nombre as nombre_proveedor'
                                . ',disp.id,proveedor.id as proveedor_id')
                        ->from('Disponibilidad disp')
                        ->innerJoin('disp.Producto producto')
                        ->innerJoin('producto.Proveedor proveedor')
                        ->where('disp.fecha like "' . $time . '"')
                        ->groupBy('proveedor.id')
                        ->orderBy('proveedor.nombre')->execute()->toArray(true);
    }

    private function proveedores_boleta($mes, $year, $proveedor) {
        if ($mes === -1) {
            $mes = date("m");
        }
        $time = $year . '-' . $mes . '%';
        return Doctrine_Query::create()->select('boleta_producto.*, proveedor.nombre as nombre_proveedor'
                                . ',proveedor.id as proveedor_id,boleta.*,producto.*,proveedor.*,ent.*')
                        ->from('BoletaProducto boleta_producto')
                        ->innerJoin('boleta_producto.Boleta boleta')
                        ->innerJoin('boleta_producto.Producto producto')
                        ->innerJoin('producto.Proveedor proveedor')
                        ->innerJoin('boleta.Entidad ent')
                        ->where('boleta.fecha like "' . $time . '"')
                        ->andWhere('boleta.proveedor_id <> ?', $proveedor)
                        ->groupBy('proveedor.id')
                        ->orderBy('proveedor.nombre')->execute()->toArray(true);
    }

    private function entidades_boleta($time, $proveedor) {
        $query = Doctrine_Query::create()->select('boleta.id, boleta.fecha as fecha'
                        . ',boleta.consec as consecutivo, boleta.entidad_id as entidad_id, ent.nombre as nombre_entidad')
                ->from('Boleta boleta')
                ->innerJoin('boleta.Entidad ent')
                ->innerJoin('boleta.Proveedor prov')
                ->where('boleta.fecha like "' . $time . '"')
                ->andWhere('prov.id = ?', $proveedor)
                ->groupBy('boleta.consec')
                ->orderBy('boleta.consec');
        return $query->execute()->toArray(true);
    }

    private function matrix_de_valores_boleta($time, $proveedor) {
        return Doctrine_Query::create()->select('boleta_producto.*, '
                                . 'boleta_producto.cantidad as cantidad, '
                                . 'boleta.consec as consecutivo,p.nombre as nombre_producto'
                                . ', p.id as producto_id, boleta.id as boleta_id,boleta.*')
                        ->from('BoletaProducto boleta_producto')
                        ->innerJoin('boleta_producto.Boleta boleta')
                        ->innerJoin('boleta.Proveedor pro')
                        ->innerJoin('boleta_producto.Producto p')
                        ->where('boleta.fecha like "' . $time . '"')
                        ->andWhere('pro.id = ?', $proveedor)
                        ->execute()->toArray(true);
    }

    private function saldo_inicial_producto($time, $producto) {
        return Doctrine_Query::create()->select('sum(disponibilidad.saldo) as disponible, um.nombre as unidad_medida')
                        ->from('Disponibilidad disponibilidad')
                        ->innerJoin('disponibilidad.Producto prod')
                        ->innerJoin('prod.Um um')
                        ->where('disponibilidad.fecha like "' . $time . '"')
                        ->andWhere('disponibilidad.producto_id = ?', $producto)
                        ->execute()->toArray(true);
    }

    private function cantidad_entregada_producto($time, $producto) {
        return Doctrine_Query::create()->select('sum(boleta_producto.cantidad) as entregado')
                        ->from('BoletaProducto boleta_producto')
                        ->innerJoin('boleta_producto.Boleta boleta')
                        ->innerJoin('boleta_producto.Producto p')
                        ->where('boleta.fecha like "' . $time . '"')
                        ->andWhere('p.id = ?', $producto)
                        ->execute()->toArray(true);
    }

    private function create_matrix_boleta($headers, $index, $valores) {
        $arr = array();
        foreach ($index as $value) {
            $arr2 = array();
            foreach ($headers as $value2) {
                $arr2[$value2['nombre_producto']] = 0;
            }
            $arr[$value['consecutivo']] = $arr2;
        }
        foreach ($valores as $value) {
            $arr[$value['consecutivo']][$value['nombre_producto']] = $value['cantidad'];
        }
        return $arr;
    }

    private function generar_reporte_boleta($proveedorid, $nombre_proveedor, $mes, $year, $mes_desc, $xls) {
        if ($mes === -1) {
            $mes = date("m");
        }
        if ($mes_desc === -1) {
            $mes_desc = "mes actual";
        }

        $time = $year . '-' . $mes . '%';

        $this->load->library('reports');
        $headers = $this->reports->headers_boleta($time, $proveedorid);

        $items3 = $this->entidades_boleta($time, $proveedorid);

        $valores = $this->matrix_de_valores_boleta($time, $proveedorid);

        $arr = $this->create_matrix_boleta($headers, $items3, $valores);

        $this->load->library('phpexcel');

// Set document properties
        $this->phpexcel->getProperties()->setCreator("PHPExcel")
                ->setLastModifiedBy("PHPExcel")
                ->setTitle("Office 2007 XLSX Report Document")
                ->setSubject("Office 2007 XLSX Report Document")
                ->setDescription("Report document for Office 2007 XLSX, generated using PHP classes.")
                ->setKeywords("office 2007 openxml php")
                ->setCategory("Report result file");


        // Add data in row 1
        $objDrawing = new PHPExcel_Worksheet_Drawing();
        $objDrawing->setName('Logo');
        $objDrawing->setDescription('Logo');
        $objDrawing->setPath('./web/images/dpep.png');
        $objDrawing->setHeight(47);
        $objDrawing->setCoordinates('A1');
        $objDrawing->setWorksheet($this->phpexcel->getActiveSheet());
        $this->phpexcel->getActiveSheet()->setCellValue('B1', 'CONTROL DE BOLETAS ' . $nombre_proveedor . ' ' . $year);
        $this->phpexcel->getActiveSheet()->mergeCells('B1:E1');
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getProtection()->setLocked(PHPExcel_Style_Protection::PROTECTION_UNPROTECTED);

        $this->phpexcel->getActiveSheet()->getStyle('B1')->getFont()->setName('Candara');
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getFont()->setSize(16);
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getFont()->setBold(true);
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getFont()->setUnderline(PHPExcel_Style_Font::UNDERLINE_SINGLE);
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);

        //$this->phpexcel->getActiveSheet()->setCellValue('G1', PHPExcel_Shared_Date::PHPToExcel(gmmktime(0, 0, 0, date('m'), date('d'), date('Y'))));
        //$this->phpexcel->getActiveSheet()->getStyle('G1')->getNumberFormat()->setFormatCode(PHPExcel_Style_NumberFormat::FORMAT_DATE_XLSX15);
        //$this->phpexcel->getActiveSheet()->getStyle('G1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);

        $how_many_columns = count($headers) * 2 + 2;
        $lastCell = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($how_many_columns, 1);
        $this->phpexcel->getActiveSheet()->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getActiveSheet()->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->getStartColor()->setARGB('FF808080');

        //Add data in row 2
        $this->phpexcel->getActiveSheet()->getStyle('A2:C2')->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getActiveSheet()->getStyle('A2:C2')->getFill()->getStartColor()->setARGB('FF808080');
        $lastCell2 = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($how_many_columns, 2);
        $this->phpexcel->getActiveSheet()->getStyle('D2:' . $lastCell2->getCoordinate())->applyFromArray($this->styles('headerStyle'));

        //Add data in row 3
        $this->phpexcel->getActiveSheet()->setCellValue('A3', 'FECHA');
        $this->phpexcel->getActiveSheet()->setCellValue('B3', '# BOLETA');
        $this->phpexcel->getActiveSheet()->setCellValue('C3', 'ENTIDAD');
        $this->phpexcel->getActiveSheet()->getColumnDimension('C')->setAutoSize(true);
        $this->phpexcel->getActiveSheet()->getColumnDimension('A')->setAutoSize(true);
        $this->phpexcel->getActiveSheet()->getStyle('A3')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getActiveSheet()->getStyle('B3')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getActiveSheet()->getStyle('C3')->applyFromArray($this->styles('headerStyle'));
        $j = 3;
        foreach ($headers as $value) {
            $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($j, 3, $value['nombre_producto'], true);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setTextRotation(90);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('headerStyle'));

            $b = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($j, 2, 'Disp:', true);
            $b_coord = $b->getCoordinate();

            $array = $this->saldo_inicial_producto($time, $value['producto_id']);
            $disponible = $array[0]['disponible'];
            if (strlen($disponible) == 0) {
                $disponible = 0;
            }
            $c = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($j + 1, 2, $disponible, true);
            $c_coord = $c->getCoordinate();
            $this->phpexcel->getActiveSheet()->getStyle($b_coord . ":" . $c_coord)->applyFromArray($this->styles('headerStyle'));

            $d = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($j + 1, 3, 'Saldo', true);
            $this->phpexcel->getActiveSheet()->getStyle($d->getCoordinate())->applyFromArray($this->styles('headerStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($d->getCoordinate())->getAlignment()->setHorizontal(
                    PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
            $this->phpexcel->getActiveSheet()->getStyle($d->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);

            $j = $j + 2;
        }

        //Add data in row 4+
        $i = 4;
        $count_numRows = count($items3) + 3;
        foreach ($items3 as $value) {
            $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(0, $i, $value['fecha'], true);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
            $b = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(1, $i, $value['consecutivo'], true);
            $this->phpexcel->getActiveSheet()->getStyle($b->getCoordinate())->applyFromArray($this->styles('borderStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($b->getCoordinate())->getAlignment()->setHorizontal(
                    PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
            $c = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(2, $i, $value['nombre_entidad'], true);
            $this->phpexcel->getActiveSheet()->getStyle($c->getCoordinate())->applyFromArray($this->styles('borderStyle'));
            $j = 3;
            foreach ($headers as $v) {
                $d = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($j, $i, $arr[$value['consecutivo']][$v['nombre_producto']], true);
                $this->phpexcel->getActiveSheet()->getStyle($d->getCoordinate())->applyFromArray($this->styles('borderStyle'));

                if ($i == 4) {
                    $disponibleCell = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($j + 1, $i - 2)->getCoordinate();
                    $saldoCell = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getCoordinate();
                    $x = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($j + 1, $i, '=' . $disponibleCell . '-' . $saldoCell, true);
                    $this->phpexcel->getActiveSheet()->getStyle($x->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                } else {
                    $disponibleCell = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($j + 1, $i - 1)->getCoordinate();
                    $saldoCell = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($j, $i)->getCoordinate();
                    $x = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($j + 1, $i, '=' . $disponibleCell . '-' . $saldoCell, true);
                    $this->phpexcel->getActiveSheet()->getStyle($x->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                }
                if ($count_numRows == $i) {
                    $coordenada = $x->getCoordinate();
                    if (intval($x->getCalculatedValue()) < 0) {
                        $this->phpexcel->getActiveSheet()->getStyle($coordenada)->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);
                    } else {
                        $columnTitle = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($j + 1, 3)->getCoordinate();
                        $this->phpexcel->getActiveSheet()->getStyle($coordenada)->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                        $this->phpexcel->getActiveSheet()->getStyle($columnTitle)->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                    }
                }
                $j = $j + 2;
            }
            $i = $i + 1;
        }
        //Totales
        $total = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(0, $i, "TOTAL", true);
        $this->phpexcel->getActiveSheet()->getStyle($total->getCoordinate())->applyFromArray($this->styles('blackStyle'));
        $one = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(1, $i, "", true);
        $this->phpexcel->getActiveSheet()->getStyle($one->getCoordinate())->applyFromArray($this->styles('blackStyle'));
        $two = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(2, $i, "", true);
        $this->phpexcel->getActiveSheet()->getStyle($two->getCoordinate())->applyFromArray($this->styles('blackStyle'));
        $index = 3;
        for ($iter = 0; $iter < count($headers); $iter++) {
            $saldoCell = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, 4)->getCoordinate();
            $saldoCell2 = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, count($items3) + 3)->getCoordinate();
            $total = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($index, $i, "=SUM(" . $saldoCell . ":" . $saldoCell2 . ")", true);
            $this->phpexcel->getActiveSheet()->getStyle($total->getCoordinate())->applyFromArray($this->styles('blackStyle'));

            $nextCell = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index + 1, $i)->getCoordinate();
            $this->phpexcel->getActiveSheet()->getStyle($nextCell)->applyFromArray($this->styles('blackStyle'));
            $index = $index + 2;
        }

// Set header and footer. When no different headers for odd/even are used, odd header is assumed.
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddHeader('&RFecha &D');
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddFooter('&L&B' . $this->phpexcel->getProperties()->getTitle() . '&RPage &P of &N');

// Set page orientation and size
        $this->phpexcel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
        $this->phpexcel->getActiveSheet()->getPageSetup()->setPaperSize(PHPExcel_Worksheet_PageSetup::PAPERSIZE_LETTER);

// Rename first worksheet
        $this->phpexcel->getActiveSheet()->setTitle($nombre_proveedor);

        if ($xls) {
            $proveedores = $this->proveedores_boleta($mes, $year, $proveedorid);
            $i = 1;
            foreach ($proveedores as $value) {
                $newWorkSheet = new PHPExcel_Worksheet($this->phpexcel, $value['nombre_proveedor']);
                $this->phpexcel->addSheet($newWorkSheet, $i);

                $this->load->library('reports');
                $headers = $this->reports->headers_boleta($time, $value['proveedor_id']);

                $items3 = $this->entidades_boleta($time, $value['proveedor_id']);

                $valores = $this->matrix_de_valores_boleta($time, $value['proveedor_id']);

                $arr = $this->create_matrix_boleta($headers, $items3, $valores);

                // Add data in row 1
                // Add a drawing to the worksheet
                $objDrawing = new PHPExcel_Worksheet_Drawing();
                $objDrawing->setName('Logo');
                $objDrawing->setDescription('Logo');
                $objDrawing->setPath('./web/images/dpep.png');
                $objDrawing->setHeight(47);
                $objDrawing->setCoordinates('A1');
                $objDrawing->setWorksheet($this->phpexcel->getSheet($i));

                $this->phpexcel->getSheet($i)->setCellValue('B1', 'CONTROL DE BOLETAS ' . $value['nombre_proveedor'] . ' ' . $year);
                $this->phpexcel->getSheet($i)->mergeCells('B1:E1');
                $this->phpexcel->getSheet($i)->getStyle('B1')->getProtection()->setLocked(PHPExcel_Style_Protection::PROTECTION_UNPROTECTED);

                $this->phpexcel->getSheet($i)->getStyle('B1')->getFont()->setName('Candara');
                $this->phpexcel->getSheet($i)->getStyle('B1')->getFont()->setSize(16);
                $this->phpexcel->getSheet($i)->getStyle('B1')->getFont()->setBold(true);
                $this->phpexcel->getSheet($i)->getStyle('B1')->getFont()->setUnderline(PHPExcel_Style_Font::UNDERLINE_SINGLE);
                $this->phpexcel->getSheet($i)->getStyle('B1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);

                //$this->phpexcel->getSheet($i)->setCellValue('G1', PHPExcel_Shared_Date::PHPToExcel(gmmktime(0, 0, 0, date('m'), date('d'), date('Y'))));
                //$this->phpexcel->getSheet($i)->getStyle('G1')->getNumberFormat()->setFormatCode(PHPExcel_Style_NumberFormat::FORMAT_DATE_XLSX15);
                //$this->phpexcel->getSheet($i)->getStyle('G1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);

                $how_many_columns = count($headers) * 2 + 2;
                $lastCell = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($how_many_columns, 1);
                $this->phpexcel->getSheet($i)->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
                $this->phpexcel->getSheet($i)->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->getStartColor()->setARGB('FF808080');

                //Add data in row 2
                $this->phpexcel->getSheet($i)->getStyle('A2:C2')->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
                $this->phpexcel->getSheet($i)->getStyle('A2:C2')->getFill()->getStartColor()->setARGB('FF808080');
                $lastCell2 = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($how_many_columns, 2);
                $this->phpexcel->getSheet($i)->getStyle('D2:' . $lastCell2->getCoordinate())->applyFromArray($this->styles('headerStyle'));

                //Add data in row 3
                $this->phpexcel->getSheet($i)->setCellValue('A3', 'FECHA');
                $this->phpexcel->getSheet($i)->setCellValue('B3', '# BOLETA');
                $this->phpexcel->getSheet($i)->setCellValue('C3', 'ENTIDAD');
                $this->phpexcel->getSheet($i)->getColumnDimension('C')->setAutoSize(true);
                $this->phpexcel->getSheet($i)->getColumnDimension('A')->setAutoSize(true);
                $this->phpexcel->getSheet($i)->getStyle('A3')->applyFromArray($this->styles('headerStyle'));
                $this->phpexcel->getSheet($i)->getStyle('B3')->applyFromArray($this->styles('headerStyle'));
                $this->phpexcel->getSheet($i)->getStyle('C3')->applyFromArray($this->styles('headerStyle'));
                $j = 3;
                foreach ($headers as $value) {
                    $a = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($j, 3, $value['nombre_producto'], true);
                    $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->getAlignment()->setTextRotation(90);
                    $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->applyFromArray($this->styles('headerStyle'));

                    $b = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($j, 2, 'Disp:', true);
                    $b_coord = $b->getCoordinate();

                    $array = $this->saldo_inicial_producto($time, $value['producto_id']);
                    $disponible = $array[0]['disponible'];
                    if (strlen($disponible) == 0) {
                        $disponible = 0;
                    }
                    $c = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($j + 1, 2, $disponible, true);
                    $c_coord = $c->getCoordinate();
                    $this->phpexcel->getActiveSheet()->getStyle($b_coord . ":" . $c_coord)->applyFromArray($this->styles('headerStyle'));

                    $d = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($j + 1, 3, 'Saldo', true);
                    $this->phpexcel->getActiveSheet()->getStyle($d->getCoordinate())->applyFromArray($this->styles('headerStyle'));
                    $this->phpexcel->getActiveSheet()->getStyle($d->getCoordinate())->getAlignment()->setHorizontal(
                            PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
                    $this->phpexcel->getActiveSheet()->getStyle($d->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);

                    $j = $j + 2;
                }

                //Add data in row 4+
                $x = 4;
                $count_numRows = count($items3) + 3;
                foreach ($items3 as $value) {
                    $a = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow(0, $x, $value['fecha'], true);
                    $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                    $b = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow(1, $x, $value['consecutivo'], true);
                    $this->phpexcel->getSheet($i)->getStyle($b->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                    $this->phpexcel->getSheet($i)->getStyle($b->getCoordinate())->getAlignment()->setHorizontal(
                            PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
                    $c = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow(2, $x, $value['nombre_entidad'], true);
                    $this->phpexcel->getSheet($i)->getStyle($c->getCoordinate())->applyFromArray($this->styles('borderStyle'));

                    $j = 3;
                    foreach ($headers as $v) {
                        $d = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($j, $x, $arr[$value['consecutivo']][$v['nombre_producto']], true);
                        $this->phpexcel->getSheet($i)->getStyle($d->getCoordinate())->applyFromArray($this->styles('borderStyle'));

                        if ($x == 4) {
                            $disponibleCell = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($j + 1, $x - 2)->getCoordinate();
                            $saldoCell = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($j, $x)->getCoordinate();
                            $z = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($j + 1, $x, '=' . $disponibleCell . '-' . $saldoCell, true);
                            $this->phpexcel->getSheet($i)->getStyle($z->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                        } else {
                            $disponibleCell = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($j + 1, $x - 1)->getCoordinate();
                            $saldoCell = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($j, $x)->getCoordinate();
                            $z = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($j + 1, $x, '=' . $disponibleCell . '-' . $saldoCell, true);
                            $this->phpexcel->getSheet($i)->getStyle($z->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                        }
                        if ($count_numRows == $x) {
                            $coordenada = $z->getCoordinate();
                            if (intval($z->getCalculatedValue()) < 0) {
                                $this->phpexcel->getSheet($i)->getStyle($coordenada)->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);
                            } else {
                                $columnTitle = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($j + 1, 3)->getCoordinate();
                                $this->phpexcel->getSheet($i)->getStyle($coordenada)->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                                $this->phpexcel->getSheet($i)->getStyle($columnTitle)->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                            }
                        }

                        $j = $j + 2;
                    }
                    $x = $x + 1;
                }
                //Totales
                $total = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow(0, $x, "TOTAL", true);
                $this->phpexcel->getSheet($i)->getStyle($total->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                $one = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow(1, $x, "", true);
                $this->phpexcel->getSheet($i)->getStyle($one->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                $two = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow(2, $x, "", true);
                $this->phpexcel->getSheet($i)->getStyle($two->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                $index = 3;
                for ($iter = 0; $iter < count($headers); $iter++) {
                    $saldoCell = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($index, 4)->getCoordinate();
                    $saldoCell2 = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($index, count($items3) + 3)->getCoordinate();
                    $total = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($index, $x, "=SUM(" . $saldoCell . ":" . $saldoCell2 . ")", true);
                    $this->phpexcel->getSheet($i)->getStyle($total->getCoordinate())->applyFromArray($this->styles('blackStyle'));

                    $nextCell = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($index + 1, $x)->getCoordinate();
                    $this->phpexcel->getSheet($i)->getStyle($nextCell)->applyFromArray($this->styles('blackStyle'));
                    $index = $index + 2;
                }


// Set header and footer. When no different headers for odd/even are used, odd header is assumed.
                $this->phpexcel->getSheet($i)->getHeaderFooter()->setOddHeader('&RFecha &D');

// Set page orientation and size
                $this->phpexcel->getSheet($i)->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
                $this->phpexcel->getSheet($i)->getPageSetup()->setPaperSize(PHPExcel_Worksheet_PageSetup::PAPERSIZE_LETTER);
                $i = $i + 1;
            }
        }

        // Set active sheet index to the first sheet, so Excel opens this as the first sheet
        $this->phpexcel->setActiveSheetIndex(0);
        return $this->phpexcel;
    }

    public function generar_xls_boleta($proveedorid, $nombre_proveedor, $mes, $year, $mes_desc) {
        $excel = $this->generar_reporte_boleta($proveedorid, $nombre_proveedor, $mes, $year, $mes_desc, true);

        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        if (!$mes || $mes === '%' || $mes == -1) {
            $mes = date("m");
        }
        $mes = $this->mes($mes);
        header('Content-Disposition: attachment;filename="boleta-' . $mes . '.xlsx"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($excel, 'Excel2007');
        $objWriter->save('php://output');
    }

    public function generar_pdf_boleta($proveedorid, $nombre_proveedor, $mes, $year, $mes_desc) {
        $this->load->library('mpdf');
        $excel = $this->generar_reporte_boleta($proveedorid, $nombre_proveedor, $mes, $year, $mes_desc, false);
        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/pdf');
        header('Content-Disposition: attachment;filename="boleta.pdf"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($excel, 'PDF');
        $objWriter->save('php://output');
    }

    public function generar_xls_disp($mes, $year) {
        $excel = $this->generar_reporte_disponibilidad($mes, $year);

        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        if (!$mes || $mes === '%' || $mes == -1) {
            $mes = date("m");
        }
        $mes = $this->mes($mes);
        header('Content-Disposition: attachment;filename="disponibilidad-' . $mes . '.xlsx"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($excel, 'Excel2007');
        $objWriter->save('php://output');
    }

    public function generar_pdf_disp($mes, $year) {
        $this->load->library('mpdf');
        $excel = $this->generar_reporte_disponibilidad($mes, $year);
        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/pdf');
        if (!$mes || $mes === '%' || $mes == -1) {
            $mes = date("m");
        }
        $mes = $this->mes($mes);
        header('Content-Disposition: attachment;filename="disponibilidad-' . $mes . '.pdf"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($excel, 'PDF');
        $objWriter->save('php://output');
    }

    private function generar_reporte_disponibilidad($mes, $year) {
        if (!$year || $year === '%') {
            $year = date("Y");
        }
        if (!$mes || $mes === '%' || $mes == -1) {
            $mes = date("m");
        }
        $temp = $year . '-' . $mes . '%';

        $proveedores = $this->proveedores_disponibilidad($mes, $year);

// Create new PHPExcel object
        $this->load->library('phpexcel');

// Set document properties
        $this->phpexcel->getProperties()->setCreator("PHPExcel")
                ->setLastModifiedBy("PHPExcel")
                ->setTitle("Office 2007 XLSX Report Document")
                ->setSubject("Office 2007 XLSX Report Document")
                ->setDescription("Report document for Office 2007 XLSX, generated using PHP classes.")
                ->setKeywords("office 2007 openxml php")
                ->setCategory("Report result file");

// Add some data in row 2
        $this->phpexcel->getActiveSheet()->setCellValue('B2', 'DIRECCION PROVINCIAL DE ECONOMIA Y PLANIFICACION');
        $this->phpexcel->getActiveSheet()->getStyle('B2')->getFont()->setSize(12);
        $this->phpexcel->getActiveSheet()->mergeCells('B2:F2');
        $this->phpexcel->getActiveSheet()->getColumnDimension('A')->setWidth(2);
        $this->phpexcel->getActiveSheet()->getColumnDimension('B')->setWidth(40);
        $this->phpexcel->getActiveSheet()->getColumnDimension('D')->setWidth(15);
        $this->phpexcel->getActiveSheet()->getColumnDimension('F')->setWidth(30);
        $this->phpexcel->getActiveSheet()->getStyle('B2')->getAlignment()->setHorizontal(
                PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $this->phpexcel->getActiveSheet()->getStyle('B2')->getFont()->setName('Arial');
        $this->phpexcel->getActiveSheet()->getStyle('B2')->getFont()->setItalic(true);
        $this->phpexcel->getActiveSheet()->getStyle('B2:F2')->applyFromArray($this->styles('blackStyle'));

        // Add some data in row 3
        $this->phpexcel->getActiveSheet()->setCellValue('B3', 'CAMAGÜEY');
        $this->phpexcel->getActiveSheet()->getStyle('B3')->getFont()->setSize(12);
        $this->phpexcel->getActiveSheet()->mergeCells('B3:F3');
        $this->phpexcel->getActiveSheet()->getStyle('B3')->getAlignment()->setHorizontal(
                PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $this->phpexcel->getActiveSheet()->getStyle('B3')->getFont()->setName('Arial');
        $this->phpexcel->getActiveSheet()->getStyle('B3')->getFont()->setItalic(true);
        $this->phpexcel->getActiveSheet()->getStyle('B3:F3')->applyFromArray($this->styles('blackStyle'));

        // Add some data in row 4
        $this->phpexcel->getActiveSheet()->setCellValue('B4', 'San Pablo # 104 % Martí y Luaces Tel. 295637');
        $this->phpexcel->getActiveSheet()->getStyle('B4')->getFont()->setSize(12);
        $this->phpexcel->getActiveSheet()->mergeCells('B4:F4');
        $this->phpexcel->getActiveSheet()->getStyle('B4')->getAlignment()->setHorizontal(
                PHPExcel_Style_Alignment::HORIZONTAL_RIGHT);
        $this->phpexcel->getActiveSheet()->getStyle('B4')->getFont()->setName('Arial');
        $this->phpexcel->getActiveSheet()->getStyle('B4')->getFont()->setItalic(true);
        $this->phpexcel->getActiveSheet()->getStyle('B4:F4')->applyFromArray($this->styles('blackStyle'));

        // Add some data in row 5
        $this->phpexcel->getActiveSheet()->setCellValue('B5', 'Email:boletas@dpepcmg.mep.gov.cu');
        $this->phpexcel->getActiveSheet()->getStyle('B5')->getFont()->setSize(12);
        $this->phpexcel->getActiveSheet()->mergeCells('B5:F5');
        $this->phpexcel->getActiveSheet()->getStyle('B5')->getAlignment()->setHorizontal(
                PHPExcel_Style_Alignment::HORIZONTAL_RIGHT);
        $this->phpexcel->getActiveSheet()->getStyle('B5')->getFont()->setName('Arial');
        $this->phpexcel->getActiveSheet()->getStyle('B5')->getFont()->setItalic(true);
        $this->phpexcel->getActiveSheet()->getStyle('B5:F5')->applyFromArray($this->styles('blackStyle'));

        // Add a drawing to the worksheet
        $objDrawing = new PHPExcel_Worksheet_Drawing();
        $objDrawing->setName('Paid');
        $objDrawing->setDescription('Paid');
        $objDrawing->setPath('./web/images/dpep.png');
        $objDrawing->setCoordinates('B3');
        $objDrawing->setOffsetX(25);
        $objDrawing->setRotation(0);
        $objDrawing->getShadow()->setVisible(true);
        $objDrawing->getShadow()->setDirection(45);
        $objDrawing->setWorksheet($this->phpexcel->getActiveSheet());

        // Add some data in row 6
        $this->phpexcel->getActiveSheet()->setCellValue('B6', PHPExcel_Shared_Date::PHPToExcel(gmmktime(0, 0, 0, date('m'), date('d'), date('Y'))));
        $this->phpexcel->getActiveSheet()->getStyle('B6')->getNumberFormat()->setFormatCode(PHPExcel_Style_NumberFormat::FORMAT_DATE_XLSX15);
        $this->phpexcel->getActiveSheet()->getStyle('B6')->getFont()->setSize(12);
        $this->phpexcel->getActiveSheet()->mergeCells('B6:F6');
        $this->phpexcel->getActiveSheet()->getStyle('B6')->getAlignment()->setHorizontal(
                PHPExcel_Style_Alignment::HORIZONTAL_LEFT);
        $this->phpexcel->getActiveSheet()->getStyle('B6')->getFont()->setName('Arial');
        $this->phpexcel->getActiveSheet()->getStyle('B6')->getFont()->setItalic(true);
        $this->phpexcel->getActiveSheet()->getStyle('B6:F6')->applyFromArray($this->styles('blackStyle'));

        // Add some data in row 7
        $this->phpexcel->getActiveSheet()->getStyle('B7')->getFont()->setSize(12);
        $this->phpexcel->getActiveSheet()->mergeCells('B7:F7');
        $this->phpexcel->getActiveSheet()->getStyle('B7')->getAlignment()->setHorizontal(
                PHPExcel_Style_Alignment::HORIZONTAL_LEFT);
        $this->phpexcel->getActiveSheet()->getStyle('B7')->getFont()->setName('Arial');
        $this->phpexcel->getActiveSheet()->getStyle('B7')->getFont()->setItalic(true);
        $this->phpexcel->getActiveSheet()->getStyle('B7:F7')->applyFromArray($this->styles('blackStyle'));

        // Add some data in row 8
        $this->phpexcel->getActiveSheet()->setCellValue('B8', 'DISPONIBILIDAD DE LA RESERVA DEL CAP');
        $this->phpexcel->getActiveSheet()->getStyle('B8')->getFont()->setSize(14);
        $this->phpexcel->getActiveSheet()->mergeCells('B8:F8');
        $this->phpexcel->getActiveSheet()->getStyle('B8')->getAlignment()->setHorizontal(
                PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $this->phpexcel->getActiveSheet()->getStyle('B8')->getFont()->setName('Arial');
        $this->phpexcel->getActiveSheet()->getStyle('B8')->getFont()->setItalic(true);
        $this->phpexcel->getActiveSheet()->getStyle('B8:F8')->applyFromArray($this->styles('blackStyle'));

        // Add some data in row 9
        $this->phpexcel->getActiveSheet()->setCellValue('B9', 'PROVEEDOR / PRODUCTOS');
        $this->phpexcel->getActiveSheet()->getStyle('B9')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);
        $this->phpexcel->getActiveSheet()->getStyle('B9')->getFont()->setSize(12);
        $this->phpexcel->getActiveSheet()->getStyle('B9')->getFont()->setName('Arial');
        $this->phpexcel->getActiveSheet()->getStyle('B9')->getFont()->setItalic(true);
        $this->phpexcel->getActiveSheet()->getStyle('B9')->applyFromArray($this->styles('blackStyle'));
        $this->phpexcel->getActiveSheet()->getStyle('C9:F9')->getAlignment()->setWrapText(true);
        $this->phpexcel->getActiveSheet()->setCellValue('C9', 'U.M.');
        $this->phpexcel->getActiveSheet()->getStyle('C9')->getFont()->setSize(12);
        $this->phpexcel->getActiveSheet()->getStyle('C9')->getAlignment()->setHorizontal(
                PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $this->phpexcel->getActiveSheet()->getStyle('C9')->getFont()->setName('Arial');
        $this->phpexcel->getActiveSheet()->getStyle('C9')->getFont()->setItalic(true);
        $this->phpexcel->getActiveSheet()->getStyle('C9')->applyFromArray($this->styles('blackStyle'));
        $this->phpexcel->getActiveSheet()->setCellValue('D9', 'Saldo inicial');
        $this->phpexcel->getActiveSheet()->getColumnDimension('D')->setWidth(11);
        $this->phpexcel->getActiveSheet()->getStyle('D9')->getFont()->setSize(12);
        $this->phpexcel->getActiveSheet()->getStyle('D9')->getAlignment()->setHorizontal(
                PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $this->phpexcel->getActiveSheet()->getStyle('D9')->getFont()->setName('Arial');
        $this->phpexcel->getActiveSheet()->getStyle('D9')->getFont()->setItalic(true);
        $this->phpexcel->getActiveSheet()->getStyle('D9')->applyFromArray($this->styles('blackStyle'));

        $this->phpexcel->getActiveSheet()->setCellValue('E9', 'Entregado hasta la fecha');
        $this->phpexcel->getActiveSheet()->getColumnDimension('E')->setWidth(15);
        $this->phpexcel->getActiveSheet()->getStyle('E9')->getFont()->setSize(12);
        $this->phpexcel->getActiveSheet()->getStyle('E9')->getAlignment()->setHorizontal(
                PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $this->phpexcel->getActiveSheet()->getStyle('E9')->getFont()->setName('Arial');
        $this->phpexcel->getActiveSheet()->getStyle('E9')->getFont()->setItalic(true);
        $this->phpexcel->getActiveSheet()->getStyle('E9')->applyFromArray($this->styles('blackStyle'));

        $this->phpexcel->getActiveSheet()->setCellValue('F9', 'Disponibilidad');
        $this->phpexcel->getActiveSheet()->getColumnDimension('F')->setWidth(20);
        $this->phpexcel->getActiveSheet()->getStyle('F9')->getFont()->setSize(12);
        $this->phpexcel->getActiveSheet()->getStyle('F9')->getAlignment()->setHorizontal(
                PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $this->phpexcel->getActiveSheet()->getStyle('F9')->getFont()->setName('Arial');
        $this->phpexcel->getActiveSheet()->getStyle('F9')->getFont()->setItalic(true);
        $this->phpexcel->getActiveSheet()->getStyle('F9')->applyFromArray($this->styles('blackStyle'));

        //Dynamic data
        $iter = 10;
        foreach ($proveedores as $proveedor) {
            $col = 1;
            $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col, $iter, $proveedor['nombre_proveedor'], true);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getFont()->setSize(12);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getFont()->setName('Arial');
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getFont()->setItalic(true);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);
            for ($index = 2; $index < 6; $index++) {
                $b = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, $iter);
                $this->phpexcel->getActiveSheet()->getStyle($b->getCoordinate())->applyFromArray($this->styles('borderStyle'));
            }
            $iter = $iter + 1;
            $headers = $this->headers_disponibilidad($temp, $proveedor['proveedor_id']);
            foreach ($headers as $val) {
                $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col, $iter, $val['nombre_producto'], true);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setIndent(1);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getFont()->setSize(12);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getFont()->setName('Arial');
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getFont()->setItalic(true);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));

                $array = $this->saldo_inicial_producto($temp, $val['producto_id']);
                $array2 = $this->cantidad_entregada_producto($temp, $val['producto_id']);
                $saldo_inicial = $array[0]['disponible'];
                $unidad_medida = $array[0]['unidad_medida'];
                $entregado = $array2[0]['entregado'];
                if (!$entregado) {
                    $entregado = 0;
                }

                //Unidad de medida
                $s = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col + 1, $iter, $unidad_medida, true);
                $this->phpexcel->getActiveSheet()->getStyle($s->getCoordinate())->getFont()->setSize(12);
                $this->phpexcel->getActiveSheet()->getStyle($s->getCoordinate())->getFont()->setName('Arial');
                $this->phpexcel->getActiveSheet()->getStyle($s->getCoordinate())->getFont()->setItalic(true);
                $this->phpexcel->getActiveSheet()->getStyle($s->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($s->getCoordinate())->getAlignment()->setHorizontal(
                        PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

                //Saldo inicial
                $t = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col + 2, $iter, $saldo_inicial, true);
                $saldo_coor = $t->getCoordinate();
                $this->phpexcel->getActiveSheet()->getStyle($t->getCoordinate())->getFont()->setSize(12);
                $this->phpexcel->getActiveSheet()->getStyle($t->getCoordinate())->getFont()->setName('Arial');
                $this->phpexcel->getActiveSheet()->getStyle($t->getCoordinate())->getFont()->setItalic(true);
                $this->phpexcel->getActiveSheet()->getStyle($t->getCoordinate())->applyFromArray($this->styles('borderStyle'));

                //Entregado hasta la fecha
                $u = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col + 3, $iter, $entregado, true);
                $entrega_coor = $u->getCoordinate();
                $this->phpexcel->getActiveSheet()->getStyle($u->getCoordinate())->getFont()->setSize(12);
                $this->phpexcel->getActiveSheet()->getStyle($u->getCoordinate())->getFont()->setName('Arial');
                $this->phpexcel->getActiveSheet()->getStyle($u->getCoordinate())->getFont()->setItalic(true);
                $this->phpexcel->getActiveSheet()->getStyle($u->getCoordinate())->applyFromArray($this->styles('borderStyle'));

                //Disponibilidad
                $dispon = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col + 4, $iter, "=" . $saldo_coor . "-" . $entrega_coor, true);
                $this->phpexcel->getActiveSheet()->getStyle($dispon->getCoordinate())->getFont()->setSize(12);
                $this->phpexcel->getActiveSheet()->getStyle($dispon->getCoordinate())->getFont()->setName('Arial');
                $this->phpexcel->getActiveSheet()->getStyle($dispon->getCoordinate())->getFont()->setItalic(true);
                $this->phpexcel->getActiveSheet()->getStyle($dispon->getCoordinate())->applyFromArray($this->styles('borderStyle'));

                $iter = $iter + 1;
            }
        }


// Set header and footer. When no different headers for odd/even are used, odd header is assumed.
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddHeader('&RFecha &D');
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddFooter('&L&B' . $this->phpexcel->getProperties()->getTitle() . '&RPage &P of &N');

// Set page orientation and size
        $this->phpexcel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
        $this->phpexcel->getActiveSheet()->getPageSetup()->setPaperSize(PHPExcel_Worksheet_PageSetup::PAPERSIZE_LETTER);

// Rename first worksheet
        $this->phpexcel->getActiveSheet()->setTitle('DISPONIBILIDAD');


// Set active sheet index to the first sheet, so Excel opens this as the first sheet
        $this->phpexcel->setActiveSheetIndex(0);

        return $this->phpexcel;
    }

    private function headers_eventos($time) {
        return Doctrine_Query::create()->select('evento.id, producto.id as producto_id, producto.nombre '
                                . 'as nombre_producto, proveedor.nombre as nombre_proveedor'
                                . ',evento.cant as cantidad, ent.nombre as nombre_entidad')
                        ->from('Eventos evento')
                        ->innerJoin('evento.Producto producto')
                        ->innerJoin('evento.Entidad ent')
                        ->innerJoin('producto.Proveedor proveedor')
                        ->where('evento.fecha like "' . $time . '"')
                        ->groupBy('producto.id')
                        ->orderBy('proveedor.nombre, producto.nombre')->execute()->toArray(true);
    }

    /**
     * Buscar los proveedores de los productos del evento agrupados por producto
     * @param type $time
     * @return type
     */
    private function proveedores_eventos2($time) {
        return Doctrine_Query::create()
                        ->select('producto.id, proveedor.nombre as nombre')
                        ->from('NomProducto producto')->innerJoin('producto.Proveedor proveedor')
                        ->innerJoin('producto.Eventos evento')
                        ->where('evento.fecha like "' . $time . '"')
                        ->groupBy('producto.id')
                        ->orderBy('proveedor.nombre, producto.nombre')
                        ->execute()->toArray(true);
    }

    /**
     * Buscar los proveedores de los productos del evento agrupados por proveedor
     * @param type $time
     * @return type
     */
    private function proveedores_eventos($time) {
        return Doctrine_Query::create()
                        ->select('producto.id, proveedor.nombre as nombre')
                        ->from('NomProducto producto')->innerJoin('producto.Proveedor proveedor')
                        ->innerJoin('producto.Eventos evento')
                        ->where('evento.fecha like "' . $time . '"')
                        ->groupBy('proveedor.id')
                        ->orderBy('proveedor.nombre, producto.nombre')
                        ->execute()->toArray(true);
    }

    /**
     * Buscar las entidades del evento
     * @param type $time
     * @return type
     */
    private function entidades_eventos($time) {
        return Doctrine_Query::create()->select('evento.id, ent.reeup as reeup, ent.nombre '
                                . 'as nombre_entidad, org.nombre as org_nombre')
                        ->from('Eventos evento')
                        ->innerJoin('evento.Entidad ent')
                        ->innerJoin('evento.Producto producto')
                        ->innerJoin('ent.Organismo org')
                        ->where('evento.fecha like "' . $time . '"')
                        ->groupBy('ent.id')
                        ->orderBy('nombre_entidad')
                        ->execute()->toArray(true);
    }

    private function entidades_por_organismo_eventos($time, $organ) {
        return Doctrine_Query::create()->select('evento.id,  ent.id as entidad_id, ent.reeup as reeup, ent.nombre '
                                . 'as nombre_entidad, org.nombre as org_nombre')
                        ->from('Eventos evento')
                        ->innerJoin('evento.Entidad ent')
                        ->innerJoin('evento.Producto producto')
                        ->innerJoin('ent.Organismo org')
                        ->where('evento.fecha like "' . $time . '"' . ' and org.nombre like "' . $organ . '"')
                        ->groupBy('ent.id')
                        ->orderBy('nombre_entidad')
                        ->execute()->toArray(true);
    }

    private function organismos_eventos($time) {
        return Doctrine_Query::create()->select('evento.id, org.nombre as org_nombre')
                        ->from('Eventos evento')
                        ->innerJoin('evento.Entidad ent')
                        ->innerJoin('evento.Producto producto')
                        ->innerJoin('ent.Organismo org')
                        ->where('evento.fecha like "' . $time . '"')
                        ->groupBy('org.id')
                        ->orderBy('org_nombre')
                        ->execute()->toArray(true);
    }

    private function organismos_eventos2($time) {
        return Doctrine_Query::create()->select('evento.id, org.nombre as org_nombre')
                        ->from('Eventos evento')
                        ->innerJoin('evento.Entidad ent')
                        ->innerJoin('evento.Producto producto')
                        ->innerJoin('ent.Organismo org')
                        ->where('evento.fecha like "' . $time . '"')
                        ->groupBy('ent.id')
                        ->execute()->toArray(true);
    }

    private function matrix_de_valores_eventos($time) {
        return Doctrine_Query::create()->select('evento.id, producto.nombre '
                                . 'as nombre_producto, proveedor.nombre as nombre_proveedor'
                                . ',evento.cant as cantidad, ent.nombre as nombre_entidad')
                        ->from('Eventos evento')
                        ->innerJoin('evento.Producto producto')
                        ->innerJoin('evento.Entidad ent')
                        ->innerJoin('producto.Proveedor proveedor')
                        ->where('evento.fecha like "' . $time . '"')
                        ->orderBy('proveedor.nombre, producto.nombre')
                        ->execute()->toArray(true);
    }

    public function eventos($mes, $year) {
        if (!$year || $year === '%') {
            $year = date("Y");
        }
        if (!$mes || $mes === '%' || $mes == -1) {
            $mes = date("m");
        }
        $temp = $year . '-' . $mes . '%';

        $headers = $this->headers_eventos($temp);

        $entidades = $this->entidades_eventos($temp);

        $cantidades = $this->matrix_de_valores_eventos($temp);

        $arr = $this->create_matrix($headers, $entidades, $cantidades);

        // Estas variables son para crear un grid dinamico
        $fields = "[ {name: 'REEUP'},{name: 'org_nombre'},{name: 'nombre'}";
        $columns = "[ "
                . "{text: 'REEUP', dataIndex: 'REEUP'},"
                . "{text: 'ENTIDAD/COMEDOR',flex:1,minWidth:170,dataIndex: 'nombre'}";
        foreach ($headers as $value) {
            $data = $value['nombre_producto'];
            $fields = $fields . ",{name: '" . str_replace(" ", "", $data) . "',type: 'float'}";
            $columns = $columns . ",{text: '" . $data . "',flex:1,summaryType: 'sum',dataIndex: '" . str_replace(" ", "", $data) . "'}";
        }
        $fields = $fields . "]";
        $columns = $columns . "]";

        $data = "[";
        foreach ($entidades as $value) {
            $item = "['" . $value['reeup'] . "','" . $value['org_nombre'] . "','" . $value['nombre_entidad'] . "'";
            foreach ($headers as $v) {
                $item = $item . ",'" . $arr[$value['nombre_entidad']][$v['nombre_producto']] . "'";
            }
            $item = $item . "],";
            $data = $data . $item;
        }
        $data = $data . "]";
        $this->output->set_content_type('application/json')
                ->set_output(json_encode(array('fields' => $fields, 'columns' => $columns, 'data' => $data)));
    }

    public function generar_xls_evento($mes, $year) {
        $excel = $this->generar_reporte_evento($mes, $year);
        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        if (!$mes || $mes === '%' || $mes == -1) {
            $mes = date("m");
        }
        $mes = $this->mes($mes);
        header('Content-Disposition: attachment;filename="eventos-' . $mes . '-' . $year . '.xlsx"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($excel, 'Excel2007');
        $objWriter->save('php://output');
    }

    public function generar_pdf_evento($mes, $year) {
        $this->load->library('mpdf');
        $excel = $this->generar_reporte_evento($mes, $year);
        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/pdf');
        if (!$mes || $mes === '%' || $mes == -1) {
            $mes = date("m");
        }
        $mes = $this->mes($mes);
        header('Content-Disposition: attachment;filename="eventos-' . $mes . '-' . $year . '.pdf"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($excel, 'PDF');
        $objWriter->save('php://output');
    }

    private function generar_reporte_evento($mes, $year) {

        if (!$year || $year === '%') {
            $year = date("Y");
        }
        if (!$mes || $mes === '%' || $mes == -1) {
            $mes = date("m");
        }
        $temp = $year . '-' . $mes . '%';

        $headers = $this->headers_eventos($temp);

        $items3 = $this->entidades_eventos($temp);

        $org = $this->organismos_eventos($temp);
        $org2 = $this->organismos_eventos2($temp);
        $organismos = $this->count_distinct($org, $org2, 'org_nombre');

        $pr1 = $this->proveedores_eventos($temp);
        $pr2 = $this->proveedores_eventos2($temp);
        $proveedores = $this->count_distinct($pr1, $pr2, 'nombre');

        $items4 = $this->matrix_de_valores_eventos($temp);

        $arr = $this->create_matrix($headers, $items3, $items4);


// Create new PHPExcel object
        $this->load->library('phpexcel');

// Set document properties
        $this->phpexcel->getProperties()->setCreator("PHPExcel")
                ->setLastModifiedBy("PHPExcel")
                ->setTitle("Office 2007 XLSX Report Document")
                ->setSubject("Office 2007 XLSX Report Document")
                ->setDescription("Report document for Office 2007 XLSX, generated using PHP classes.")
                ->setKeywords("office 2007 openxml php")
                ->setCategory("Report result file");


// Add some data
        $this->phpexcel->getActiveSheet()->setCellValue('B1', 'EVENTOS');
        $this->phpexcel->getActiveSheet()->mergeCells('B1:C1');
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getProtection()->setLocked(PHPExcel_Style_Protection::PROTECTION_UNPROTECTED);
        // Set fonts
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getFont()->setName('Candara');
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getFont()->setSize(20);
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getFont()->setBold(true);
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getFont()->setUnderline(PHPExcel_Style_Font::UNDERLINE_SINGLE);
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);


//        $this->phpexcel->getActiveSheet()->setCellValue('E1', PHPExcel_Shared_Date::PHPToExcel(gmmktime(0, 0, 0, date('m'), date('d'), date('Y'))));
//        $this->phpexcel->getActiveSheet()->getStyle('E1')->getNumberFormat()->setFormatCode(PHPExcel_Style_NumberFormat::FORMAT_DATE_XLSX15);

        $this->phpexcel->getActiveSheet()->setCellValue('B3', 'ORGANISMO/ENTIDAD');
        $this->phpexcel->getActiveSheet()->setCellValue('A3', 'REEUP');
        $this->phpexcel->getActiveSheet()->getColumnDimension('B')->setAutoSize(true);
        $this->phpexcel->getActiveSheet()->setCellValue('B4', 'RESERVA DE BALANCE');
        $this->phpexcel->getActiveSheet()->getStyle('A4')->applyFromArray($this->styles('blackStyle'));
        $this->phpexcel->getActiveSheet()->getStyle('B4')->applyFromArray($this->styles('blackStyle'));

        $this->phpexcel->getActiveSheet()->getStyle('A3')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getActiveSheet()->getStyle('B3')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getActiveSheet()->getStyle('A2:B2')->applyFromArray($this->styles('headerStyle'));

        $reserva = array();
        $i = 5;
        foreach ($organismos as $value) {
            $firstCell = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(0, $i);
            $this->phpexcel->getActiveSheet()->getStyle($firstCell->getCoordinate())->applyFromArray($this->styles('borderStyle'));
            $coor = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(1, $i, $value[0], true);
            $this->phpexcel->getActiveSheet()->getStyle($coor->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);
            $this->phpexcel->getActiveSheet()->getStyle($coor->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $total_cap_por_org = array();
            for ($index = 2; $index <= count($headers) + 1; $index++) {
                $sum_coord = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, $i);
                $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                array_push($total_cap_por_org, $sum_coord->getCoordinate());
            }
            array_push($reserva, $total_cap_por_org);
            $row = $i;
            $i = $i + 1;
            $entidades = $this->entidades_por_organismo_eventos($temp, $value[0]);
            $subtotal = array();
            foreach ($entidades as $value2) {
                $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(1, $i, $value2['nombre_entidad'], true);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setIndent(1);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $b = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(0, $i, $value2['reeup'], true);
                $this->phpexcel->getActiveSheet()->getStyle($b->getCoordinate())->applyFromArray($this->styles('borderStyle'));

                //sumatoria almuerzo+comida+merienda
                $subtotal_fila = array();
                $x = 2;
                foreach ($headers as $val) {
                    $a = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($x, $i + 1);
                    $a_coor = $a->getCoordinate();
                    $b = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($x, $i + 3);
                    $b_coor = $b->getCoordinate();
                    $sumatoria = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($x, $i, '=SUM(' . $a_coor . ':' . $b_coor . ')', true);
                    $this->phpexcel->getActiveSheet()->getStyle($sumatoria->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                    array_push($subtotal_fila, $sumatoria->getCoordinate());
                    $x = $x + 1;
                }
                array_push($subtotal, $subtotal_fila);
                $i = $i + 1;

                //Almuerzo
                $first = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(0, $i);
                $this->phpexcel->getActiveSheet()->getStyle($first->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(1, $i, "Almuerzo", true);
                $almuerzo = $a->getCoordinate();
                $this->phpexcel->getActiveSheet()->getStyle($almuerzo)->applyFromArray($this->styles('borderStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($almuerzo)->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                $this->phpexcel->getActiveSheet()->getStyle($almuerzo)->getAlignment()->setIndent(2);
                $x = 2;
                foreach ($headers as $val) {
                    $bd = BaseDatosTable::getInstance()->eventos($year . '%', $value2['entidad_id'], $val['producto_id']);
                    foreach ($bd as $bd_iter) {
                        $alm = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($x, $i, $bd_iter['almuerzo'], true);
                        //-----Agregar Comentario-------
                        $alm_coord = $alm->getCoordinate();
                        $this->phpexcel->getActiveSheet()->getComment($alm_coord)->setAuthor('PHPExcel');
                        $objCommentRichText = $this->phpexcel->getActiveSheet()->getComment($alm_coord)->getText()->createTextRun('Fórmula:');
                        $objCommentRichText->getFont()->setBold(true);
                        $this->phpexcel->getActiveSheet()->getComment($alm_coord)->getText()->createTextRun("\r\n");
                        $this->phpexcel->getActiveSheet()->getComment($alm_coord)->getText()->createTextRun('Se multiplica el '
                                . 'valor del almuerzo(Nivel de actividad) del evento por el valor del producto(Base de datos).');
                        //-----------------------------

                        $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($x, $i + 1, $bd_iter['comida']);
                        $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($x, $i + 2, $bd_iter['merienda']);
                    }
                    $celda = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($x, $i);
                    $this->phpexcel->getActiveSheet()->getStyle($celda->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                    $celda = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($x, $i + 1);
                    $this->phpexcel->getActiveSheet()->getStyle($celda->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                    $celda = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($x, $i + 2);
                    $this->phpexcel->getActiveSheet()->getStyle($celda->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                    $x = $x + 1;
                }
                $i = $i + 1;

                //Comida
                $first = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(0, $i);
                $this->phpexcel->getActiveSheet()->getStyle($first->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(1, $i, "Comida", true);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setIndent(2);
                $i = $i + 1;

                //Merienda
                $first = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(0, $i);
                $this->phpexcel->getActiveSheet()->getStyle($first->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(1, $i, "Merienda", true);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setIndent(2);
                $i = $i + 1;

                //Conceptos
                $ev = EventosTable::getInstance()->eventos($year . '%', $value2['entidad_id']);
                foreach ($ev as $iter) {
                    $first = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(0, $i);
                    $this->phpexcel->getActiveSheet()->getStyle($first->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                    $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(1, $i, $iter['concepto'], true);
                    $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                    $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                    $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setIndent(2);

                    //Valor de los conceptos
                    $x = 2;
                    foreach ($headers as $val) {
                        $event = EventosTable::getInstance()->eventos_por_producto($year . '%', $value2['entidad_id'], $val['producto_id']);
                        foreach ($event as $event_iter) {
                            $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($x, $i, $event_iter['cantidad'], true);
                        }
                        $a = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($x, $i);
                        $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                        $x = $x + 1;
                    }
                    $i = $i + 1;
                }

                //Ajustes
                $first = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(0, $i);
                $this->phpexcel->getActiveSheet()->getStyle($first->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(1, $i, "Ajustes", true);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setIndent(2);
                $x = 2;
                foreach ($headers as $val) {
                    $a = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($x, $i);
                    $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                    $x = $x + 1;
                }
                $i = $i + 1;

                //%
                $first = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(0, $i);
                $this->phpexcel->getActiveSheet()->getStyle($first->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(1, $i, "%", true);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setIndent(2);
                $x = 2;
                foreach ($headers as $val) {
                    $a = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($x, $i);
                    $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                    $x = $x + 1;
                }
                $i = $i + 1;
            }

            //Subtotal por organismo
            $total = array();
            foreach ($subtotal[0] as $value) {
                array_push($total, $value);
            }
            //quitar el primer elemento de la lista
            array_shift($subtotal);
            foreach ($subtotal as $arr) {
                for ($index = 0; $index < count($arr); $index++) {
                    $total[$index] = $total[$index] . '+' . $arr[$index];
                }
            }
            for ($index = 2; $index <= count($headers) + 1; $index++) {
                $sum_coord = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($index, $row, '=' . $total[$index - 2], true);
                $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLACK);
                $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            }
        }
        $t = 2;
        foreach ($proveedores as $value) {
            $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($t, 2, $value[0], true);
            $coordA = $a->getCoordinate();
            $b = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($t + $value[1] - 1, 2);
            $coordB = $b->getCoordinate();
            $this->phpexcel->getActiveSheet()->mergeCells($coordA . ':' . $coordB);
            $this->phpexcel->getActiveSheet()->getStyle($coordA . ':' . $coordB)->applyFromArray($this->styles('headerStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($coordA . ':' . $coordB)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

            $t = $t + $value[1];
        }
        $j = 2;
        foreach ($headers as $value) {
            $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($j, 3, $value['nombre_producto'], true);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setTextRotation(90);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('headerStyle'));
            $j = $j + 1;
        }
        //$this->phpexcel->getActiveSheet()->fromArray($arr, null, 'B5', false);
        $this->phpexcel->getActiveSheet()->getStyle('E1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);

        //Crear formula para el total general
        $row_four = 4;
        $total = array();
        foreach ($reserva[0] as $value) {
            array_push($total, $value);
        }
        //quitar el primer elemento de la lista
        array_shift($reserva);
        foreach ($reserva as $arr) {
            for ($index = 0; $index < count($arr); $index++) {
                $total[$index] = $total[$index] . '+' . $arr[$index];
            }
        }
        for ($index = 2; $index <= count($headers) + 1; $index++) {
            $sum_coord = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($index, $row_four, '=' . $total[$index - 2], true);
            $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLACK);
            $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->applyFromArray($this->styles('blackStyle'));
        }


// Set fills
        $lastColumn_row1 = count($headers) + 1;
        $lastCell = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($lastColumn_row1, 1);
        $this->phpexcel->getActiveSheet()->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getActiveSheet()->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->getStartColor()->setARGB('FF808080');

// Set header and footer. When no different headers for odd/even are used, odd header is assumed.
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddHeader('&RFecha &D');
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddFooter('&L&B' . $this->phpexcel->getProperties()->getTitle() . '&RPage &P of &N');

// Set page orientation and size
        $this->phpexcel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
        $this->phpexcel->getActiveSheet()->getPageSetup()->setPaperSize(PHPExcel_Worksheet_PageSetup::PAPERSIZE_LETTER);

// Rename first worksheet
        $this->phpexcel->getActiveSheet()->setTitle('EVENTOS');


// Set active sheet index to the first sheet, so Excel opens this as the first sheet
        $this->phpexcel->setActiveSheetIndex(0);

        return $this->phpexcel;
    }

    private function arr_mes() {
        $items = array(
            '01' => "Enero",
            '02' => "Febrero",
            '03' => "Marzo",
            '04' => "Abril",
            '05' => "Mayo",
            '06' => "Junio",
            '07' => "Julio",
            '08' => "Agosto",
            '09' => "Septiembre",
            '10' => "Octubre",
            '11' => "Noviembre",
            '12' => "Diciembre",
        );
        return $items;
    }

    private function mes($number) {
        $items = $this->arr_mes();
        return $items[$number];
    }

    private function de_enero_a_estemes($este_mes) {
        $items = $this->arr_mes();
        $result = array();
        foreach ($items as $key => $value) {
            $result[$key] = $value;
            if ($key === $este_mes) {
                break;
            }
        }
        return $result;
    }

    private function generar_reporte_basedatos($year) {
        $time = $year . '%';

        $organismos = BalanceAlimTable::getInstance()->organismos($time);

        $headers = $this->headers_basedatos($time);
        $balanceAlim = $this->balance_bd($time);
        $valores = $this->matrix_de_valores_bd_productos($time);
        $matrix = $this->create_matrix($headers, $balanceAlim, $valores);

        $pr1 = $this->proveedores_bd($time);
        $pr2 = $this->proveedores_bd2($time);
        $proveedores = $this->count_distinct($pr1, $pr2, 'nombre');

// Create new PHPExcel object
        $this->load->library('phpexcel');

// Set document properties
        $this->phpexcel->getProperties()->setCreator("PHPExcel")
                ->setLastModifiedBy("PHPExcel")
                ->setTitle("Office 2007 XLSX Report Document")
                ->setSubject("Office 2007 XLSX Report Document")
                ->setDescription("Report document for Office 2007 XLSX, generated using PHP classes.")
                ->setKeywords("office 2007 openxml php")
                ->setCategory("Report result file");


// Add some data
        $this->phpexcel->getActiveSheet()->setCellValue('A1', 'BASE DE DATOS');
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getAlignment()->setIndent(1);
        $this->phpexcel->getActiveSheet()->mergeCells('A1:D1');
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getProtection()->setLocked(PHPExcel_Style_Protection::PROTECTION_UNPROTECTED);

        // Set fills
        $this->phpexcel->getActiveSheet()->getStyle('A1:I1')->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getActiveSheet()->getStyle('A1:I1')->getFill()->getStartColor()->setARGB('FF808080');
        $this->phpexcel->getActiveSheet()->getStyle('H2:I2')->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getActiveSheet()->getStyle('H2:I2')->getFill()->getStartColor()->setARGB('FF808080');
        $this->phpexcel->getActiveSheet()->getStyle('A2:D2')->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getActiveSheet()->getStyle('A2:D2')->getFill()->getStartColor()->setARGB('FF808080');

        // Set fonts
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->setName('Candara');
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->setSize(20);
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->setBold(true);
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->setUnderline(PHPExcel_Style_Font::UNDERLINE_SINGLE);
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);

        $this->phpexcel->getActiveSheet()->getColumnDimension('A')->setAutoSize(true);
        $this->phpexcel->getActiveSheet()->setCellValue('A4', 'TOTAL');
        $this->phpexcel->getActiveSheet()->getStyle('A4')->getAlignment()->setHorizontal(
                PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $this->phpexcel->getActiveSheet()->getStyle('A4')->applyFromArray($this->styles('blackStyle'));

        $this->phpexcel->getActiveSheet()->getStyle('A3')->applyFromArray($this->styles('headerStyle'));

        //NOMBRE DE LAS COLUMNAS
        $this->phpexcel->getActiveSheet()->setCellValue('A3', 'ENTIDAD/COMEDOR');
        $this->phpexcel->getActiveSheet()->getStyle('A3')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getActiveSheet()->setCellValue('B3', 'T.C.');
        $this->phpexcel->getActiveSheet()->getStyle('B3')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getActiveSheet()->setCellValue('C3', 'NIVEL DE ACT. PLAN');
        $this->phpexcel->getActiveSheet()->getStyle('C3')->getAlignment()->setTextRotation(90);
        $this->phpexcel->getActiveSheet()->getStyle('C3')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getActiveSheet()->setCellValue('D3', 'NIVEL DE ACT. REAL');
        $this->phpexcel->getActiveSheet()->getStyle('D3')->getAlignment()->setTextRotation(90);
        $this->phpexcel->getActiveSheet()->getStyle('D3')->applyFromArray($this->styles('headerStyle'));

        $this->phpexcel->getActiveSheet()->setCellValue('E2', 'EVENTOS');
        $this->phpexcel->getActiveSheet()->mergeCells('E2:G2');
        $this->phpexcel->getActiveSheet()->getStyle('E2')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getActiveSheet()->getStyle('E2')->getAlignment()->applyFromArray(array(
            'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER));
        $this->phpexcel->getActiveSheet()->getStyle('F2')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getActiveSheet()->getStyle('G2')->applyFromArray($this->styles('headerStyle'));

        $this->phpexcel->getActiveSheet()->setCellValue('E3', 'ALMUERZO');
        $this->phpexcel->getActiveSheet()->getStyle('E3')->getAlignment()->setTextRotation(90);
        $this->phpexcel->getActiveSheet()->getStyle('E3')->applyFromArray($this->styles('headerStyle'));

        $this->phpexcel->getActiveSheet()->setCellValue('F3', 'COMIDAS');
        $this->phpexcel->getActiveSheet()->getStyle('F3')->getAlignment()->setTextRotation(90);
        $this->phpexcel->getActiveSheet()->getStyle('F3')->applyFromArray($this->styles('headerStyle'));

        $this->phpexcel->getActiveSheet()->setCellValue('G3', 'MERIENDAS');
        $this->phpexcel->getActiveSheet()->getStyle('G3')->getAlignment()->setTextRotation(90);
        $this->phpexcel->getActiveSheet()->getStyle('G3')->applyFromArray($this->styles('headerStyle'));

        $this->phpexcel->getActiveSheet()->setCellValue('H3', 'INDICE COMENSAL/FISICO');
        $this->phpexcel->getActiveSheet()->getStyle('H3')->getAlignment()->setTextRotation(90);
        $this->phpexcel->getActiveSheet()->getStyle('H3')->applyFromArray($this->styles('headerStyle'));

        $this->phpexcel->getActiveSheet()->setCellValue('I3', 'COMENSAL AÑO');
        $this->phpexcel->getActiveSheet()->getStyle('I3')->getAlignment()->setTextRotation(90);
        $this->phpexcel->getActiveSheet()->getStyle('I3')->applyFromArray($this->styles('headerStyle'));

        $indice_organismos = array();
        $x = 5;
        foreach ($organismos as $org) {
            $entityNames = BalanceAlimTable::getInstance()->entidadesPorOrganismo($time, $org['organismo_id']);
            $organism = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(0, $x, $org['organismo_nombre'], true);
            $this->phpexcel->getActiveSheet()->getStyle($organism->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($organism->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);

            $row_org = $x;
            $arr_temp = array();
            for ($index = 2; $index <= 8 + count($headers); $index++) {
                $total_coord = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, $x);
                array_push($arr_temp, $total_coord->getCoordinate());
            }
            array_push($indice_organismos, $arr_temp);

            $x = $x + 1;
            $total_1 = array();
            foreach ($entityNames as $en) {
                $arr = BalanceAlimTable::getInstance()->balance_alimentacion_tabla($en['entidad_id']);
                $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(0, $x, $en['entidad_nombre'], true);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setIndent(1);
                $a1 = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(1, $x);
                $this->phpexcel->getActiveSheet()->getStyle($a1->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                $total_cap_por_org = array();
                for ($index = 2; $index <= 8 + count($headers); $index++) {
                    $aa = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, $x);
                    $this->phpexcel->getActiveSheet()->getStyle($aa->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                    $this->phpexcel->getActiveSheet()->getStyle($aa->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                    $next = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, $x + 1);
                    $coord1 = $next->getCoordinate();
                    $last = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, count($arr) + $x);
                    $coord2 = $last->getCoordinate();
                    $total_coord = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($index, $x, '=SUM(' . $coord1 . ':' . $coord2 . ')', true);
                    array_push($total_cap_por_org, $total_coord->getCoordinate());
                }
                array_push($total_1, $total_cap_por_org);
                $x = $x + 1;
                foreach ($arr as $value) {
                    $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(0, $x, $value['comedor_nombre']);
                    $a = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(0, $x);
                    $coord_a = $a->getCoordinate();
                    $this->phpexcel->getActiveSheet()->getStyle($coord_a)->applyFromArray($this->styles('borderStyle'));
                    $this->phpexcel->getActiveSheet()->getStyle($coord_a)->getAlignment()->setIndent(2);

                    $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(1, $x, $value['comedor_tc']);
                    $b = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(1, $x);
                    $this->phpexcel->getActiveSheet()->getStyle($b->getCoordinate())->applyFromArray($this->styles('borderStyle'));

                    $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(2, $x, $value['fisico']);
                    $c = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(2, $x);
                    $this->phpexcel->getActiveSheet()->getStyle($c->getCoordinate())->applyFromArray($this->styles('borderStyle'));

                    $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(3, $x, $value['nivel_act']);
                    $d = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(3, $x);
                    $level_coordinate = $d->getCoordinate();
                    $this->phpexcel->getActiveSheet()->getStyle($level_coordinate)->applyFromArray($this->styles('borderStyle'));

                    $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(4, $x, $value['almuerzo_evt']);
                    $e = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(4, $x);
                    $this->phpexcel->getActiveSheet()->getStyle($e->getCoordinate())->applyFromArray($this->styles('borderStyle'));

                    $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(5, $x, $value['comida_evt']);
                    $f = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(5, $x);
                    $this->phpexcel->getActiveSheet()->getStyle($f->getCoordinate())->applyFromArray($this->styles('borderStyle'));

                    $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(6, $x, $value['merienda_evt']);
                    $g = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(6, $x);
                    $this->phpexcel->getActiveSheet()->getStyle($g->getCoordinate())->applyFromArray($this->styles('borderStyle'));

                    $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(7, $x, $value['indice_comensal']);
                    $h = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(7, $x);
                    $ind_coordinate = $h->getCoordinate();
                    $this->phpexcel->getActiveSheet()->getStyle($ind_coordinate)->applyFromArray($this->styles('borderStyle'));

                    $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(8, $x, '=' . $ind_coordinate . '*' . $level_coordinate);
                    $i = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(8, $x);
                    $this->phpexcel->getActiveSheet()->getStyle($i->getCoordinate())->applyFromArray($this->styles('borderStyle'));

                    $col = 9;
                    foreach ($matrix[$value['id']] as $v2) {
                        $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col, $x, $v2, true);
                        $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                        $col = $col + 1;
                    }
                    $x = $x + 1;
                }
            }
            $total = array();
            foreach ($total_1[0] as $value) {
                array_push($total, $value);
            }
            //quitar el primer elemento de la lista
            array_shift($total_1);
            foreach ($total_1 as $arr) {
                for ($index = 0; $index < count($arr); $index++) {
                    $total[$index] = $total[$index] . '+' . $arr[$index];
                }
            }
            for ($index = 2; $index <= 8 + count($headers); $index++) {
                $sum_coord = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($index, $row_org, '=' . $total[$index - 2], true);
                $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLACK);
                $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);
            }
            $coord = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(1, 4);
            $this->phpexcel->getActiveSheet()->getStyle($coord->getCoordinate())->applyFromArray($this->styles('blackStyle'));
        }

        $t = 9;
        foreach ($proveedores as $value) {
            $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($t, 2, $value[0], true);
            $coordA = $a->getCoordinate();
            $b = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($t + $value[1] - 1, 2);
            $coordB = $b->getCoordinate();
            $this->phpexcel->getActiveSheet()->mergeCells($coordA . ':' . $coordB);
            $this->phpexcel->getActiveSheet()->getStyle($coordA . ':' . $coordB)->applyFromArray($this->styles('headerStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($coordA . ':' . $coordB)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

            $t = $t + $value[1];
        }
        $j = 9;
        foreach ($headers as $value) {
            $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($j, 3, $value['nombre_producto'], true);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setTextRotation(90);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('headerStyle'));
            $j = $j + 1;
        }

        //$this->phpexcel->getActiveSheet()->fromArray($query, null, 'B5', false);
        ///TOTAL GENERAL
        $total = array();
        foreach ($indice_organismos[0] as $value) {
            array_push($total, $value);
        }
        //quitar el primer elemento de la lista
        array_shift($indice_organismos);
        foreach ($indice_organismos as $arr) {
            for ($index = 0; $index < count($arr); $index++) {
                $total[$index] = $total[$index] . '+' . $arr[$index];
            }
        }

        for ($index = 2; $index <= 8 + count($headers); $index++) {
            $sum_coord = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($index, 4, '=' . $total[$index - 2], true);
            $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLACK);
            $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->applyFromArray($this->styles('blackStyle'));
        }
        $this->phpexcel->getActiveSheet()->getRowDimension(4)->setVisible(false);

        $lastColumn_row1 = count($headers) + 8;
        $lastCell = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($lastColumn_row1, 1);
        $this->phpexcel->getActiveSheet()->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getActiveSheet()->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->getStartColor()->setARGB('FF808080');


// Set header and footer. When no different headers for odd/even are used, odd header is assumed.
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddHeader('&RFecha &D');
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddFooter('&L&B' . $this->phpexcel->getProperties()->getTitle() . '&RPage &P of &N');

// Set page orientation and size
        $this->phpexcel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
        $this->phpexcel->getActiveSheet()->getPageSetup()->setPaperSize(PHPExcel_Worksheet_PageSetup::PAPERSIZE_LETTER);

// Rename first worksheet
        $this->phpexcel->getActiveSheet()->setTitle('BASE DE DATOS');


// Set active sheet index to the first sheet, so Excel opens this as the first sheet
        $this->phpexcel->setActiveSheetIndex(0);

        return $this->phpexcel;
    }

    public function generar_xls_basedatos($year) {
        $excel = $this->generar_reporte_basedatos($year);
        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="base_de_datos-' . $year . '.xlsx"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($excel, 'Excel2007');
        $objWriter->save('php://output');
    }

    public function generar_pdf_basedatos($year) {
        $this->load->library('mpdf');
        $excel = $this->generar_reporte_basedatos($year);
        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/pdf');
        header('Content-Disposition: attachment;filename="base_de_datos-' . $year . '.pdf"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($excel, 'PDF');
        $objWriter->save('php://output');
    }

    private function headers_basedatos($time) {
        return Doctrine_Query::create()->select('base_datos.id, producto.nombre '
                                . 'as nombre_producto, proveedor.nombre as nombre_proveedor'
                                . ',base_datos.ajuste as cantidad')
                        ->from('BaseDatos base_datos')
                        ->innerJoin('base_datos.Producto producto')
                        ->innerJoin('base_datos.BalanceAlim ba')
                        ->innerJoin('producto.Proveedor proveedor')
                        ->where('base_datos.created_at like "' . $time . '"')
                        ->groupBy('producto.id')
                        ->orderBy('proveedor.nombre, producto.nombre')->execute()->toArray(true);
    }

    private function balance_bd($time) {
        return Doctrine_Query::create()->select('ba.id as nombre_entidad')
                        ->from('BalanceAlim ba')
                        ->where('ba.created_at like "' . $time . '"')
                        ->groupBy('ba.id')
                        ->orderBy('nombre_entidad')
                        ->execute()->toArray(true);
    }

    private function matrix_de_valores_bd_productos($time) {
        return Doctrine_Query::create()->select('bd.id, producto.nombre '
                                . 'as nombre_producto, proveedor.nombre as nombre_proveedor'
                                . ',producto.norma as cantidad, ba.id as nombre_entidad')
                        ->from('BaseDatos bd')
                        ->innerJoin('bd.Producto producto')
                        ->innerJoin('bd.BalanceAlim ba')
                        ->innerJoin('producto.Proveedor proveedor')
                        ->where('bd.created_at like "' . $time . '"')
                        ->orderBy('proveedor.nombre, producto.nombre')
                        ->execute()->toArray(true);
    }

    private function matrix_de_valores_ajuste_productos($time) {
        return Doctrine_Query::create()->select('bd.id, producto.nombre '
                                . 'as nombre_producto, proveedor.nombre as nombre_proveedor'
                                . ', producto.id as cantidad, ba.id as nombre_entidad')
                        ->from('BaseDatos bd')
                        ->innerJoin('bd.Producto producto')
                        ->innerJoin('bd.BalanceAlim ba')
                        ->innerJoin('producto.Proveedor proveedor')
                        ->where('bd.created_at like "' . $time . '"')
                        ->orderBy('proveedor.nombre, producto.nombre')
                        ->execute()->toArray(true);
    }

    private function proveedores_bd2($time) {
        return Doctrine_Query::create()
                        ->select('producto.id, proveedor.nombre as nombre')
                        ->from('NomProducto producto')->innerJoin('producto.Proveedor proveedor')
                        ->innerJoin('producto.BaseDatos base_datos')
                        ->where('base_datos.created_at like "' . $time . '"')
                        ->groupBy('producto.id')
                        ->orderBy('proveedor.nombre, producto.nombre')
                        ->execute()->toArray(true);
    }

    private function proveedores_bd($time) {
        return Doctrine_Query::create()
                        ->select('producto.id, proveedor.nombre as nombre')
                        ->from('NomProducto producto')->innerJoin('producto.Proveedor proveedor')
                        ->innerJoin('producto.BaseDatos base_datos')
                        ->where('base_datos.created_at like "' . $time . '"')
                        ->groupBy('proveedor.id')
                        ->orderBy('proveedor.nombre, producto.nombre')
                        ->execute()->toArray(true);
    }

    public function generar_xls_balance($year) {
        $excel = $this->generar_reporte_balance($year);
        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="cumplimiento-de-los-balances-' . $year . '.xlsx"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($excel, 'Excel2007');
        $objWriter->save('php://output');
    }

    public function generar_pdf_balance($year) {
        $this->load->library('mpdf');
        $excel = $this->generar_reporte_balance($year);
        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/pdf');
        header('Content-Disposition: attachment;filename="cumplimiento-de-los-balances-' . $year . '.pdf"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($excel, 'PDF');
        $objWriter->save('php://output');
    }

    private function styles($index) {
        $style = array(
            'font' => array(
                'bold' => true
            ),
            'borders' => array(
                'outline' => array(
                    'style' => PHPExcel_Style_Border::BORDER_THIN,
                )
            ), 'fill' => array(
                'type' => PHPExcel_Style_Fill::FILL_GRADIENT_LINEAR,
                'rotation' => 90,
                'startcolor' => array(
                    'argb' => 'FFA0A0A0'
                ),
                'endcolor' => array(
                    'argb' => 'FFFFFFFF'
                )
            )
        );
        $style2 = array(
            'borders' => array(
                'outline' => array(
                    'style' => PHPExcel_Style_Border::BORDER_THIN,
                )
            )
        );
        $horizontal = array(
            'borders' => array(
                'bottom' => array(
                    'style' => PHPExcel_Style_Border::BORDER_THIN,
                )
            )
        );
        $blackStyle = array(
            'font' => array(
                'bold' => true
            ),
            'borders' => array(
                'outline' => array(
                    'style' => PHPExcel_Style_Border::BORDER_THIN,
                )
        ));
        $arr = array('blackStyle' => $blackStyle, 'borderStyle' => $style2, 'headerStyle' => $style, 'horizontalBorder' => $horizontal);
        return $arr[$index];
    }

    private function generar_reporte_balance($year) {
        $time = $year . '%';
        $actividades = NomActividadTable::getInstance()->findAll(Doctrine::HYDRATE_ARRAY);
        $productos = ActividadProductoTable::getInstance()->productos($time);

// Create new PHPExcel object
        $this->load->library('phpexcel');

// Set document properties
        $this->phpexcel->getProperties()->setCreator("PHPExcel")
                ->setLastModifiedBy("PHPExcel")
                ->setTitle("Reporte generado por ALIPLAN")
                ->setSubject("Reporte generado por ALIPLAN")
                ->setDescription("Report document for Office 2007 XLSX, generated using PHP classes.")
                ->setKeywords("office 2007 openxml php")
                ->setCategory("Report result file");


// Add some data
        $this->phpexcel->getActiveSheet()->setCellValue('A2', 'PRODUCTO/ACTIVIDAD');
        $this->phpexcel->getActiveSheet()->getStyle('A2')->applyFromArray($this->styles('borderStyle'));
        //$this->phpexcel->getActiveSheet()->getStyle('A1')->getAlignment()->setIndent(1);
        // Set fonts
        $this->phpexcel->getActiveSheet()->getStyle('A2')->getFont()->setBold(true);
        $this->phpexcel->getActiveSheet()->getColumnDimension('A')->setAutoSize(true);

        $num_columna = 1;
        $month = date("m");
        if (date("Y") != $year) {
            $month = "00";
        }
        $months = $this->de_enero_a_estemes($month);

        //columnas
        foreach ($months as $mes_key => $value) {
            $fila = 1;
            $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna, $fila, "Mes de " . $value, true);
            $c1 = $a->getCoordinate();

            $b = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($num_columna + 2, $fila);
            $c2 = $b->getCoordinate();

            $this->phpexcel->getActiveSheet()->mergeCells($c1 . ':' . $c2);
            $this->phpexcel->getActiveSheet()->getStyle($c1 . ':' . $c2)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
            $this->phpexcel->getActiveSheet()->getStyle($c1 . ':' . $c2)->applyFromArray($this->styles('blackStyle'));

            $fila = 2;
            //columna plan
            $col_plan = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna, $fila, "PLAN", true);
            $coor_plan = $col_plan->getCoordinate();
            $this->phpexcel->getActiveSheet()->getStyle($coor_plan)->applyFromArray($this->styles('blackStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($coor_plan)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

            //columna real
            $col_real = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna + 1, $fila, "REAL", true);
            $coor_real = $col_real->getCoordinate();
            $this->phpexcel->getActiveSheet()->getStyle($coor_real)->applyFromArray($this->styles('blackStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($coor_real)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

            //columna porciento
            $col_porc = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna + 2, $fila, "%", true);
            $coor_porc = $col_porc->getCoordinate();
            $this->phpexcel->getActiveSheet()->getStyle($coor_porc)->applyFromArray($this->styles('blackStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($coor_porc)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

            $num_columna = $num_columna + 3;

            if ($mes_key != '01') {
                $fila = 1;
                $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna, $fila, "ACUMULADO/Hasta " . $value, true);
                $c1 = $a->getCoordinate();

                $b = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($num_columna + 2, $fila);
                $c2 = $b->getCoordinate();

                $this->phpexcel->getActiveSheet()->mergeCells($c1 . ':' . $c2);
                $this->phpexcel->getActiveSheet()->getStyle($c1 . ':' . $c2)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
                $this->phpexcel->getActiveSheet()->getStyle($c1 . ':' . $c2)->applyFromArray($this->styles('blackStyle'));

                $fila = 2;
                //columna plan
                $col_plan = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna, $fila, "PLAN", true);
                $coor_plan = $col_plan->getCoordinate();
                $this->phpexcel->getActiveSheet()->getStyle($coor_plan)->applyFromArray($this->styles('blackStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($coor_plan)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

                //columna real
                $col_real = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna + 1, $fila, "REAL", true);
                $coor_real = $col_real->getCoordinate();
                $this->phpexcel->getActiveSheet()->getStyle($coor_real)->applyFromArray($this->styles('blackStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($coor_real)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

                //columna porciento
                $col_porc = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna + 2, $fila, "%", true);
                $coor_porc = $col_porc->getCoordinate();
                $this->phpexcel->getActiveSheet()->getStyle($coor_porc)->applyFromArray($this->styles('blackStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($coor_porc)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

                $num_columna = $num_columna + 3;
            }
        }

        $iterator_colA = 3;
        $num_columna = 0;
        for ($i = 0; $i < count($productos); $i++) {
            $obj = $productos[$i];
            $product = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna, $iterator_colA, $obj['producto_nombre'] . ' (' . $obj['unidad_medida'] . ')', true);
            $this->phpexcel->getActiveSheet()->getStyle($product->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $iterator_colA = $iterator_colA + 1;
            $y = 0;
            for (; $y < count($actividades); $y++) {
                $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna, $iterator_colA + $y, $actividades[$y]['nombre'], true);
                $coord_a = $a->getCoordinate();
                $this->phpexcel->getActiveSheet()->getStyle($coord_a)->applyFromArray($this->styles('borderStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($coord_a)->getAlignment()->setIndent(1);
            }
            $iterator_colA = $iterator_colA + $y;
            $num_columna = 0;
        }
        $num_columna = 1;
        $num_activities = count($actividades);
        foreach ($months as $mes_key => $value) {
            $act_prod = ActividadProductoTable::getInstance()->productos_por_meses($mes_key, $year);
            $matrix_act_prod = ActividadProductoTable::getInstance()->matrix($actividades, $productos, $act_prod);
            $begin_row = 3;
            for ($i = 0; $i < count($productos); $i++) {
                $producto = $productos[$i];

                $upper = $matrix_act_prod[$producto['producto_nombre']];

                $x1 = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($num_columna, $begin_row + 1);
                $c1 = $x1->getCoordinate();
                $x2 = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($num_columna, $begin_row + $num_activities);
                $c2 = $x2->getCoordinate();
                $sum_plan = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna, $begin_row, '=SUM(' . $c1 . ':' . $c2 . ')', true);
                $c3 = $sum_plan->getCoordinate();
                $this->phpexcel->getActiveSheet()->getStyle($c3)->applyFromArray($this->styles('blackStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($c3)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

                $x1 = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($num_columna + 1, $begin_row + 1);
                $c1 = $x1->getCoordinate();
                $x2 = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($num_columna + 1, $begin_row + $num_activities);
                $c2 = $x2->getCoordinate();
                $sum_real = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna + 1, $begin_row, '=SUM(' . $c1 . ':' . $c2 . ')', true);
                $zz = $sum_real->getCoordinate();
                $this->phpexcel->getActiveSheet()->getStyle($zz)->applyFromArray($this->styles('blackStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($zz)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

                $percent_formula = '=' . $zz . '*100/' . $c3;
                $per = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna + 2, $begin_row, $percent_formula, true);
                $zzz = $per->getCoordinate();
                $this->phpexcel->getActiveSheet()->getStyle($zzz)->applyFromArray($this->styles('blackStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($zzz)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
                $this->phpexcel->getActiveSheet()->getStyle($zzz)->getNumberFormat()->setFormatCode('#,##0.0');

                $begin_row = $begin_row + 1;
                for ($y = 0; $y < $num_activities; $y++) {
                    $actividad = $actividades[$y];
                    $middle = $upper [$actividad['nombre']];

                    //Asignar datos a las celdas (plan,real y porciento)
                    $pl = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna, $begin_row, $middle['plan'], true);
                    $pl_coor = $pl->getCoordinate();
                    $this->phpexcel->getActiveSheet()->getStyle($pl_coor)->applyFromArray($this->styles('borderStyle'));
                    $this->phpexcel->getActiveSheet()->getStyle($pl_coor)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);


                    $real = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna + 1, $begin_row, $middle['actual'], true);
                    $real_coor = $real->getCoordinate();
                    $this->phpexcel->getActiveSheet()->getStyle($real_coor)->applyFromArray($this->styles('borderStyle'));
                    $this->phpexcel->getActiveSheet()->getStyle($real_coor)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

                    $percent_formula = '=' . $real_coor . '*100/' . $pl_coor;
                    if ($middle['plan'] == 0) {
                        $percent_formula = 0;
                    }
                    $pc = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna + 2, $begin_row, $percent_formula, true);
                    $porc_coor = $pc->getCoordinate();
                    $this->phpexcel->getActiveSheet()->getStyle($porc_coor)->applyFromArray($this->styles('borderStyle'));
                    $this->phpexcel->getActiveSheet()->getStyle($porc_coor)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
                    $this->phpexcel->getActiveSheet()->getStyle($porc_coor)->getNumberFormat()->setFormatCode('#,##0.0');

                    $begin_row += 1;
                }
            }
            $num_columna = $num_columna + 3;
            if ($mes_key != '01') {
                $begin_row = 3;
                for ($i = 0; $i < count($productos); $i++) {

                    $x1 = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($num_columna, $begin_row + 1);
                    $c1 = $x1->getCoordinate();
                    $x2 = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($num_columna, $begin_row + $num_activities);
                    $c2 = $x2->getCoordinate();
                    $sum_plan = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna, $begin_row, '=SUM(' . $c1 . ':' . $c2 . ')', true);
                    $c3 = $sum_plan->getCoordinate();
                    $this->phpexcel->getActiveSheet()->getStyle($c3)->applyFromArray($this->styles('blackStyle'));
                    $this->phpexcel->getActiveSheet()->getStyle($c3)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

                    $x1 = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($num_columna + 1, $begin_row + 1);
                    $c1 = $x1->getCoordinate();
                    $x2 = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($num_columna + 1, $begin_row + $num_activities);
                    $c2 = $x2->getCoordinate();
                    $sum_real = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna + 1, $begin_row, '=SUM(' . $c1 . ':' . $c2 . ')', true);
                    $zz = $sum_real->getCoordinate();
                    $this->phpexcel->getActiveSheet()->getStyle($zz)->applyFromArray($this->styles('blackStyle'));
                    $this->phpexcel->getActiveSheet()->getStyle($zz)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

                    $percent_formula = '=' . $zz . '*100/' . $c3;
                    $per = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna + 2, $begin_row, $percent_formula, true);
                    $zzz = $per->getCoordinate();
                    $this->phpexcel->getActiveSheet()->getStyle($zzz)->applyFromArray($this->styles('blackStyle'));
                    $this->phpexcel->getActiveSheet()->getStyle($zzz)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
                    $this->phpexcel->getActiveSheet()->getStyle($zzz)->getNumberFormat()->setFormatCode('#,##0.0');

                    $begin_row = $begin_row + 1;
                    for ($y = 0; $y < $num_activities; $y++) {
                        $actividad = $actividades[$y];
                        $middle = $upper [$actividad['nombre']];

                        //Asignar Acumulados
                        //------------PLAN----------
                        $first = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($num_columna - 6, $begin_row);
                        $first_coor = $first->getCoordinate();
                        $second = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($num_columna - 3, $begin_row);
                        $second_coor = $second->getCoordinate();

                        $pl = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna, $begin_row, '=' . $first_coor . '+' . $second_coor, true);
                        $pl_coor = $pl->getCoordinate();
                        $this->phpexcel->getActiveSheet()->getStyle($pl_coor)->applyFromArray($this->styles('borderStyle'));
                        $this->phpexcel->getActiveSheet()->getStyle($pl_coor)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

                        //------------REAL-----------
                        $first1 = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($num_columna + 1 - 6, $begin_row);
                        $first1_coor = $first1->getCoordinate();
                        $second1 = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($num_columna + 1 - 3, $begin_row);
                        $second1_coor = $second1->getCoordinate();

                        $real = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna + 1, $begin_row, '=' . $first1_coor . '+' . $second1_coor, true);
                        $real_coor = $real->getCoordinate();
                        $this->phpexcel->getActiveSheet()->getStyle($real_coor)->applyFromArray($this->styles('borderStyle'));
                        $this->phpexcel->getActiveSheet()->getStyle($real_coor)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

                        $percent_formula = '=' . $real_coor . '*100/' . $pl_coor;
                        $pc = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($num_columna + 2, $begin_row, $percent_formula, true);
                        $porc_coor = $pc->getCoordinate();
                        $this->phpexcel->getActiveSheet()->getStyle($porc_coor)->applyFromArray($this->styles('borderStyle'));
                        $this->phpexcel->getActiveSheet()->getStyle($porc_coor)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
                        $this->phpexcel->getActiveSheet()->getStyle($porc_coor)->getNumberFormat()->setFormatCode('#,##0.0');

                        $begin_row += 1;
                    }
                }
                $num_columna = $num_columna + 3;
            }
        }

// Set header and footer. When no different headers for odd/even are used, odd header is assumed.
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddHeader('&RFecha &D');
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddFooter('&L&B' . $this->phpexcel->getProperties()->getTitle() . '&RPágina &P de &N');

// Set page orientation and size
        $this->phpexcel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
        $this->phpexcel->getActiveSheet()->getPageSetup()->setPaperSize(PHPExcel_Worksheet_PageSetup::PAPERSIZE_LETTER);

// Rename first worksheet
        $this->phpexcel->getActiveSheet()->setTitle('Hoja1');


// Set active sheet index to the first sheet, so Excel opens this as the first sheet
        $this->phpexcel->setActiveSheetIndex(0);

        return $this->phpexcel;
    }

    //REPORTE MENSUAL
    private function generar_reporte_mensual($year) {
        $time = $year . '%';
        $organismos = BalanceAlimTable::getInstance()->organismos($time);

        $headers = $this->headers_basedatos($time);
        $balanceAlim = $this->balance_bd($time);
        $valores = $this->matrix_de_valores_ajuste_productos($time);
        $matrix = $this->create_matrix($headers, $balanceAlim, $valores);

        $pr1 = $this->proveedores_bd($time);
        $pr2 = $this->proveedores_bd2($time);
        $proveedores = $this->count_distinct($pr1, $pr2, 'nombre');

// Create new PHPExcel object
        $this->load->library('phpexcel');

// Set document properties
        $this->phpexcel->getProperties()->setCreator("PHPExcel")
                ->setLastModifiedBy("PHPExcel")
                ->setTitle("Office 2007 XLSX Report Document")
                ->setSubject("Office 2007 XLSX Report Document")
                ->setDescription("Report document for Office 2007 XLSX, generated using PHP classes.")
                ->setKeywords("office 2007 openxml php")
                ->setCategory("Reporte mensual");


// Add some data
        $this->phpexcel->getActiveSheet()->setCellValue('A1', 'BALANCE DE ALIMENTO DEL MES');
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getAlignment()->setIndent(1);
        $this->phpexcel->getActiveSheet()->mergeCells('A1:D1');
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getProtection()->setLocked(PHPExcel_Style_Protection::PROTECTION_UNPROTECTED);

        // Set fills
        $this->phpexcel->getActiveSheet()->getStyle('A2')->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getActiveSheet()->getStyle('A2')->getFill()->getStartColor()->setARGB('FF808080');

        // Set fonts
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->setName('Candara');
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->setSize(19);
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->setBold(true);
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->setUnderline(PHPExcel_Style_Font::UNDERLINE_SINGLE);
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);


        $this->phpexcel->getActiveSheet()->getColumnDimension('A')->setAutoSize(true);
        $this->phpexcel->getActiveSheet()->setCellValue('A4', 'TOTAL');
        $this->phpexcel->getActiveSheet()->getStyle('A4')->getAlignment()->setHorizontal(
                PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $this->phpexcel->getActiveSheet()->getStyle('A4')->applyFromArray($this->styles('blackStyle'));

        $this->phpexcel->getActiveSheet()->getStyle('A3')->applyFromArray($this->styles('headerStyle'));

        //NOMBRE DE LAS COLUMNAS
        $this->phpexcel->getActiveSheet()->setCellValue('A3', 'ENTIDAD/COMEDOR');
        $this->phpexcel->getActiveSheet()->getStyle('A3')->applyFromArray($this->styles('headerStyle'));

        $indice_organismos = array();
        $x = 5;
        foreach ($organismos as $org) {
            $entityNames = BalanceAlimTable::getInstance()->entidadesPorOrganismo($time, $org['organismo_id']);
            $organism = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(0, $x, $org['organismo_nombre'], true);
            $this->phpexcel->getActiveSheet()->getStyle($organism->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($organism->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);

            $row_org = $x;
            $arr_temp = array();
            for ($index = 1; $index <= count($headers); $index++) {
                $total_coord = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, $x);
                array_push($arr_temp, $total_coord->getCoordinate());
            }
            array_push($indice_organismos, $arr_temp);

            $x = $x + 1;
            $total_1 = array();
            foreach ($entityNames as $en) {
                $arr = BalanceAlimTable::getInstance()->balance_alimentacion_tabla($en['entidad_id']);
                $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(0, $x, $en['entidad_nombre'], true);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setIndent(1);
                $a1 = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(1, $x);
                $this->phpexcel->getActiveSheet()->getStyle($a1->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                $total_cap_por_org = array();
                for ($index = 1; $index <= count($headers); $index++) {
                    $aa = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, $x);
                    $this->phpexcel->getActiveSheet()->getStyle($aa->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                    $this->phpexcel->getActiveSheet()->getStyle($aa->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                    $next = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, $x + 1);
                    $coord1 = $next->getCoordinate();
                    $last = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($index, count($arr) + $x);
                    $coord2 = $last->getCoordinate();
                    $total_coord = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($index, $x, '=IF(SUM(' . $coord1 . ':' . $coord2 . ')>0,0,1)', true);
                    $total_cell = $total_coord->getCoordinate();
                    $this->phpexcel->getActiveSheet()->getStyle($total_cell)->getNumberFormat()->setFormatCode('#,##0.000');
                    array_push($total_cap_por_org, $total_cell);
                }
                array_push($total_1, $total_cap_por_org);
                $x = $x + 1;
                foreach ($arr as $value) {
                    $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow(0, $x, $value['comedor_nombre']);
                    $a = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(0, $x);
                    $coord_a = $a->getCoordinate();
                    $this->phpexcel->getActiveSheet()->getStyle($coord_a)->applyFromArray($this->styles('borderStyle'));
                    $this->phpexcel->getActiveSheet()->getStyle($coord_a)->getAlignment()->setIndent(2);

                    $col = 1;
                    foreach ($matrix[$value['id']] as $producto_id) {
                        $result_query = BaseDatosTable::getInstance()->valor_producto_mes($value['balance_id'], $producto_id);
                        $result = 0;
                        if (count($result_query) > 0) {
                            $result = $result_query[0]['valor_mes'];
                            $ajuste = $result_query[0]['ajuste_mes'] * $result / 100;
                            $result += $ajuste;
                        }
                        $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col, $x, $result, true);
                        $coordin = $a->getCoordinate();
                        $this->phpexcel->getActiveSheet()->getStyle($coordin)->applyFromArray($this->styles('borderStyle'));
                        $this->phpexcel->getActiveSheet()->getStyle($coordin)->getNumberFormat()->setFormatCode('#,##0.000');
                        $col = $col + 1;
                    }
                    $x = $x + 1;
                }
            }


            $total = array();
            foreach ($total_1[0] as $value) {
                array_push($total, $value);
            }
            //quitar el primer elemento de la lista
            array_shift($total_1);
            foreach ($total_1 as $arr) {
                for ($index = 0; $index < count($arr); $index++) {
                    $total[$index] = $total[$index] . '+' . $arr[$index];
                }
            }
            for ($index = 1; $index <= count($headers); $index++) {
                $sum_coord = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($index, $row_org, '=' . $total[$index - 1], true);
                $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLACK);
                $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);
                $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->getNumberFormat()->setFormatCode('#,##0.000');
            }
        }

        //TOTAL GENERAL
        $total = array();
        foreach ($indice_organismos[0] as $value) {
            array_push($total, $value);
        }
        //quitar el primer elemento de la lista
        array_shift($indice_organismos);
        foreach ($indice_organismos as $arr) {
            for ($index = 0; $index < count($arr); $index++) {
                $total[$index] = $total[$index] . '+' . $arr[$index];
            }
        }

        for ($index = 1; $index <= count($headers); $index++) {
            $sum_coord = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($index, 4, '=' . $total[$index - 1], true);
            $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLACK);
            $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($sum_coord->getCoordinate())->getNumberFormat()->setFormatCode('#,##0.000');
        }
        $coord = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow(1, 4);
        $this->phpexcel->getActiveSheet()->getStyle($coord->getCoordinate())->applyFromArray($this->styles('blackStyle'));



        $t = 1;
        foreach ($proveedores as $value) {
            $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($t, 2, $value[0], true);
            $coordA = $a->getCoordinate();
            $b = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($t + $value[1] - 1, 2);
            $coordB = $b->getCoordinate();
            $this->phpexcel->getActiveSheet()->mergeCells($coordA . ':' . $coordB);
            $this->phpexcel->getActiveSheet()->getStyle($coordA . ':' . $coordB)->applyFromArray($this->styles('headerStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($coordA . ':' . $coordB)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

            $t = $t + $value[1];
        } $j = 1;
        foreach ($headers as $value) {
            $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($j, 3, $value['nombre_producto'], true);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setTextRotation(90);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('headerStyle'));
            $j = $j + 1;
        }

        $lastColumn_row1 = count($headers);
        $lastCell = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($lastColumn_row1, 1);
        $this->phpexcel->getActiveSheet()->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getActiveSheet()->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->getStartColor()->setARGB('FF808080');


// Set header and footer. When no different headers for odd/even are used, odd header is assumed.
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddHeader('&RFecha &D');
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddFooter('&L&B' . $this->phpexcel->getProperties()->getTitle() . '&RPage &P of &N');

// Set page orientation and size
        $this->phpexcel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
        $this->phpexcel->getActiveSheet()->getPageSetup()->setPaperSize(PHPExcel_Worksheet_PageSetup::PAPERSIZE_LETTER);

// Rename first worksheet
        $this->phpexcel->getActiveSheet()->setTitle('MENSUAL');


// Set active sheet index to the first sheet, so Excel opens this as the first sheet


        $this->phpexcel->setActiveSheetIndex(0);

        return $this->phpexcel;
    }

    public function generar_xls_mensual($year) {
        $excel = $this->generar_reporte_mensual($year);
        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="mensual-' . $year . '.xlsx"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($excel, 'Excel2007');
        $objWriter->save('php://output');
    }

    private function generar_reporte_portada($year) {
        $time = $year . '%';

        $headers = ProductoFuentesTable::getInstance()->productos($time);

        $pr1 = ProductoFuentesTable::getInstance()->proveedores_fuentes($time);
        $pr2 = ProductoFuentesTable::getInstance()->proveedores_fuentes2($time);
        $proveedores = $this->count_distinct($pr1, $pr2, 'nombre');

// Create new PHPExcel object
        $this->load->library('phpexcel');

// Set document properties
        $this->phpexcel->getProperties()->setCreator($this->session->userdata('username'))
                ->setLastModifiedBy("Aliplan")
                ->setTitle("Confeccionado por:                                                                              Revisado por:")
                ->setSubject("Office 2007 XLSX Report Document")
                ->setDescription("Report document for Office 2007 XLSX, generated using PHP classes.")
                ->setKeywords("office 2007 openxml php")
                ->setCategory("Report result file");


// Add some data
        $this->phpexcel->getActiveSheet()->setCellValue('A1', 'ANALISIS DE LA CIFRA DIRECTIVA PLAN ' . $year);
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getAlignment()->setIndent(1);
        $this->phpexcel->getActiveSheet()->mergeCells('A1:B1');
        $this->phpexcel->getActiveSheet()->getStyle('B1')->getProtection()->setLocked(PHPExcel_Style_Protection::PROTECTION_UNPROTECTED);

        // Set fills
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFill()->getStartColor()->setARGB('FF808080');
        $this->phpexcel->getActiveSheet()->getStyle('A2')->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getActiveSheet()->getStyle('A2')->getFill()->getStartColor()->setARGB('FF808080');

        // Set fonts
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->setName('Candara');
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->setSize(14);
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->setBold(true);
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->setUnderline(PHPExcel_Style_Font::UNDERLINE_SINGLE);
        $this->phpexcel->getActiveSheet()->getStyle('A1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);

        $this->phpexcel->getActiveSheet()->getColumnDimension('A')->setAutoSize(true);
        $this->phpexcel->getActiveSheet()->setCellValue('A3', 'PRODUCTOS');
        $this->phpexcel->getActiveSheet()->getStyle('A3')->getAlignment()->setHorizontal(
                PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $this->phpexcel->getActiveSheet()->getStyle('A3')->applyFromArray($this->styles('headerStyle'));

        $this->phpexcel->getActiveSheet()->setCellValue('A4', 'FUENTES');
        $this->phpexcel->getActiveSheet()->getStyle('A4')->applyFromArray($this->styles('blackStyle'));

        $col = 0;
        $row = 5;
        $fuentes = NomFuentesTable::getInstance()->fuentes($time);
        foreach ($fuentes as $value) {
            $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col, $row, $value['nombre'], true);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setIndent(2);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
            $col = 1;
            foreach ($headers as $v) {
                $cantidad = 0;
                $arr = ProductoFuentesTable::getInstance()->cantidad($time, $v['producto_id'], $value['fuente_id']);
                if ($arr && $arr[0]) {
                    $obj = $arr[0];
                    $cantidad = $obj['cantidad'];
                }
                $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col++, $row, $cantidad, true);
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getNumberFormat()->setFormatCode('#,##0.000');
            }
            $row++;
            $col = 0;
        }

        //Sumatoria de fuentes
        $num_fuentes = count($fuentes);
        for ($col_number = 1; $col_number <= count($headers); $col_number++) {
            $a = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($col_number, 5);
            $a_coor = $a->getCoordinate();
            $b = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($col_number, 4 + $num_fuentes);
            $b_coor = $b->getCoordinate();
            $c = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col_number, 4, '=SUM(' . $a_coor . ':' . $b_coor . ')', true);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getNumberFormat()->setFormatCode('#,##0.000');
        }

        //Sumatoria de Destinos
        for ($col_number = 1; $col_number <= count($headers); $col_number++) {
            $a = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($col_number, 9);
            $a_coor = $a->getCoordinate();
            $b = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($col_number, 14);
            $b_coor = $b->getCoordinate();
            $c = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($col_number, 15);
            $c_coor = $c->getCoordinate();
            $d = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($col_number, 17);
            $d_coor = $d->getCoordinate();
            $e = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($col_number, 33);
            $e_coor = $e->getCoordinate();
            $suma = '=' . $a_coor . '+' . $b_coor . '+' . $c_coor . '+' . $d_coor . '+' . $e_coor;
            $f = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col_number, 5 + $num_fuentes, $suma, true);
            $this->phpexcel->getActiveSheet()->getStyle($f->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($f->getCoordinate())->getNumberFormat()->setFormatCode('#,##0.000');
        }

        $col = 0;
        $arr_columna_a = $this->columna_a();
        $coor_nomin = 0;
        $coor_consumoSocial = 0;
        $coor_consumoInter = 0;
        $reserva_balance = 0;
        $canasta_familiar = 0;
        foreach ($arr_columna_a as $value) {
            $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col, $row++, $value[0], true);
            $coor = $a->getCoordinate();
            if ($value[0] === 'Nominalizados') {
                $coor_nomin = $row - 1;
            } else if ($value[0] === 'Consumo Intermedio') {
                $coor_consumoInter = $row - 1;
            } else if ($value[0] === 'Reserva del Balance') {
                $reserva_balance = $row - 1;
            } else if ($value[0] === 'Canasta Familiar') {
                $canasta_familiar = $row - 1;
            } else if ($value[0] === 'Consumo Social') {
                $coor_consumoSocial = $row - 1;
            }
            $this->phpexcel->getActiveSheet()->getStyle($coor)->getAlignment()->setIndent($value[1]);
            $this->phpexcel->getActiveSheet()->getStyle($coor)->applyFromArray($this->styles($value[2]));
        }

        //FORMULA DE NOMINALIZADOS
        $col = 1;
        foreach ($headers as $value) {
            $cantidad = 0;
            $arr = ProductoFuentesTable::getInstance()->nominalizados($time, $value['producto_id']);
            if ($arr && $arr[0]) {
                $obj = $arr[0];
                $cantidad = $obj['cantidad'];
            }
            $f = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col++, $coor_nomin, $cantidad, true);
            $this->phpexcel->getActiveSheet()->getStyle($f->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($f->getCoordinate())->getNumberFormat()->setFormatCode('#,##0.000');
        }

        //FORMULA DE CONSUMO SOCIAL
        for ($col_number = 1; $col_number <= count($headers); $col_number++) {
            $a = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($col_number, $coor_consumoSocial + 1);
            $a_coor = $a->getCoordinate();
            $b = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($col_number, $coor_consumoSocial + 9);
            $b_coor = $b->getCoordinate();
            $bb = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($col_number, $coor_consumoSocial + 11);
            $bb_coor = $bb->getCoordinate();
            $c = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col_number, $coor_consumoSocial, '=SUM(' . $a_coor . ':' . $b_coor . ')+' . $bb_coor, true);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getNumberFormat()->setFormatCode('#,##0.000');
        }

        //FORMULA DE CONSUMO INTERMEDIO
        $col = 1;
        foreach ($headers as $value) {
            $cantidad = 0;
            $arr = ProductoFuentesTable::getInstance()->consumo_intermedio($time, $value['producto_id']);
            if ($arr && $arr[0]) {
                $obj = $arr[0];
                $cantidad = $obj['cantidad'];
            }
            $f = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col++, $coor_consumoInter, $cantidad, true);
            $this->phpexcel->getActiveSheet()->getStyle($f->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($f->getCoordinate())->getNumberFormat()->setFormatCode('#,##0.000');
        }

        //FORMULA DE RESERVA DEL BALANCE
        for ($col_number = 1; $col_number <= count($headers); $col_number++) {
            $a = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($col_number, 4);
            $a_coor = $a->getCoordinate();
            $b = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($col_number, 5 + $num_fuentes);
            $b_coor = $b->getCoordinate();

            $prod = '=PRODUCT(' . $a_coor . '-' . $b_coor . ')';
            $f = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col_number, $reserva_balance, $prod, true);
            $this->phpexcel->getActiveSheet()->getStyle($f->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($f->getCoordinate())->getNumberFormat()->setFormatCode('#,##0.000');
        }

        //SUMATORIA DE Grupo Empresarial de Comercio y la G.
        for ($col_number = 1; $col_number <= count($headers); $col_number++) {
            $a = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($col_number, 9);
            $a_coor = $a->getCoordinate();
            $b = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($col_number, $canasta_familiar);
            $b_coor = $b->getCoordinate();

            $sum = '=SUM(' . $a_coor . ':' . $b_coor . ')';
            $f = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col_number, 7 + $num_fuentes, $sum, true);
            $this->phpexcel->getActiveSheet()->getStyle($f->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($f->getCoordinate())->getNumberFormat()->setFormatCode('#,##0.000');
        }

        $t = 1;
        foreach ($proveedores as $value) {
            $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($t, 2, $value[0], true);
            $coordA = $a->getCoordinate();
            $b = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($t + $value[1] - 1, 2);
            $coordB = $b->getCoordinate();
            $this->phpexcel->getActiveSheet()->mergeCells($coordA . ':' . $coordB);
            $this->phpexcel->getActiveSheet()->getStyle($coordA . ':' . $coordB)->applyFromArray($this->styles('headerStyle'));
            $this->phpexcel->getActiveSheet()->getStyle($coordA . ':' . $coordB)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

            $t = $t + $value[1];
        }
        $j = 1;
        foreach ($headers as $value) {
            $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($j, 3, $value['nombre_producto'], true);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->getAlignment()->setTextRotation(90);
            $this->phpexcel->getActiveSheet()->getStyle($a->getCoordinate())->applyFromArray($this->styles('headerStyle'));
            $j = $j + 1;
        }

        $lastColumn_row1 = count($headers);
        $lastCell = $this->phpexcel->getActiveSheet()->getCellByColumnAndRow($lastColumn_row1, 1);
        $this->phpexcel->getActiveSheet()->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getActiveSheet()->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->getStartColor()->setARGB('FF808080');


// Set header and footer. When no different headers for odd/even are used, odd header is assumed.
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddHeader('&RFecha &D');
        $this->phpexcel->getActiveSheet()->getHeaderFooter()->setOddFooter('&L&B' . $this->phpexcel->getProperties()->getTitle() . '&RPágina &P de &N');

// Set page orientation and size
        $this->phpexcel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
        $this->phpexcel->getActiveSheet()->getPageSetup()->setPaperSize(PHPExcel_Worksheet_PageSetup::PAPERSIZE_LETTER);

// Rename first worksheet
        $this->phpexcel->getActiveSheet()->setTitle('PORTADA');

        //MENSUAL
        $i = 1;
        $newWorkSheet = new PHPExcel_Worksheet($this->phpexcel, 'MENSUAL');
        $this->phpexcel->addSheet($newWorkSheet, $i);

        $organismos = BalanceAlimTable::getInstance()->organismos($time);

        $headers = $this->headers_basedatos($time);
        $balanceAlim = $this->balance_bd($time);
        $valores = $this->matrix_de_valores_ajuste_productos($time);
        $matrix = $this->create_matrix($headers, $balanceAlim, $valores);

        $pr1 = $this->proveedores_bd($time);
        $pr2 = $this->proveedores_bd2($time);
        $proveedores = $this->count_distinct($pr1, $pr2, 'nombre');

// Add some data
        $this->phpexcel->getSheet($i)->setCellValue('A1', 'BALANCE DE ALIMENTO DEL MES');
        $this->phpexcel->getSheet($i)->getStyle('A1')->getAlignment()->setIndent(1);
        $this->phpexcel->getSheet($i)->mergeCells('A1:D1');
        $this->phpexcel->getSheet($i)->getStyle('B1')->getProtection()->setLocked(PHPExcel_Style_Protection::PROTECTION_UNPROTECTED);

        // Set fills
        $this->phpexcel->getSheet($i)->getStyle('A2')->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getSheet($i)->getStyle('A2')->getFill()->getStartColor()->setARGB('FF808080');

        // Set fonts
        $this->phpexcel->getSheet($i)->getStyle('A1')->getFont()->setName('Candara');
        $this->phpexcel->getSheet($i)->getStyle('A1')->getFont()->setSize(19);
        $this->phpexcel->getSheet($i)->getStyle('A1')->getFont()->setBold(true);
        $this->phpexcel->getSheet($i)->getStyle('A1')->getFont()->setUnderline(PHPExcel_Style_Font::UNDERLINE_SINGLE);
        $this->phpexcel->getSheet($i)->getStyle('A1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);


        $this->phpexcel->getSheet($i)->getColumnDimension('A')->setAutoSize(true);
        $this->phpexcel->getSheet($i)->setCellValue('A4', 'TOTAL CAP');
        $this->phpexcel->getSheet($i)->getStyle('A4')->getAlignment()->setHorizontal(
                PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $this->phpexcel->getSheet($i)->getStyle('A4')->applyFromArray($this->styles('blackStyle'));

        $this->phpexcel->getSheet($i)->getStyle('A3')->applyFromArray($this->styles('headerStyle'));

        //NOMBRE DE LAS COLUMNAS
        $this->phpexcel->getSheet($i)->setCellValue('A3', 'ENTIDAD/COMEDOR');
        $this->phpexcel->getSheet($i)->getStyle('A3')->applyFromArray($this->styles('headerStyle'));

        $indice_organismos = array();
        $x = 5;
        foreach ($organismos as $org) {
            $entityNames = BalanceAlimTable::getInstance()->entidadesPorOrganismo($time, $org['organismo_id']);
            $organism = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow(0, $x, $org['organismo_nombre'], true);
            $this->phpexcel->getSheet($i)->getStyle($organism->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $this->phpexcel->getSheet($i)->getStyle($organism->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);

            $row_org = $x;
            $arr_temp = array();
            for ($index = 1; $index <= count($headers); $index++) {
                $total_coord = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($index, $x);
                array_push($arr_temp, $total_coord->getCoordinate());
            }
            array_push($indice_organismos, $arr_temp);

            $x = $x + 1;
            $total_1 = array();
            foreach ($entityNames as $en) {
                $arr = BalanceAlimTable::getInstance()->balance_alimentacion_tabla($en['entidad_id']);
                $a = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow(0, $x, $en['entidad_nombre'], true);
                $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->getAlignment()->setIndent(1);
                $a1 = $this->phpexcel->getSheet($i)->getCellByColumnAndRow(1, $x);
                $this->phpexcel->getSheet($i)->getStyle($a1->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                $total_cap_por_org = array();
                for ($index = 1; $index <= count($headers); $index++) {
                    $aa = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($index, $x);
                    $this->phpexcel->getSheet($i)->getStyle($aa->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                    $this->phpexcel->getSheet($i)->getStyle($aa->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                    $next = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($index, $x + 1);
                    $coord1 = $next->getCoordinate();
                    $last = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($index, count($arr) + $x);
                    $coord2 = $last->getCoordinate();
                    $total_coord = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($index, $x, '=IF(SUM(' . $coord1 . ':' . $coord2 . ')>0,0,1)', true);
                    $total_cell = $total_coord->getCoordinate();
                    $this->phpexcel->getSheet($i)->getStyle($total_cell)->getNumberFormat()->setFormatCode('#,##0.000');
                    array_push($total_cap_por_org, $total_cell);
                }
                array_push($total_1, $total_cap_por_org);
                $x = $x + 1;
                foreach ($arr as $value) {
                    $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow(0, $x, $value['comedor_nombre']);
                    $a = $this->phpexcel->getSheet($i)->getCellByColumnAndRow(0, $x);
                    $coord_a = $a->getCoordinate();
                    $this->phpexcel->getSheet($i)->getStyle($coord_a)->applyFromArray($this->styles('borderStyle'));
                    $this->phpexcel->getSheet($i)->getStyle($coord_a)->getAlignment()->setIndent(2);

                    $col = 1;
                    foreach ($matrix[$value['id']] as $producto_id) {
                        $result_query = BaseDatosTable::getInstance()->valor_producto_mes($value['balance_id'], $producto_id);
                        $result = 0;
                        if (count($result_query) > 0) {
                            $result = $result_query[0]['valor_mes'];
                            $ajuste = $result_query[0]['ajuste_mes'] * $result / 100;
                            $result = $result + $ajuste;
                        }
                        $a = $this->phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col, $x, $result, true);
                        $coordin = $a->getCoordinate();
                        $this->phpexcel->getSheet($i)->getStyle($coordin)->applyFromArray($this->styles('borderStyle'));
                        $this->phpexcel->getSheet($i)->getStyle($coordin)->getNumberFormat()->setFormatCode('#,##0.000');
                        $col = $col + 1;
                    }
                    $x = $x + 1;
                }
            }


            $total = array();
            foreach ($total_1[0] as $value) {
                array_push($total, $value);
            }
            //quitar el primer elemento de la lista
            array_shift($total_1);
            foreach ($total_1 as $arr) {
                for ($index = 0; $index < count($arr); $index++) {
                    $total[$index] = $total[$index] . '+' . $arr[$index];
                }
            }
            for ($index = 1; $index <= count($headers); $index++) {
                $sum_coord = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($index, $row_org, '=' . $total[$index - 1], true);
                $this->phpexcel->getSheet($i)->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLACK);
                $this->phpexcel->getSheet($i)->getStyle($sum_coord->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                $this->phpexcel->getSheet($i)->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);
                $this->phpexcel->getSheet($i)->getStyle($sum_coord->getCoordinate())->getNumberFormat()->setFormatCode('#,##0.000');
            }
        }

        //TOTAL GENERAL
        $total = array();
        foreach ($indice_organismos[0] as $value) {
            array_push($total, $value);
        }
        //quitar el primer elemento de la lista
        array_shift($indice_organismos);
        foreach ($indice_organismos as $arr) {
            for ($index = 0; $index < count($arr); $index++) {
                $total[$index] = $total[$index] . '+' . $arr[$index];
            }
        }

        for ($index = 1; $index <= count($headers); $index++) {
            $sum_coord = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($index, 4, '=' . $total[$index - 1], true);
            $this->phpexcel->getSheet($i)->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLACK);
            $this->phpexcel->getSheet($i)->getStyle($sum_coord->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $this->phpexcel->getSheet($i)->getStyle($sum_coord->getCoordinate())->getNumberFormat()->setFormatCode('#,##0.000');
        }
        $coord = $this->phpexcel->getSheet($i)->getCellByColumnAndRow(1, 4);
        $this->phpexcel->getSheet($i)->getStyle($coord->getCoordinate())->applyFromArray($this->styles('blackStyle'));



        $t = 1;
        foreach ($proveedores as $value) {
            $a = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($t, 2, $value[0], true);
            $coordA = $a->getCoordinate();
            $b = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($t + $value[1] - 1, 2);
            $coordB = $b->getCoordinate();
            $this->phpexcel->getSheet($i)->mergeCells($coordA . ':' . $coordB);
            $this->phpexcel->getSheet($i)->getStyle($coordA . ':' . $coordB)->applyFromArray($this->styles('headerStyle'));
            $this->phpexcel->getSheet($i)->getStyle($coordA . ':' . $coordB)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

            $t = $t + $value[1];
        } $j = 1;
        foreach ($headers as $value) {
            $a = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($j, 3, $value['nombre_producto'], true);
            $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->getAlignment()->setTextRotation(90);
            $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->applyFromArray($this->styles('headerStyle'));
            $j = $j + 1;
        }

        $lastColumn_row1 = count($headers);
        $lastCell = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($lastColumn_row1, 1);
        $this->phpexcel->getSheet($i)->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getSheet($i)->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->getStartColor()->setARGB('FF808080');


// Set header and footer. When no different headers for odd/even are used, odd header is assumed.
        $this->phpexcel->getSheet($i)->getHeaderFooter()->setOddHeader('&RFecha &D');
        $this->phpexcel->getSheet($i)->getHeaderFooter()->setOddFooter('&L&B' . $this->phpexcel->getProperties()->getTitle() . '&RPage &P of &N');

// Set page orientation and size
        $this->phpexcel->getSheet($i)->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
        $this->phpexcel->getSheet($i)->getPageSetup()->setPaperSize(PHPExcel_Worksheet_PageSetup::PAPERSIZE_LETTER);


        //Sumatoria de TOTAL CAP
        for ($col_number = 1; $col_number <= count($headers); $col_number++) {
            $a = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($col_number, 4);
            $a_coor = $a->getCoordinate();
            $suma = '=MENSUAL!' . $a_coor;
            $f = $this->phpexcel->getSheet(0)->setCellValueByColumnAndRow($col_number, 6 + $num_fuentes, $suma, true);
            $this->phpexcel->getSheet(0)->getStyle($f->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $this->phpexcel->getSheet(0)->getStyle($f->getCoordinate())->getNumberFormat()->setFormatCode('#,##0.000');
        }
        $i = $i + 1;

        //EVENTOS
        $newWorkSheet = new PHPExcel_Worksheet($this->phpexcel, 'EVENTOS');
        $this->phpexcel->addSheet($newWorkSheet, $i);
        $headers = $this->headers_eventos($time);

        $items3 = $this->entidades_eventos($time);

        $org = $this->organismos_eventos($time);
        $org2 = $this->organismos_eventos2($time);
        $organismos = $this->count_distinct($org, $org2, 'org_nombre');

        $pr1 = $this->proveedores_eventos($time);
        $pr2 = $this->proveedores_eventos2($time);
        $proveedores = $this->count_distinct($pr1, $pr2, 'nombre');

        $items4 = $this->matrix_de_valores_eventos($time);

        $arr = $this->create_matrix($headers, $items3, $items4);

        $this->phpexcel->getSheet($i)->setCellValue('B1', 'EVENTOS');
        $this->phpexcel->getSheet($i)->mergeCells('B1:C1');
        $this->phpexcel->getSheet($i)->getStyle('B1')->getProtection()->setLocked(PHPExcel_Style_Protection::PROTECTION_UNPROTECTED);
        // Set fonts
        $this->phpexcel->getSheet($i)->getStyle('B1')->getFont()->setName('Candara');
        $this->phpexcel->getSheet($i)->getStyle('B1')->getFont()->setSize(20);
        $this->phpexcel->getSheet($i)->getStyle('B1')->getFont()->setBold(true);
        $this->phpexcel->getSheet($i)->getStyle('B1')->getFont()->setUnderline(PHPExcel_Style_Font::UNDERLINE_SINGLE);
        $this->phpexcel->getSheet($i)->getStyle('B1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);


//        $this->phpexcel->getSheet($i)->setCellValue('E1', PHPExcel_Shared_Date::PHPToExcel(gmmktime(0, 0, 0, date('m'), date('d'), date('Y'))));
//        $this->phpexcel->getSheet($i)->getStyle('E1')->getNumberFormat()->setFormatCode(PHPExcel_Style_NumberFormat::FORMAT_DATE_XLSX15);

        $this->phpexcel->getSheet($i)->setCellValue('B3', 'ORGANISMO/ENTIDAD');
        $this->phpexcel->getSheet($i)->setCellValue('A3', 'REEUP');
        $this->phpexcel->getSheet($i)->getColumnDimension('B')->setAutoSize(true);
        $this->phpexcel->getSheet($i)->setCellValue('B4', 'RESERVA DE BALANCE');
        $this->phpexcel->getSheet($i)->getStyle('A4')->applyFromArray($this->styles('blackStyle'));
        $this->phpexcel->getSheet($i)->getStyle('B4')->applyFromArray($this->styles('blackStyle'));

        $this->phpexcel->getSheet($i)->getStyle('A3')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getSheet($i)->getStyle('B3')->applyFromArray($this->styles('headerStyle'));
        $this->phpexcel->getSheet($i)->getStyle('A2:B2')->applyFromArray($this->styles('headerStyle'));

        $reserva = array();
        $zz = 5;
        foreach ($organismos as $value) {
            $firstCell = $this->phpexcel->getSheet($i)->getCellByColumnAndRow(0, $zz);
            $this->phpexcel->getSheet($i)->getStyle($firstCell->getCoordinate())->applyFromArray($this->styles('borderStyle'));
            $coor = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow(1, $zz, $value[0], true);
            $this->phpexcel->getSheet($i)->getStyle($coor->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);
            $this->phpexcel->getSheet($i)->getStyle($coor->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $total_cap_por_org = array();
            for ($index = 2; $index <= count($headers) + 1; $index++) {
                $sum_coord = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($index, $zz);
                $this->phpexcel->getSheet($i)->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                array_push($total_cap_por_org, $sum_coord->getCoordinate());
            }
            array_push($reserva, $total_cap_por_org);
            $row = $zz;
            $zz = $zz + 1;
            $entidades = $this->entidades_por_organismo_eventos($time, $value[0]);
            $subtotal = array();
            foreach ($entidades as $value2) {
                $a = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow(1, $zz, $value2['nombre_entidad'], true);
                $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->getAlignment()->setIndent(1);
                $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $b = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow(0, $zz, $value2['reeup'], true);
                $this->phpexcel->getSheet($i)->getStyle($b->getCoordinate())->applyFromArray($this->styles('borderStyle'));

                //sumatoria almuerzo+comida+merienda
                $subtotal_fila = array();
                $x = 2;
                foreach ($headers as $val) {
                    $a = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($x, $zz + 1);
                    $a_coor = $a->getCoordinate();
                    $b = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($x, $zz + 3);
                    $b_coor = $b->getCoordinate();
                    $sumatoria = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($x, $zz, '=SUM(' . $a_coor . ':' . $b_coor . ')', true);
                    $this->phpexcel->getSheet($i)->getStyle($sumatoria->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                    array_push($subtotal_fila, $sumatoria->getCoordinate());
                    $x = $x + 1;
                }
                array_push($subtotal, $subtotal_fila);
                $zz = $zz + 1;

                //Almuerzo
                $first = $this->phpexcel->getSheet($i)->getCellByColumnAndRow(0, $zz);
                $this->phpexcel->getSheet($i)->getStyle($first->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $a = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow(1, $zz, "Almuerzo", true);
                $almuerzo = $a->getCoordinate();
                $this->phpexcel->getSheet($i)->getStyle($almuerzo)->applyFromArray($this->styles('borderStyle'));
                $this->phpexcel->getSheet($i)->getStyle($almuerzo)->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                $this->phpexcel->getSheet($i)->getStyle($almuerzo)->getAlignment()->setIndent(2);
                $x = 2;
                foreach ($headers as $val) {
                    $bd = BaseDatosTable::getInstance()->eventos($year . '%', $value2['entidad_id'], $val['producto_id']);
                    foreach ($bd as $bd_iter) {
                        $alm = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($x, $zz, $bd_iter['almuerzo'], true);
                        //-----Agregar Comentario-------
                        $alm_coord = $alm->getCoordinate();
                        $this->phpexcel->getSheet($i)->getComment($alm_coord)->setAuthor('PHPExcel');
                        $objCommentRichText = $this->phpexcel->getSheet($i)->getComment($alm_coord)->getText()->createTextRun('Fórmula:');
                        $objCommentRichText->getFont()->setBold(true);
                        $this->phpexcel->getSheet($i)->getComment($alm_coord)->getText()->createTextRun("\r\n");
                        $this->phpexcel->getSheet($i)->getComment($alm_coord)->getText()->createTextRun('Se multiplica el '
                                . 'valor del almuerzo(Nivel de actividad) del evento por el valor del producto(Base de datos).');
                        //-----------------------------

                        $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($x, $zz + 1, $bd_iter['comida']);
                        $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($x, $zz + 2, $bd_iter['merienda']);
                    }
                    $celda = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($x, $zz);
                    $this->phpexcel->getSheet($i)->getStyle($celda->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                    $celda = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($x, $zz + 1);
                    $this->phpexcel->getSheet($i)->getStyle($celda->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                    $celda = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($x, $zz + 2);
                    $this->phpexcel->getSheet($i)->getStyle($celda->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                    $x = $x + 1;
                }
                $zz = $zz + 1;

                //Comida
                $first = $this->phpexcel->getSheet($i)->getCellByColumnAndRow(0, $zz);
                $this->phpexcel->getSheet($i)->getStyle($first->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $a = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow(1, $zz, "Comida", true);
                $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->getAlignment()->setIndent(2);
                $zz = $zz + 1;

                //Merienda
                $first = $this->phpexcel->getSheet($i)->getCellByColumnAndRow(0, $zz);
                $this->phpexcel->getSheet($i)->getStyle($first->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $a = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow(1, $zz, "Merienda", true);
                $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->getAlignment()->setIndent(2);
                $zz = $zz + 1;

                //Conceptos
                $ev = EventosTable::getInstance()->eventos($year . '%', $value2['entidad_id']);
                foreach ($ev as $iter) {
                    $first = $this->phpexcel->getSheet($i)->getCellByColumnAndRow(0, $zz);
                    $this->phpexcel->getSheet($i)->getStyle($first->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                    $a = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow(1, $zz, $iter['concepto'], true);
                    $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                    $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
                    $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->getAlignment()->setIndent(2);

                    //Valor de los conceptos
                    $x = 2;
                    foreach ($headers as $val) {
                        $event = EventosTable::getInstance()->eventos_por_producto($year . '%', $value2['entidad_id'], $val['producto_id']);
                        foreach ($event as $event_iter) {
                            $a = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($x, $zz, $event_iter['cantidad'], true);
                        }
                        $a = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($x, $zz);
                        $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                        $x = $x + 1;
                    }
                    $zz = $zz + 1;
                }

                //Ajustes
                $first = $this->phpexcel->getSheet($i)->getCellByColumnAndRow(0, $zz);
                $this->phpexcel->getSheet($i)->getStyle($first->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $a = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow(1, $zz, "Ajustes", true);
                $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_RED);
                $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->getAlignment()->setIndent(2);
                $x = 2;
                foreach ($headers as $val) {
                    $a = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($x, $zz);
                    $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                    $x = $x + 1;
                }
                $zz = $zz + 1;

                //%
                $first = $this->phpexcel->getSheet($i)->getCellByColumnAndRow(0, $zz);
                $this->phpexcel->getSheet($i)->getStyle($first->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $a = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow(1, $zz, "%", true);
                $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->getAlignment()->setIndent(2);
                $x = 2;
                foreach ($headers as $val) {
                    $a = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($x, $zz);
                    $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                    $x = $x + 1;
                }
                $zz = $zz + 1;
            }

            //Subtotal por organismo
            $total = array();
            foreach ($subtotal[0] as $value) {
                array_push($total, $value);
            }
            //quitar el primer elemento de la lista
            array_shift($subtotal);
            foreach ($subtotal as $arr) {
                for ($index = 0; $index < count($arr); $index++) {
                    $total[$index] = $total[$index] . '+' . $arr[$index];
                }
            }
            for ($index = 2; $index <= count($headers) + 1; $index++) {
                $sum_coord = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($index, $row, '=' . $total[$index - 2], true);
                $this->phpexcel->getSheet($i)->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLACK);
                $this->phpexcel->getSheet($i)->getStyle($sum_coord->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            }
        }
        $t = 2;
        foreach ($proveedores as $value) {
            $a = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($t, 2, $value[0], true);
            $coordA = $a->getCoordinate();
            $b = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($t + $value[1] - 1, 2);
            $coordB = $b->getCoordinate();
            $this->phpexcel->getSheet($i)->mergeCells($coordA . ':' . $coordB);
            $this->phpexcel->getSheet($i)->getStyle($coordA . ':' . $coordB)->applyFromArray($this->styles('headerStyle'));
            $this->phpexcel->getSheet($i)->getStyle($coordA . ':' . $coordB)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

            $t = $t + $value[1];
        }
        $j = 2;
        foreach ($headers as $value) {
            $a = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($j, 3, $value['nombre_producto'], true);
            $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->getAlignment()->setTextRotation(90);
            $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->applyFromArray($this->styles('headerStyle'));
            $j = $j + 1;
        }
        //$this->phpexcel->getSheet($i)->fromArray($arr, null, 'B5', false);
        $this->phpexcel->getSheet($i)->getStyle('E1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);

        //Crear formula para el total general
        $row_four = 4;
        $total = array();
        foreach ($reserva[0] as $value) {
            array_push($total, $value);
        }
        //quitar el primer elemento de la lista
        array_shift($reserva);
        foreach ($reserva as $arr) {
            for ($index = 0; $index < count($arr); $index++) {
                $total[$index] = $total[$index] . '+' . $arr[$index];
            }
        }
        for ($index = 2; $index <= count($headers) + 1; $index++) {
            $sum_coord = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($index, $row_four, '=' . $total[$index - 2], true);
            $this->phpexcel->getSheet($i)->getStyle($sum_coord->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLACK);
            $this->phpexcel->getSheet($i)->getStyle($sum_coord->getCoordinate())->applyFromArray($this->styles('blackStyle'));
        }


// Set fills
        $lastColumn_row1 = count($headers) + 1;
        $lastCell = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($lastColumn_row1, 1);
        $this->phpexcel->getSheet($i)->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getSheet($i)->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->getStartColor()->setARGB('FF808080');

// Set header and footer. When no different headers for odd/even are used, odd header is assumed.
        $this->phpexcel->getSheet($i)->getHeaderFooter()->setOddHeader('&RFecha &D');
        $this->phpexcel->getSheet($i)->getHeaderFooter()->setOddFooter('&L&B' . $this->phpexcel->getProperties()->getTitle() . '&RPage &P of &N');

// Set page orientation and size
        $this->phpexcel->getSheet($i)->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
        $this->phpexcel->getSheet($i)->getPageSetup()->setPaperSize(PHPExcel_Worksheet_PageSetup::PAPERSIZE_LETTER);

        $i = $i + 1;

        //ORGANISMOS NOMINALIZADOS
        $newWorkSheet = new PHPExcel_Worksheet($this->phpexcel, 'NOMINALIZADOS Y OTROS');
        $this->phpexcel->addSheet($newWorkSheet, $i);
        $headers = $this->headers_nominalizados($time);

        $items3 = $this->organismos_nominalizados($time);

        $pr1 = $this->proveedores_nominalizados($time);
        $pr2 = $this->proveedores_nominalizados2($time);
        $proveedores = $this->count_distinct($pr1, $pr2, 'nombre');

        $items4 = $this->data_nominalizados($time);

        $arr = $this->create_matrix($headers, $items3, $items4);

// Add some data
        $this->phpexcel->getSheet($i)->setCellValue('A1', 'Organismos Nominalizados');
        $this->phpexcel->getSheet($i)->mergeCells('A1:B1');
        $this->phpexcel->getSheet($i)->getStyle('A1')->getProtection()->setLocked(PHPExcel_Style_Protection::PROTECTION_UNPROTECTED);
        // Set fonts
        $this->phpexcel->getSheet($i)->getStyle('A1')->getFont()->setName('Candara');
        $this->phpexcel->getSheet($i)->getStyle('A1')->getFont()->setSize(20);
        $this->phpexcel->getSheet($i)->getStyle('A1')->getFont()->setBold(true);
        $this->phpexcel->getSheet($i)->getStyle('A1')->getFont()->setUnderline(PHPExcel_Style_Font::UNDERLINE_SINGLE);
        $this->phpexcel->getSheet($i)->getStyle('A1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);


        $this->phpexcel->getSheet($i)->setCellValue('A3', 'Nombre');
        $this->phpexcel->getSheet($i)->getColumnDimension('A')->setAutoSize(true);
        $this->phpexcel->getSheet($i)->setCellValue('A4', 'Total');
        $this->phpexcel->getSheet($i)->getStyle('A4')->applyFromArray($this->styles('blackStyle'));

        for ($index = 1; $index <= count($headers); $index++) {
            $a = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($index, 4);
            $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $next = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($index, 5);
            $coord1 = $next->getCoordinate();
            $last = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($index, count($items3) + 4);
            $coord2 = $last->getCoordinate();
            $formula = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($index, 4, '=SUM(' . $coord1 . ':' . $coord2 . ')', true);
            $this->phpexcel->getSheet($i)->getStyle($formula->getCoordinate())->getNumberFormat()->setFormatCode('#,##0.000');
        }
        $this->phpexcel->getSheet($i)->getStyle('A3')->applyFromArray($this->styles('headerStyle'));
        $iii = 5;
        foreach ($items3 as $value) {
            $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow(0, $iii, $value['nombre_entidad']);
            $a = $this->phpexcel->getSheet($i)->getCellByColumnAndRow(0, $iii);
            $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
            $iii = $iii + 1;
        }

        $t = 1;
        foreach ($proveedores as $value) {
            $a = $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($t, 2, $value[0], true);
            $coordA = $a->getCoordinate();
            $b = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($t + $value[1] - 1, 2);
            $coordB = $b->getCoordinate();
            $this->phpexcel->getSheet($i)->mergeCells($coordA . ':' . $coordB);
            $this->phpexcel->getSheet($i)->getStyle($coordA . ':' . $coordB)->applyFromArray($this->styles('headerStyle'));
            $this->phpexcel->getSheet($i)->getStyle($coordA . ':' . $coordB)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);

            $t = $t + $value[1];
        }

        $j = 1;
        foreach ($headers as $value) {
            $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($j, 3, $value['nombre_producto']);
            $a = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($j, 3);
            $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->getAlignment()->setTextRotation(90);
            $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->applyFromArray($this->styles('headerStyle'));
            $j = $j + 1;
        }

        $y = 5;
        foreach ($arr as $v) {
            $x = 1;
            foreach ($v as $v2) {
                $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($x, $y, $v2);
                $a = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($x, $y);
                $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->applyFromArray($this->styles('borderStyle'));
                $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->getNumberFormat()->setFormatCode('#,##0.000');
                $x = $x + 1;
            }$y = $y + 1;
        }

        //MERCADOS
        $mercados = NomMercadoTable::getInstance()->mercados($time);
        foreach ($mercados as $value) {
            $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow(0, $iii, $value['nombre']);
            $a = $this->phpexcel->getSheet($i)->getCellByColumnAndRow(0, $iii);
            $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->applyFromArray($this->styles('blackStyle'));
            $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_BLUE);
            $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->getAlignment()->setIndent(2);
            $j = 1;
            foreach ($headers as $v) {
                $cantidad = 0;
                $arr = ProductoMercadoTable::getInstance()->cantidad($time, $v['producto_id'], $value['mercado_id']);
                if ($arr && $arr[0]) {
                    $obj = $arr[0];
                    $cantidad = $obj['cantidad'];
                }
                $this->phpexcel->getSheet($i)->setCellValueByColumnAndRow($j, $iii, $cantidad);
                $a = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($j, $iii);
                $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->applyFromArray($this->styles('blackStyle'));
                $this->phpexcel->getSheet($i)->getStyle($a->getCoordinate())->getNumberFormat()->setFormatCode('#,##0.000');
                $j = $j + 1;
            }
            $iii = $iii + 1;
        }

        //$this->phpexcel->getSheet($i)->fromArray($arr, null, 'B5', false);
        $this->phpexcel->getSheet($i)->getStyle('D1')->getFont()->getColor()->setARGB(PHPExcel_Style_Color::COLOR_WHITE);

// Set fills
        $lastColumn_row1 = count($headers);
        $lastCell = $this->phpexcel->getSheet($i)->getCellByColumnAndRow($lastColumn_row1, 1);
        $this->phpexcel->getSheet($i)->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getSheet($i)->getStyle('A1:' . $lastCell->getCoordinate())->getFill()->getStartColor()->setARGB('FF808080');
        $this->phpexcel->getSheet($i)->getStyle('A2')->getFill()->setFillType(PHPExcel_Style_Fill::FILL_SOLID);
        $this->phpexcel->getSheet($i)->getStyle('A2')->getFill()->getStartColor()->setARGB('FF808080');

// Set header and footer. When no different headers for odd/even are used, odd header is assumed.
        $this->phpexcel->getSheet($i)->getHeaderFooter()->setOddHeader('&RFecha &D');
        $this->phpexcel->getSheet($i)->getHeaderFooter()->setOddFooter('&L&B' . $this->phpexcel->getProperties()->getTitle() . '&RPage &P of &N');

// Set page orientation and size
        $this->phpexcel->getSheet($i)->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
        $this->phpexcel->getSheet($i)->getPageSetup()->setPaperSize(PHPExcel_Worksheet_PageSetup::PAPERSIZE_LETTER);

// Set active sheet index to the first sheet, so Excel opens this as the first sheet
        $this->phpexcel->setActiveSheetIndex(1);

        return $this->phpexcel;
    }

    private function columna_a() {
        $arr = array();
        array_push($arr, array(0 => 'DESTINOS', 1 => 0, 2 => 'blackStyle'));
        array_push($arr, array(0 => 'TOTAL CAP', 1 => 0, 2 => 'blackStyle'));

        array_push($arr, array(0 => 'Grupo Empresarial de Comercio y la G.', 1 => 0, 2 => 'blackStyle'));
        array_push($arr, array(0 => 'Gastronomía', 1 => 2, 2 => 'borderStyle'));
        array_push($arr, array(0 => 'SAF', 1 => 2, 2 => 'borderStyle'));
        array_push($arr, array(0 => 'Otros', 1 => 2, 2 => 'borderStyle'));
        array_push($arr, array(0 => 'Mercado Ideal', 1 => 2, 2 => 'borderStyle'));
        array_push($arr, array(0 => 'Ventas Liberadas', 1 => 2, 2 => 'borderStyle'));
        array_push($arr, array(0 => 'Cuenta Propia', 1 => 2, 2 => 'borderStyle'));
        array_push($arr, array(0 => 'Canasta Familiar', 1 => 2, 2 => 'borderStyle'));
        array_push($arr, array(0 => 'De ello: Población', 1 => 5, 2 => 'borderStyle'));
        array_push($arr, array(0 => 'Dietas Médicas', 1 => 7, 2 => 'borderStyle'));

        array_push($arr, array(0 => 'Consumo Social', 1 => 0, 2 => 'blackStyle'));
        array_push($arr, array(0 => 'Sectorial Provincial de Salud', 1 => 2, 2 => 'borderStyle'));
        array_push($arr, array(0 => 'Sectorial Provincial de Educación G.', 1 => 2, 2 => 'borderStyle'));
        array_push($arr, array(0 => 'Educación Superior', 1 => 2, 2 => 'borderStyle'));
        array_push($arr, array(0 => 'Dirección Provincial de Deportes', 1 => 2, 2 => 'borderStyle'));
        array_push($arr, array(0 => 'Dirección Provincial de Cultura', 1 => 2, 2 => 'borderStyle'));
        array_push($arr, array(0 => 'Resto de las Actividades (Total)', 1 => 2, 2 => 'borderStyle'));
        array_push($arr, array(0 => 'Organismos Subordinación Local', 1 => 2, 2 => 'borderStyle'));
        array_push($arr, array(0 => 'Organismos Subordinación Nacional', 1 => 2, 2 => 'borderStyle'));
        array_push($arr, array(0 => 'Otras Actividades Gastronómicas', 1 => 2, 2 => 'borderStyle'));
        array_push($arr, array(0 => 'Actos y Eventos', 1 => 2, 2 => 'borderStyle'));
        array_push($arr, array(0 => 'Actividades Atendidas por las DMEP', 1 => 2, 2 => 'borderStyle'));

        array_push($arr, array(0 => 'Consumo Intermedio', 1 => 0, 2 => 'blackStyle'));
        array_push($arr, array(0 => 'Nominalizados', 1 => 0, 2 => 'blackStyle'));
        array_push($arr, array(0 => 'Reserva del Balance', 1 => 0, 2 => 'blackStyle'));

        return $arr;
    }

    public function generar_xls_portada($year) {
        $excel = $this->generar_reporte_portada($year);
        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="portada-' . $year . '.xlsx"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($excel, 'Excel2007');
        $objWriter->save('php://output');
    }

    public function generar_pdf_portada($year) {
        $this->load->library('mpdf');
        $excel = $this->generar_reporte_portada($year);
        // Redirect output to a client’s web browser (Excel2007)
        header('Content-Type: application/pdf');
        header('Content-Disposition: attachment;filename="portada-' . $year . '.pdf"');
        header('Cache-Control: max-age=0');

        $objWriter = PHPExcel_IOFactory::createWriter($excel, 'PDF');
        $objWriter->save('php://output');
    }

}
