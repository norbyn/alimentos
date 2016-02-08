<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Subordinacion extends MY_Controller
{

    protected $_model = "NomSubordinacion";

    public function save()
    {
        $post = $this->_post(NULL, TRUE);
        try
        {
            if (is_array($post))
            {
                if ($post['id'])
                {
                    $sub = $this->_getTable()->find($post['id']);
                    if (!$sub)
                    {
                        $msg = "Subordinación no encontrada.";
                        return $this->_jsonResponse(array("msg" => $msg), 404, $msg);
                    }
                } else
                {
                    $sub = new NomSubordinacion();
                }
                $sub->fromArray($post, false);
                $sub->save();

                $this->_jsonResponse($sub->toArray());
            }
        } catch (Exception $exc)
        {
            log_message('error', $exc->getMessage());
            log_message('error', $exc->getTraceAsString());
            $this->_jsonResponse(array(
                "msg" => "Ha ocurrido un error mientras se intentaba guardar una subordinación."
                    ), 500);
        }
    }

}
