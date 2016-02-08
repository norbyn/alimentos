<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Comedores extends MY_Controller {

    protected $_model = "Comedor";

    /**
     * Lista de items.
     */
    public function index() {
        $items = $this->_getTable()->findWithComedorEntidad();
        $this->_jsonResponse($items);
    }
    
    public function save() {
        $post = $this->_post(NULL, TRUE);
        try {
            if (is_array($post)) {
                $entidad = NomEntidadTable::getInstance()->find($post['entidad_id']);
                if (!$entidad) {//Si la entidad no existe devuelvo un error
                    $msg = "Entidad no encontrada.";
                    return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                }
                $nomComedor = NomComedorTable::getInstance()->find($post['nombre_comedor_id']);
                if (!$nomComedor) {//Si el comedor no existe devuelvo un error
                    $msg = "Comedor no encontrado.";
                    return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                }
                if ($post['id']) {
                    $comedor = $this->_getTable()->find($post['id']);
                    if (!$comedor) {//Si el comedor no existe devuelvo un error
                        $msg = "Comedor no encontrado.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else {
                    $comedor = new Comedor();
                }
                $comedor->fromArray($post, false);
                $comedor->set('Entidad', $entidad);
                $comedor->set('TipoComedor', $nomComedor);
                $comedor->save();

                $this->_jsonResponse($comedor->toArray());
            }
        } catch (Exception $exc) {
            log_message('error', $exc->getMessage());
            log_message('error', $exc->getTraceAsString());
            $this->_jsonResponse(array(
                "msg" => "Ha ocurrido un error mientras se intentaba guardar un comedor."
                    ), 500);
        }
    }

    public function findbyentidad() {
        $entidad_id = $this->input->get('entidad', TRUE);
        if ($entidad_id) {
            $items = $this->_getTable()->findByEntidadId($entidad_id);
            $this->_jsonResponse($items);
        }
    }

    public function findallbyentidad() {
        $entidad_id = $this->input->get('entidad', TRUE);
        if ($entidad_id) {
            $items = $this->_getTable()->findAllByEntidadId($entidad_id);
            $this->_jsonResponse($items);
        }
    }

}
