<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Provincia extends MY_Controller {

    protected $_model = "NomProvincia";

    public function save() {
        $post = $this->_post(NULL, TRUE);
        try {
            if (is_array($post)) {
                if ($post['id']) {
                    $provincia = NomProvinciaTable::getInstance()->find($post['id']);
                    if (!$provincia) {
                        $msg = "Provincia no encontrada.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else {
                    $provincia = new NomProvincia();
                }

                $provincia->fromArray($post, false);
                $provincia->save();

                $this->_jsonResponse($provincia->toArray());
            }
        } catch (Exception $exc) {
            log_message('error', $exc->getMessage());
            log_message('error', $exc->getTraceAsString());
            $this->_jsonResponse(array(
                "msg" => "Ha ocurrido un error mientras se intentaba guardar una provincia."
                    ), 500);
        }
    }

}
