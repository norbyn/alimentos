<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Nivelact extends MY_Controller {

    protected $_model = "BalanceAlim";

    public function index() {
        $mes = $this->input->get('mes', TRUE);
        $year = $this->input->get('year', TRUE);
        $items = $this->_getTable()->findAllWithComedor($mes, $year);
        $this->_jsonResponse($items);
    }

    public function save() {
        $post = $this->_post(NULL, TRUE);
        try {
            if (is_array($post)) {
                $comedor = ComedorTable::getInstance()->find($post['comedor_id']);
                if (!$comedor) {//Si el comedor no existe devuelvo un error
                    $msg = "Comedor no encontrada.";
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
                //cargar la relacion para poder mostrar el nombre en el grid
                $comedor->get('TipoComedor');

                /* @var $obj BalanceAlim */
                $obj->set('Comedor', $comedor);
                $obj->fromArray($post, false);
                $obj->save();

                $this->_jsonResponse($obj->toArray());
            }
        } catch (Exception $exc) {
            log_message('error', $exc->getMessage());
            log_message('error', $exc->getTraceAsString());
            $this->_jsonResponse(array(
                "msg" => "Ha ocurrido un error mientras se intentaba guardar un comedor."
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
