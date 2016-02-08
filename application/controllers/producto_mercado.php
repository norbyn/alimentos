<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

/**
 * @method ProductoMercadoTable _getTable() Nom Producto Table
 */
class Producto_mercado extends MY_Controller {

    protected $_model = "ProductoMercado";

    /**
     * Lista de items.
     */
    public function index() {
        $start = $_REQUEST['start'];
        $limit = $_REQUEST['limit'];
        $mes = $this->input->get('mes', TRUE);
        $year = $this->input->get('year', TRUE);
        $items = $this->_getTable()->findAllWithProductoMercado($start, $limit, $mes, $year);
        $this->_jsonResponse2(count($this->_getTable()->findAll()), $items);
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
                $fuente = NomMercadoTable::getInstance()->find($post['mercado_id']);
                if (!$fuente) {//Si la fuente no existe devuelvo un error
                    $msg = "Mercado no encontrado.";
                    return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                }
                if ($post['id']) {
                    $productomercado = $this->_getTable()->find($post['id']);
                    if (!$productomercado) {//Si el producto no existe devuelvo un error
                        $msg = "Producto no encontrado.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else {
                    $productomercado = new ProductoMercado();
                }
                $productomercado->fromArray($post, false);
                $productomercado->set('Producto', $producto);
                $productomercado->set('Mercado', $fuente);
                $productomercado->save();

                $this->_jsonResponse($productomercado->toArray());
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
