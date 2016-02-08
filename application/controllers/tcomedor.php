<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Tcomedor extends MY_Controller {

    protected $_model = "NomComedor";

    public function save() {
        $post = $this->_post(NULL, TRUE);
        try {
            if (is_array($post)) {
                if ($post['id']) {
                    $come = $this->_getTable()->find($post['id']);
                    if (!$come) {
                        $msg = "Comedor no encontrado.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else {
                    $come = new NomComedor();
                }
                $come->fromArray($post, false);
                $come->save();

                $this->_jsonResponse($come->toArray());
            }
        } catch (Exception $exc) {
            log_message('error', $exc->getMessage());
            log_message('error', $exc->getTraceAsString());
            $this->_jsonResponse(array(
                "msg" => "Ha ocurrido un error mientras se intentaba guardar un comedor."
                    ), 500);
        }
    }

    /**
     * Lista de items.
     */
    public function notin() {
        $id = $this->input->get('entidad', TRUE);
        $items = Doctrine_Query::create()->addSelect('*')->from('NomComedor')
                ->where('id not in (select nombre_comedor_id from Comedor where entidad_id = ?)', $id)
                ->fetchArray();
        $this->_jsonResponse($items);
    }

}
