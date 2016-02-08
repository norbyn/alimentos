<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class c_Boleta extends MY_Controller {

    protected $_model = "Boleta";

    /**
     * Lista de items.
     */
    public function index() {
        $items = $this->_getTable()->findBoleta();
        //Creating security log
        $this->load->library('appunto-auth/appunto_auth');
        $this->appunto_auth->create_security_log(1, "Listando tabla " . $this->_model);
        //End security log
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
                $proveedor = NomProveedorTable::getInstance()->find($post['proveedor_id']);
                if (!$proveedor) {//Si la entidad no existe devuelvo un error
                    $msg = "Proveedor no encontrado.";
                    return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                }
                if ($post['id']) {
                    $boleta = $this->_getTable()->find($post['id']);
                    if (!$boleta) {//Si la boleta no existe devuelvo un error
                        $msg = "Boleta no encontrada.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else {
                    $boleta = new Boleta();
                }

                $boleta->fromArray($post, false);
                $boleta->set('Entidad', $entidad);
                $boleta->set('Proveedor', $proveedor);
                $boleta->save();

                //Creating security log
                $this->load->library('appunto-auth/appunto_auth');
                $this->appunto_auth->create_security_log(1, "Asignando/Actualizando tabla " . $this->_model . "[id:" . $boleta->id . "]");
                //End security log


                $this->_jsonResponse($boleta->toArray());
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

    public function findbyentidad() {
        $entidadid = $this->input->get('entidad', TRUE);
        if ($entidadid) {
            $items = $this->_getTable()->findByEntidad_Id($entidadid);
            $this->_jsonResponse($items);
        }
    }

    public function findbyproveedor() {
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

    public function id() {
        $consec = $this->input->get('consec', TRUE);
        $date = $this->input->get('date', TRUE);
        $item = $this->_getTable()->id($consec, $date);
        $this->_jsonResponse($item);
    }

}
