<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class c_BoletaProducto extends MY_Controller {

    protected $_model = "BoletaProducto";

    /**
     * Lista de items.
     */
    public function index() {
        $items = $this->_getTable()->findBoletaProducto();
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
                $boleta = BoletaTable::getInstance()->find($post['boleta_id']);
                if (!$boleta) {
                    $msg = "Boleta no encontrada.";
                    return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                }
                if ($post['id']) {
                    $boleta_producto = $this->_getTable()->find($post['id']);
                    if (!$boleta_producto) {
                        $msg = "BoletaProducto no encontrado.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else {
                    $boleta_producto = new BoletaProducto();
                }

                $boleta_producto->fromArray($post, false);
                $boleta_producto->set('Producto', $producto);
                $boleta_producto->set('Boleta', $boleta);
                $boleta_producto->save();

                //Creating security log
                $this->load->library('appunto-auth/appunto_auth');
                $this->appunto_auth->create_security_log(1, "Asignando/Actualizando tabla " . $this->_model . "[id:" . $boleta_producto->id . "]");
                //End security log
                
                $this->_jsonResponse($boleta_producto->toArray());
            }
        } catch (Exception $exc) {
            log_message('error', $exc->getMessage());
            log_message('error', $exc->getTraceAsString());

            //Creating security log
            $this->load->library('appunto-auth/appunto_auth');
            $this->appunto_auth->create_security_log(0, "Error creando/actualizando tabla " . $this->_model);
            //End security log

            $this->_jsonResponse(array(
                "msg" => "Ha ocurrido un error mientras se intentaba guardar una boleta."
                    ), 500);
        }
    }

    public function findByEntidad() {
        $entidadid = $this->input->get('entidad', TRUE);
        if ($entidadid) {
            $items = $this->_getTable()->findByEntidad_Id($entidadid);
            $this->_jsonResponse($items);
        }
    }

    public function findByProveedor() {
        $proveedorid = $this->input->get('proveedor', TRUE);
        $mes = $this->input->get('mes', TRUE);
        $year = $this->input->get('year', TRUE);
        if ($proveedorid) {
            $items = $this->_getTable()->findByProveedor_Id($proveedorid, $mes, $year);
            $this->_jsonResponse($items);
        }
    }

    public function findAllByEntidad() {
        $entidadid = $this->input->get('entidad', TRUE);
        if ($entidadid) {
            $items = $this->_getTable()->findAllByEntidadId($entidadid);
            $this->_jsonResponse($items);
        }
    }

    public function consecutivo() {
        $consec = $this->_getTable()->consecutivo();
        $this->_jsonResponse(array("consec" => $consec));
    }

    public function getstore() {
        $boleta_id = $this->input->get('boleta_id', TRUE);
        $item = $this->_getTable()->getStore($boleta_id);
        //Creating security log
        $this->load->library('appunto-auth/appunto_auth');
        $this->appunto_auth->create_security_log(1, "Listando tabla " . $this->_model);
        //End security log
        $this->_jsonResponse($item);
    }

}
