<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

/**
 * @method NomEntidadTable _getTable() Nom Entidad Table
 */
class Entidad extends MY_Controller {

    protected $_model = "NomEntidad";

    /**
     * Lista de items.
     */
    public function index() {
        $start = $this->input->get('start', TRUE);
        $limit = $this->input->get('limit', TRUE);
        $items = $this->_getTable()->findAllWithOrganismo($start, $limit);

        $this->_jsonResponse2(count($this->_getTable()->findAll()), $items);
    }

    public function findbyorganismo() {
        $organismo = $this->input->get('organismo', TRUE);
        if ($organismo) {
            $items = $this->_getTable()->findBy("organismo_id", $organismo, Doctrine::HYDRATE_ARRAY);

            $this->_jsonResponse($items);
        }
    }

    public function save() {
        $post = $this->_post(NULL, TRUE);
        try {
            if (is_array($post)) {
                /* @var $org NomOrganismo */
                $org = NomOrganismoTable::getInstance()->find($post['organismo_id']);
                if (!$org) {
                    $msg = "Organismo no encontrado.";
                    return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                }
                if ($post['id']) {
                    $ent = $this->_getTable()->find($post['id']);
                    if (!$ent) {
                        $msg = "Entidad no encontrada.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else {
                    $ent = new NomEntidad();
                }
                $ent->fromArray($post, false);
                $ent->set('Organismo', $org);
                $ent->save();

                $this->_jsonResponse($ent->toArray());
            }
        } catch (Exception $exc) {
            log_message('error', $exc->getMessage());
            log_message('error', $exc->getTraceAsString());
            $this->_jsonResponse(array(
                "msg" => "Ha ocurrido un error mientras se intentaba guardar una entidad."
                    ), 500);
        }
    }

}
