<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

/**
 * @method ProductoFuentesTable _getTable() Nom Producto Table
 */
class ProductoFuente extends MY_Controller {

    protected $_model = "ProductoFuentes";

    /**
     * Lista de items.
     */
    public function index() {
        $start = $_REQUEST['start'];
        $limit = $_REQUEST['limit'];
        $mes = $this->input->get('mes', TRUE);
        $year = $this->input->get('year', TRUE);
        $items = $this->_getTable()->findAllWithProductoFuente($start, $limit, $mes, $year);
        $this->_jsonResponse2(count($this->_getTable()->findAll()), $items);
    }

    public function save() {
        $post = $this->_post(NULL, TRUE);
        try {
            if (is_array($post)) {
                $producto = NomProductoTable::getInstance()->find($post['producto_id']);
                if (!$producto) {//Si el producto no existe devuelvo un error
                    $msg = "Producto no encontrado.";
                    return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                }
                $fuente = NomFuentesTable::getInstance()->find($post['fuentes_id']);
                if (!$fuente) {//Si la fuente no existe devuelvo un error
                    $msg = "Fuente no encontrada.";
                    return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                }
                if ($post['id']) {
                    $productofuente = $this->_getTable()->find($post['id']);
                    if (!$productofuente) {//Si el producto no existe devuelvo un error
                        $msg = "Producto no encontrado.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else {
                    $productofuente = new ProductoFuentes();
                }
                $productofuente->fromArray($post, false);
                $productofuente->set('Producto', $producto);
                $productofuente->set('Fuente', $fuente);
                $productofuente->save();

                $this->_jsonResponse($productofuente->toArray());
            }
        } catch (Exception $exc) {
            log_message('error', $exc->getMessage());
            log_message('error', $exc->getTraceAsString());
            $this->_jsonResponse(array(
                "msg" => "Ha ocurrido un error mientras se intentaba guardar un producto."
                    ), 500);
        }
    }

}
