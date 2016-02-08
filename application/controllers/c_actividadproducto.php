<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class c_ActividadProducto extends MY_Controller {

    protected $_model = "ActividadProducto";

    public function index() {
        $mes = $this->input->get('mes', TRUE);
        $year = $this->input->get('year', TRUE);
        $items = $this->_getTable()->findAllByProduct($mes, $year);
        $this->_jsonResponse($items);
    }

    public function save() {
        $post = $this->_post(NULL, TRUE);
        try {
            if (is_array($post)) {
                $producto = NomProductoTable::getInstance()->find($post['producto_id']);
                if (!$producto) {
                    $msg = "Producto no encontrado.";
                    return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                }
                $actividad = NomActividadTable::getInstance()->find($post['actividad_id']);
                if (!$actividad) {
                    $msg = "Actividad no encontrada.";
                    return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                }
                if ($post['id']) {
                    $actividad_producto = $this->_getTable()->find($post['id']);
                    if (!$actividad_producto) {
                        $msg = "BoletaProducto no encontrado.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else {
                    $actividad_producto = new ActividadProducto();
                }

                $actividad_producto->fromArray($post, false);
                $actividad_producto->set('Producto', $producto);
                $actividad_producto->set('Actividad', $actividad);
                $actividad_producto->save();

                //Creating security log
                $this->load->library('appunto-auth/appunto_auth');
                $this->appunto_auth->create_security_log(1, "Asignando/Actualizando tabla " . $this->_model . "[id:" . $actividad_producto->id . "]");
                //End security log

                $this->_jsonResponse($actividad_producto->toArray());
            }
        } catch (Exception $exc) {
            log_message('error', $exc->getMessage());
            log_message('error', $exc->getTraceAsString());

            //Creating security log
            $this->load->library('appunto-auth/appunto_auth');
            $this->appunto_auth->create_security_log(0, "Error creando/actualizando tabla " . $this->_model);
            //End security log

            $this->_jsonResponse(array(
                "msg" => "Ha ocurrido un error mientras se intentaba guardar una actividad."
                    ), 500);
        }
    }

    public function findbyproduct() {
        $producto_id = $this->input->get('producto_id', TRUE);
        $mes = $this->input->get('mes', TRUE);
        $year = $this->input->get('year', TRUE);
        if ($producto_id) {
            $items = $this->_getTable()->findAllByProductId($producto_id, $mes, $year);
            $this->_jsonResponse($items);
        }
    }

}
