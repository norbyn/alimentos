<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class c_Disponibilidad extends MY_Controller {

    protected $_model = "Disponibilidad";

    public function index() {
        $mes = $this->input->get('mes', TRUE);
        $year = $this->input->get('year', TRUE);
        $items = $this->_getTable()->findAllWithProduct($mes, $year);
        $this->_jsonResponse($items);
    }

    public function save() {
        $post = $this->_post(NULL, TRUE);
        try {
            if (is_array($post)) {
                $producto = NomProductoTable::getInstance()->find($post['producto_id']);
                if (!$producto) {//Si el producto no existe devuelvo un error
                    $msg = "producto no encontrada.";
                    return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                }
                if ($post['id']) {
                    $obj = $this->_getTable()->find($post['id']);
                    if (!$obj) {
                        $msg = "{$this->_model} no encontrado.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else {
                    $obj = new $this->_model();
                }
                /* @var $obj Disponibilidad */
                $obj->set('Producto', $producto);
                $obj->fromArray($post, false);
                $obj->save();

                $this->_jsonResponse($obj->toArray());
            }
        } catch (Exception $exc) {
            log_message('error', $exc->getMessage());
            log_message('error', $exc->getTraceAsString());
            $this->_jsonResponse(array(
                "msg" => "Ha ocurrido un error mientras se intentaba guardar."
                    ), 500);
        }
    }

    public function findByEntidad() {
        $entidad_id = $this->input->get('entidad', TRUE);
        if ($entidad_id) {
            $items = $this->_getTable()->findByEntidadId($entidad_id);

            $this->_jsonResponse($items);
        }
    }

}
