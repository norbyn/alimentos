<?php

/**
 * ConsumoInter
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 7490 2010-03-29 19:53:27Z jwage $
 */
class ConsumoInterTable extends Doctrine_Table {

    /**
     * Returns an instance of this class.
     *
     * @return ComedorTable
     */
    public static function getInstance() {
        return Doctrine_Core::getTable('ConsumoInter');
    }

    public function findAll($hydrationMode = null) {
        return $this->createQuery('consumo_inter')
                        ->innerJoin('consumo_inter.Producto com')
                        ->innerJoin('consumo_inter.Entidad ent')
                        ->fetchArray();
    }

    public function findAllWithEntidadProducto($mes, $year) {
        if (!$year || $year === '%') {
            $year = date("Y");
        }
        if (!$mes || $mes === '%') {
            $mes = date("m");
        }
        $temp = $year . '-' . $mes . '%';
        return $this->createQuery('consumo_inter')
                        ->select('consumo_inter.*, pro.nombre as producto_nombre'
                                . ',ent.nombre as entidad_nombre,prov.nombre as proveedor')
                        ->innerJoin('consumo_inter.Producto pro')
                        ->innerJoin('pro.Proveedor prov')
                        ->innerJoin('consumo_inter.Entidad ent')
                        ->where('consumo_inter.fecha like "' . $temp . '"')
                        ->orderBy('producto_nombre')
                        ->fetchArray();
    }

    public function findByEntidadId($id, $mes, $year) {
        if (!$year || $year === '%') {
            $year = date("Y");
        }
        if (!$mes || $mes === '%') {
            $mes = date("m");
        }
        $temp = $year . '-' . $mes . '%';
        return $this->createQuery('consumo_inter')
                        ->select('consumo_inter.*,ent.*,pro.*, pro.nombre as producto_nombre')
                        ->innerJoin('consumo_inter.Entidad ent')
                        ->innerJoin('consumo_inter.Producto pro')
                        ->where('ent.id = ?', $id)
                        ->andWhere('consumo_inter.fecha like "' . $temp . '"')
                        ->fetchArray();
    }

}
