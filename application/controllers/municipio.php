<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Municipio extends MY_Controller {

    protected $_model = "NomMunicipio";

    public function index() {
        $provincia = $this->input->get('provincia', TRUE);
        if ($provincia) {
            $items = NomMunicipioTable::getInstance()->findBy("provincia_id", $provincia, Doctrine::HYDRATE_ARRAY);

            $this->output
                    ->set_content_type('application/json')
                    ->set_output(json_encode(array("success" => true, "data" => $items)));
        }
    }

    public function save() {
        $post = $this->_post(NULL, TRUE);
        try {
            if (is_array($post)) {
                $provincia = NomMunicipioTable::getInstance()->find($post['provincia_id']);
                if (!$provincia) {//Si la entidad no existe devuelvo un error
                    $msg = "Provincia no encontrada.";
                    return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                }
                if ($post['id']) {
                    $municipio = NomMunicipioTable::getInstance()->find($post['id']);
                    if (!$municipio) {
                        $msg = "Municipio no encontrado.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else {
                    $municipio = new NomMunicipio();
                }

                $municipio->fromArray($post, false);
                $municipio->save();

                $this->_jsonResponse($municipio->toArray());
            }
        } catch (Exception $exc) {
            log_message('error', $exc->getMessage());
            log_message('error', $exc->getTraceAsString());
            $this->_jsonResponse(array(
                "msg" => "Ha ocurrido un error mientras se intentaba guardar un municipio."
                    ), 500);
        }
    }

}
