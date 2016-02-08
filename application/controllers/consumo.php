<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

/**
 * @method ConsumoInterTable _getTable() 
 */
class Consumo extends MY_Controller {

    protected $_model = "ConsumoInter";

    /**
     * Lista de items.
     */
    public function index() {
        $items = $this->_getTable()->findAll();
        $this->_jsonResponse($items);
    }

}
