<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

/**
 * @method NomProductoTable _getTable() Nom Producto Table
 */
class Producto extends MY_Controller {

    protected $_model = "NomProducto";

    /**
     * Lista de items.
     */
    public function index() {
        $start = $this->input->get('start', TRUE);
        $limit = $this->input->get('limit', TRUE);
        $items = $this->_getTable()->findAllWithUmProveedor($start, $limit);
        $this->_jsonResponse2(count($this->_getTable()->findAll()), $items);
    }

    public function save() {
        $post = $this->_post(NULL, TRUE);
        try {
            if (is_array($post)) {
                $um = NomUmTable::getInstance()->find($post['um_id']);
                if (!$um) {//Si la unidad de medida no existe devuelvo un error
                    $msg = "Unidad de Medida no encontrada.";
                    return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                }
                $proveedor = NomProveedorTable::getInstance()->find($post['proveedor_id']);
                if (!$proveedor) {//Si el proveedor no existe devuelvo un error
                    $msg = "Proveedor no encontrado.";
                    return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                }
                if ($post['id']) {
                    $producto = $this->_getTable()->find($post['id']);
                    if (!$producto) {//Si el producto no existe devuelvo un error
                        $msg = "Producto no encontrado.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else {
                    $producto = new NomProducto();
                }
                $producto->fromArray($post, false);
                $producto->set('Um', $um);
                $producto->set('Proveedor', $proveedor);
                $producto->save();

                $this->_jsonResponse($producto->toArray());
            }
        } catch (Exception $exc) {
            log_message('error', $exc->getMessage());
            log_message('error', $exc->getTraceAsString());
            $this->_jsonResponse(array(
                "msg" => "Ha ocurrido un error mientras se intentaba guardar un producto."
                    ), 500);
        }
    }

    public function findbyproveedor() {
        $proveedor_id = $this->input->get('proveedor', TRUE);
        $entidad_id = $this->input->get('entidad', TRUE);
        if ($proveedor_id) {
            $items = $this->_getTable()->findByProveedorId($proveedor_id, $entidad_id);
            $this->_jsonResponse($items);
        }
    }

    public function findbyproveedor_consumointer() {
        $proveedor_id = $this->input->get('proveedor', TRUE);
        $entidad_id = $this->input->get('entidad', TRUE);
        if ($proveedor_id) {
            $items = $this->_getTable()->findByProveedorId_ConsumoInter($proveedor_id, $entidad_id);
            $this->_jsonResponse($items);
        }
    }

    public function findbyproveedor2() {
        $proveedor_id = $this->input->get('proveedor', TRUE);
        if ($proveedor_id) {
            $items = $this->_getTable()->findByProveedorId2($proveedor_id);
            $this->_jsonResponse($items);
        }
    }

    public function findbyproveedorboleta() {
        $proveedor_id = $this->input->get('proveedor', TRUE);
        $boleta_id = $this->input->get('boleta_id', TRUE);
        if ($proveedor_id) {
            $items = $this->_getTable()->findByProveedorId_Boleta($proveedor_id, $boleta_id);
            $this->_jsonResponse($items);
        }
    }

    public function findbyproveedorbd() {
        $proveedor_id = $this->input->get('proveedor', TRUE);
        $bd_id = $this->input->get('bd_id', TRUE);
        if ($proveedor_id) {
            $items = $this->_getTable()->findByProveedorId_BD($proveedor_id, $bd_id);
            $this->_jsonResponse($items);
        }
    }

    public function findAllByProveedor() {
        $proveedor_id = $this->input->get('proveedor', TRUE);
        if ($proveedor_id) {
            $items = $this->_getTable()->findAllByProveedorId($proveedor_id);
            $this->_jsonResponse($items);
        }
    }

    public function findbyproveedor_nominalizado() {
        $proveedor_id = $this->input->get('proveedor', TRUE);
        $entidad_id = $this->input->get('entidad', TRUE);
        if ($proveedor_id) {
            $items = $this->_getTable()->findNominalizadoByProveedorId($proveedor_id, $entidad_id);
            $this->_jsonResponse($items);
        }
    }

}
