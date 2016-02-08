<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class c_Database extends MY_Controller {

    protected $_model = "BaseDatos";

    /**
     * Lista de items.
     */
    public function index() {
        $items = $this->_getTable()->all();
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
                $nivelAct = BalanceAlimTable::getInstance()->find($post['balance_alim_id']);
                if (!$nivelAct) {
                    $msg = "Balance no encontrado.";
                    return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                }
                if ($post['id']) {
                    $databaseModel = $this->_getTable()->find($post['id']);
                    if (!$databaseModel) {
                        $msg = "BD no encontrado.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else {
                    $databaseModel = new BaseDatos();
                }

                $databaseModel->fromArray($post, false);
                $databaseModel->set('Producto', $producto);
                $databaseModel->set('BalanceAlim', $nivelAct);
                $databaseModel->save();

                $this->_jsonResponse($databaseModel->toArray());
            }
        } catch (Exception $exc) {
            log_message('error', $exc->getMessage());
            log_message('error', $exc->getTraceAsString());
            $this->_jsonResponse(array(
                "msg" => "Ha ocurrido un error mientras se intentaba guardar BD"
                    ), 500);
        }
    }

    public function getstore() {
        $balance_alim_id = $this->input->get('balance_alim_id', TRUE);
        $item = $this->_getTable()->getStore($balance_alim_id);

        //Creating security log
        $this->load->library('appunto-auth/appunto_auth');
        $this->appunto_auth->create_security_log(1, "Listando tabla " . $this->_model);
        //End security log

        $this->_jsonResponse($item);
    }

}
