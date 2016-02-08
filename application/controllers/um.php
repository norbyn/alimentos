<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Um extends MY_Controller
{

    protected $_model = "NomUm";
    
    public function save()
    {
        $post = $this->_post(NULL, TRUE);
        try
        {
            if (is_array($post))
            {
                if ($post['id'])
                {
                    $um = $this->_getTable()->find($post['id']);
                    if (!$um)
                    {
                        $msg = "Unidad de Medida no encontrada.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else
                {
                    $um = new NomUm();
                }
                $um->fromArray($post, false);
                $um->save();

                $this->_jsonResponse($um->toArray());
            }
        } catch (Exception $exc)
        {
            log_message('error', $exc->getMessage());
            log_message('error', $exc->getTraceAsString());
            $this->_jsonResponse(array(
                "msg" => "Ha ocurrido un error mientras se intentaba guardar una unidad de medida.",
                    ), 500);
        }
    }

}
