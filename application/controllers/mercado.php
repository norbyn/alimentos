<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Mercado extends MY_Controller {

    protected $_model = "NomMercado";

    public function save() {
        $post = $this->_post(NULL, TRUE);
        try {
            if (is_array($post)) {
                if ($post['id']) {
                    $fte = $this->_getTable()->find($post['id']);
                    if (!$fte) {
                        $msg = "Mercado no encontrado.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else {
                    $fte = new NomMercado();
                }
                $fte->fromArray($post, false);
                $fte->save();

                $this->_jsonResponse($fte->toArray());
            }
        } catch (Exception $exc) {
            log_message('error', $exc->getMessage());
            log_message('error', $exc->getTraceAsString());
            $this->_jsonResponse(array(
                "msg" => "Ha ocurrido un error mientras se intentaba guardar un registro."
                    ), 500);
        }
    }

}
