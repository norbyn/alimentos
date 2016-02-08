<?php
if (!defined('BASEPATH'))
    exit('No direct script access allowed');
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of desktop
 * @property CI_Loader $load
 * @property \Doctrine\ORM\EntityManager $em
 * @property CI_Doctrine $doctrine
 * @property CI_
 * @property MY_Form_validation form_validation
 * @author aantelov
 */


class Splash extends CI_Controller {
    public function __construct() {
        parent::__construct();
        $this->load->helper('url');
    }
     public function index() {
     
        $this->load->view('splash/splash');        
        
    }
}

