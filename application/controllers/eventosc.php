<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

/**
 * @method EventosTable _getTable() Eventos Table
 */
class EventosC extends MY_Controller {

    protected $_model = "Eventos";

    /**
     * Lista de items.
     */
    public function index() {
        $mes = $this->input->get('mes', TRUE);
        $year = $this->input->get('year', TRUE);
        $items = $this->_getTable()->findAllWithEntidadProducto($mes, $year);
        $this->_jsonResponse($items);
    }

    public function save() {
        $post = $this->_post(NULL, TRUE);
        try {
            if (is_array($post)) {
                $entidad = NomEntidadTable::getInstance()->find($post['entidad_id']);
                if (!$entidad) {//Si la entidad no existe devuelvo un error
                    $msg = "Entidad no encontrada.";
                    return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                }
                $prod = NomProductoTable::getInstance()->find($post['producto_id']);
                if (!$prod) {//Si el producto no existe devuelvo un error
                    $msg = "Producto no encontrado.";
                    return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                }
                if ($post['id']) {
                    $evento = $this->_getTable()->find($post['id']);
                    if (!$evento) {//Si el evento no existe devuelvo un error
                        $msg = "Evento no encontrado.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else {
                    $evento = new Eventos();
                }
                $evento->fromArray($post, false);
                $evento->set('Entidad', $entidad);
                $evento->set('Producto', $prod);
                $evento->save();

                $this->_jsonResponse($evento->toArray());
            }
        } catch (Exception $exc) {
            log_message('error', $exc->getMessage());
            log_message('error', $exc->getTraceAsString());
            $this->_jsonResponse(array(
                "msg" => "Ha ocurrido un error mientras se intentaba guardar un producto."
                    ), 500);
        }
    }

}
