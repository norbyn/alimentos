<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Reports {

    /**
     * Constructor. 
     */
    public function __construct() {
        $this->CI = & get_instance();
    }

    public function headers_boleta($time, $proveedor) {
        return Doctrine_Query::create()->select('boleta.id, producto.nombre '
                                . 'as nombre_producto, proveedor.nombre as nombre_proveedor'
                                . ',ent.nombre as nombre_entidad,boleta.entidad_id as entidad_id'
                                . ',boleta_producto.id,boleta_producto.producto_id as producto_id,boleta.consec as consecutivo')
                        ->from('BoletaProducto boleta_producto')
                        ->innerJoin('boleta_producto.Boleta boleta')
                        ->innerJoin('boleta_producto.Producto producto')
                        ->innerJoin('boleta.Entidad ent')
                        ->innerJoin('producto.Proveedor proveedor')
                        ->where('boleta.fecha like "' . $time . '"')
                        ->andWhere('boleta.proveedor_id = ?', $proveedor)
                        ->groupBy('producto.id')
                        ->orderBy('proveedor.nombre, producto.nombre')->execute()->toArray(true);
    }
    
}


