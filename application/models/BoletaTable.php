<?php

/**
 * BoletaTable
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 7490 2010-03-29 19:53:27Z jwage $
 */
class BoletaTable extends Doctrine_Table {

    /**
     * Returns an instance of this class.
     *
     * @return BoletaTable
     */
    public static function getInstance() {
        return Doctrine_Core::getTable('Boleta');
    }

    public function findBoleta() {
        $temp = date("Y-m") . '%';
        return $this->createQuery('boleta')
                        ->innerJoin('boleta.Proveedor pro')
                        ->innerJoin('boleta.Entidad ent')
                        ->where('boleta.fecha like "' . $temp . '"')
                        ->orderBy('boleta.consec')
                        ->fetchArray();
    }

    public function findByEntidad_Id($id) {
        $temp = date("Y-m") . '%';
        return $this->createQuery('boleta')
                        ->select('boleta.*,ent.*,pro.*, pro.nombre as producto_nombre')
                        ->innerJoin('boleta.Entidad ent')
                        ->innerJoin('boleta.Producto pro')
                        ->where('ent.id = ?', $id)
                        ->andWhere('boleta.fecha like "' . $temp . '"')
                        ->fetchArray();
    }

    public function findByProveedor_Id($id, $mes, $year) {
        if ($year === '%') {
            $year = date("Y");
        }
        if ($mes === '%') {
            $mes = date("m");
        }
        $temp = $year . '-' . $mes . '%';
        return $this->createQuery('boleta')
                        ->innerJoin('boleta.Proveedor pro')
                        ->innerJoin('boleta.Entidad ent')
                        ->where('pro.id like "' . $id . '"')
                        ->andWhere('boleta.fecha like "' . $temp . '"')
                        ->orderBy('boleta.consec')
                        ->fetchArray();
    }

    public function findAllByEntidadId($id) {
        return $this->createQuery('boleta')
                        ->innerJoin('boleta.Entidad ent')
                        ->where('boleta.entidad_id = ?', $id)
                        ->fetchArray();
    }

    public function consecutivo() {
        $query = Doctrine_Query::create()->select('boleta.consec as consec')
                ->from('Boleta boleta')
                ->orderBy('boleta.consec desc LIMIT 0, 1');
        $arr = $query->execute()->toArray(true);
        if ($arr)
            return $arr[0]['consec'] + 1;
        else
            return 1;
    }

    public function id($consec, $date) {
        return $this->createQuery('boleta')
                        ->where('boleta.consec = ?', $consec)
                        ->andWhere('boleta.fecha = ?', $date)
                        ->fetchArray();
    }

}
