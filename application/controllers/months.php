<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Months extends MY_Controller {

    public function index() {
        $items = array(
            array("name" => "Enero", "num" => '01'),
            array("name" => "Febrero", "num" => '02'),
            array("name" => "Marzo", "num" => '03'),
            array("name" => "Abril", "num" => '04'),
            array("name" => "Mayo", "num" => '05'),
            array("name" => "Junio", "num" => '06'),
            array("name" => "Julio", "num" => '07'),
            array("name" => "Agosto", "num" => '08'),
            array("name" => "Septiembre", "num" => '09'),
            array("name" => "Octubre", "num" => '10'),
            array("name" => "Noviembre", "num" => '11'),
            array("name" => "Diciembre", "num" => '12'),
        );
        $this->_jsonResponse($items);
    }

}
