<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

/**
 * @method InventarioTable _getTable() Inventario Table
 */
class InventarioC extends MY_Controller {

    protected $_model = "Inventario";

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
                $producto = NomProductoTable::getInstance()->find($post['producto_id']);
                if (!$producto) {//Si el producto no existe devuelvo un error
                    $msg = "Producto no encontrado.";
                    return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                }
                $entidad = NomEntidadTable::getInstance()->find($post['entidad_id']);
                if (!$entidad) {//Si la entidad no existe devuelvo un error
                    $msg = "Entidad no encontrada.";
                    return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                }
                if ($post['id']) {
                    $inventario = $this->_getTable()->find($post['id']);
                    if (!$inventario) {//Si el inventario no existe devuelvo un error
                        $msg = "Inventario no encontrado.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else {
                    $inventario = new Inventario();
                }
                $inventario->fromArray($post, false);
                $inventario->set('Producto', $producto);
                $inventario->set('Entidad', $entidad);
                $inventario->save();

                $this->_jsonResponse($inventario->toArray());
            }
        } catch (Exception $exc) {
            log_message('error', $exc->getMessage());
            log_message('error', $exc->getTraceAsString());
            $this->_jsonResponse(array(
                "msg" => "Ha ocurrido un error mientras se intentaba guardar un producto."
                    ), 500);
        }
    }

    public function findbyentidad() {
        $entidad_id = $this->input->get('entidad', TRUE);
        $mes = $this->input->get('mes', TRUE);
        $year = $this->input->get('year', TRUE);
        if ($entidad_id) {
            $items = $this->_getTable()->findByEntidadId($entidad_id, $mes, $year);
            $this->_jsonResponse($items);
        }
    }

}
