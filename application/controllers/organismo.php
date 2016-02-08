<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

/**
 * @method NomOrganismoTable _getTable() Nom Organismo Table
 */
class Organismo extends MY_Controller {

    protected $_model = "NomOrganismo";

    /**
     * Lista de items.
     */
    public function index() {
        $start = $this->input->get('start', TRUE);
        $limit = $this->input->get('limit', TRUE);
        $items = $this->_getTable()->findAllWithSubordination($start, $limit);
        $this->_jsonResponse2(count($this->_getTable()->findAll()), $items);
    }

    public function save() {
        $post = $this->_post(NULL, TRUE);
        try {
            if (is_array($post)) {
                /* @var $sub NomSubordinacion */
                $sub = NomSubordinacionTable::getInstance()->find($post['subordinacion_id']);
                if (!$sub) {//Si la subordinacion no existe devuelvo un error
                    $msg = "Subordinación no encontrada.";
                    return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                }
                if ($post['id']) {
                    $org = $this->_getTable()->find($post['id']);
                    if (!$org) {//Si el organismo no existe devuelvo un error
                        $msg = "Organismo no encontrado.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else {
                    $org = new NomOrganismo();
                }
                $org->fromArray($post, false);
                $org->set('Subordinacion', $sub);
                $org->save();

                $this->_jsonResponse($org->toArray());
            }
        } catch (Exception $exc) {
            log_message('error', $exc->getMessage());
            log_message('error', $exc->getTraceAsString());
            $this->_jsonResponse(array(
                "msg" => "Ha ocurrido un error mientras se intentaba guardar un organismo."
                    ), 500);
        }
    }

}
