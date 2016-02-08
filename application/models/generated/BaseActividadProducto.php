<?php

/**
 * BaseActividadProducto
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property integer $id
 * @property integer $producto_id
 * @property integer $actividad_id
 * @property float $plan
 * @property float $real
 * @property date $fecha
 * @property NomProducto $Producto
 * @property NomActividad $Actividad
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 7490 2010-03-29 19:53:27Z jwage $
 */
abstract class BaseActividadProducto extends Doctrine_Record
{
    public function setTableDefinition()
    {
        $this->setTableName('actividad_producto');
        $this->hasColumn('id', 'integer', 4, array(
             'type' => 'integer',
             'primary' => true,
             'autoincrement' => true,
             'length' => '4',
             ));
        $this->hasColumn('producto_id', 'integer', 4, array(
             'type' => 'integer',
             'notnull' => true,
             'length' => '4',
             ));
        $this->hasColumn('actividad_id', 'integer', 4, array(
             'type' => 'integer',
             'notnull' => true,
             'length' => '4',
             ));
        $this->hasColumn('plan', 'float', null, array(
             'type' => 'float',
             'notnull' => true,
             'length' => '',
             ));
        $this->hasColumn('actual', 'float', null, array(
             'type' => 'float',
             'notnull' => true,
             'length' => '',
             ));
        $this->hasColumn('fecha', 'date', 25, array(
             'type' => 'date',
             'notnull' => true,
             'length' => '25',
             ));
    }

    public function setUp()
    {
        parent::setUp();
        $this->hasOne('NomProducto as Producto', array(
             'local' => 'producto_id',
             'foreign' => 'id'));

        $this->hasOne('NomActividad as Actividad', array(
             'local' => 'actividad_id',
             'foreign' => 'id'));
    }
}