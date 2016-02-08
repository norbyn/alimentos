<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * @property CI_Input $input Request Class
 * @property CI_Output $output Request Class
 * @property CI_Security $security Security Class
 * 
 * Description of MY_Controller
 *
 * @author Kstro<ellocosoyyo@gmail.com>
 */
class MY_Controller extends CI_Controller {

    protected $_model = null;
    private $_modelTable = null;

    /**
     * Lista de items.
     */
    public function index() {
        $items = $this->_getTable()->findAll(Doctrine::HYDRATE_ARRAY);
        $this->_jsonResponse2(count($items), $items);
    }

    protected function _getTable() {
        if (!$this->_modelTable) {
            $modelTable = $this->_model . "Table";
            $this->_modelTable = $modelTable::getInstance();
        }
        return $this->_modelTable;
    }

    /**
     * Nueva respuesta en formato JSON
     * 
     * @param array $content el contenido de la respuesta, debe ser un arreglo
     * @param int $code El Codigo http. Ejemplo: 404,500
     * @param string $msg El mensaje dependiendo del code
     */
    protected function _jsonResponse(array $content = array(), $code = 200, $msg = '') {
        $this->output
                ->set_content_type('application/json')
                ->set_status_header($code, $msg)
                ->set_output(json_encode(array("success" => $code === 200, "totalCount" => 4, "data" => $content)));
    }

    protected function _jsonResponse2($total, array $content = array(), $code = 200, $msg = '') {
        $this->output
                ->set_content_type('application/json')
                ->set_status_header($code, $msg)
                ->set_output(json_encode(array("success" => $code === 200, "totalCount" => $total, "data" => $content)));
    }

    /**
     * Devuelve un item o todos del POST
     * 
     * @param string $index
     * @param bool $xss_clean
     * @return array|string|false
     */
    protected function _post($index = NULL, $xss_clean = FALSE) {
        $post = $this->input->post($index, $xss_clean);
        if (!$post) {
            $post = json_decode(file_get_contents('php://input'), true);
            if (is_null($index)) {
                return $post;
            }
            if (array_key_exists($index, $post)) {
                if ($xss_clean === TRUE) {
                    return $this->security->xss_clean($post[$index]);
                }
                return $post[$index];
            }
        }
        return $post;
    }

    public function remove() {
        $post = $this->_post(NULL, TRUE);
        if ($post['id']) {
            $come = $this->_getTable()->find($post['id']);
            if (!$come) {
                //Creating security log
                $this->load->library('appunto-auth/appunto_auth');
                $this->appunto_auth->create_security_log(0, "Tabla " . $this->_model . ", Error eliminando fila.");
                //End security log
                return $this->_jsonResponse($post);
            }
            $come->delete();
            //Creating security log
            $this->load->library('appunto-auth/appunto_auth');
            $this->appunto_auth->create_security_log(1, "Tabla " . $this->_model . ", Fila eliminada [id:" . $post['id'] . "]");
            //End security log
        }
        $this->_jsonResponse($post);
    }

}

?>
