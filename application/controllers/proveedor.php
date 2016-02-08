<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Proveedor extends MY_Controller {

    protected $_model = "NomProveedor";

    public function index() {
        $start = $this->input->get('start', TRUE);
        $limit = $this->input->get('limit', TRUE);
        $items = $this->_getTable()->proveedores($start, $limit);

        $this->_jsonResponse2(count($this->_getTable()->findAll()), $items);
    }

    public function save() {
        $post = $this->_post(NULL, TRUE);
        try {
            if (is_array($post)) {
                if ($post['id']) {
                    $prove = $this->_getTable()->find($post['id']);
                    if (!$prove) {
                        $msg = "Proveedor no encontrada.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else {
                    $prove = new NomProveedor();
                }
                $prove->fromArray($post, false);
                $prove->save();

                $this->_jsonResponse($prove->toArray());
            }
        } catch (Exception $exc) {
            log_message('error', $exc->getMessage());
            log_message('error', $exc->getTraceAsString());
            $this->_jsonResponse(array(
                "msg" => "Ha ocurrido un error mientras se intentaba guardar un proveedor."
                    ), 500);
        }
    }

}
