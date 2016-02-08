<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class c_Actividad extends MY_Controller {

    protected $_model = "NomActividad";

    public function save() {
        $post = $this->_post(NULL, TRUE);
        try {
            if (is_array($post)) {
                if ($post['id']) {
                    $fte = $this->_getTable()->find($post['id']);
                    if (!$fte) {
                        $msg = "Destino no encontrado.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else {
                    $fte = new $this->_model();
                }
                $fte->fromArray($post, false);
                $fte->save();

                $this->_jsonResponse($fte->toArray());
            }
        } catch (Exception $exc) {
            log_message('error', $exc->getMessage());
            log_message('error', $exc->getTraceAsString());
            $this->_jsonResponse(array(
                "msg" => "Ha ocurrido un error mientras se intentaba guardar una fila de la tabla destino."
                    ), 500);
        }
    }

}
