<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Registros_del_sistema extends MY_Controller {

    protected $_model = "AppaUserLoginAttempt";

    public function index() {
        $start = $this->input->get('start', TRUE);
        $limit = $this->input->get('limit', TRUE);
        $items = $this->_getTable()->registros($start, $limit);

        $this->_jsonResponse2(count($this->_getTable()->findAll()), $items);
    }

}
