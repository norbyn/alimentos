<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class c_Balance_mes extends MY_Controller {

    protected $_model = "BalanceMes";

    /**
     * Lista de items.
     */
    /*public function index() {
        $items = $this->_getTable()->all();
        $this->_jsonResponse($items);
    }*/

    public function save() {
        $post = $this->_post(NULL, TRUE);
        try {
            if (is_array($post)) {
               $nivelAct = BalanceAlimTable::getInstance()->find($post['balance_id']);
                if (!$nivelAct) {
                    $msg = "Balance no encontrado.";
                    return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                }
                if ($post['id']) {
                    $balance_mmes = $this->_getTable()->find($post['id']);
                    if (!$balance_mmes) {
                        $msg = "BD no encontrado.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else {
                    $balance_mmes = new BalanceMes();
                }

                $balance_mmes->fromArray($post, false);
                $balance_mmes->set('BalanceAlim', $nivelAct);
                $balance_mmes->save();

                $this->_jsonResponse($balance_mmes->toArray());
            }
        } catch (Exception $exc) {
            log_message('error', $exc->getMessage());
            log_message('error', $exc->getTraceAsString());
            $this->_jsonResponse(array(
                "msg" => "Ha ocurrido un error mientras se intentaba guardar..."
                    ), 500);
        }
    }

    public function getstore() {
        $balance_alim_id = $this->input->get('balance_id', TRUE);
        $mes = $this->input->get('mes', TRUE);
        $year = $this->input->get('year', TRUE);
        $item = $this->_getTable()->getStore($balance_alim_id, $mes, $year);

        //Creating security log
        $this->load->library('appunto-auth/appunto_auth');
        $this->appunto_auth->create_security_log(1, "Listando tabla " . $this->_model);
        //End security log

        $this->_jsonResponse($item);
    }

}
