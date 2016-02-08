<?php

/**
 * BaseEventos
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property integer $id
 * @property integer $entidad_id
 * @property integer $producto_id
 * @property string $concepto
 * @property float $cant
 * @property integer $ajuste
 * @property date $fecha
 * @property NomEntidad $Entidad
 * @property NomProducto $Producto
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 7490 2010-03-29 19:53:27Z jwage $
 */
abstract class BaseEventos extends Doctrine_Record
{
    public function setTableDefinition()
    {
        $this->setTableName('eventos');
        $this->hasColumn('id', 'integer', 8, array(
             'type' => 'integer',
             'primary' => true,
             'autoincrement' => true,
             'length' => '8',
             ));
        $this->hasColumn('entidad_id', 'integer', 4, array(
             'type' => 'integer',
             'notnull' => true,
             'length' => '4',
             ));
        $this->hasColumn('producto_id', 'integer', 4, array(
             'type' => 'integer',
             'notnull' => true,
             'length' => '4',
             ));
        $this->hasColumn('concepto', 'string', 255, array(
             'type' => 'string',
             'notnull' => true,
             'length' => '255',
             ));
        $this->hasColumn('cant', 'float', null, array(
             'type' => 'float',
             'notnull' => true,
             'length' => '',
             ));
        $this->hasColumn('ajuste', 'integer', 4, array(
             'type' => 'integer',
             'notnull' => true,
             'length' => '4',
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
        $this->hasOne('NomEntidad as Entidad', array(
             'local' => 'entidad_id',
             'foreign' => 'id'));

        $this->hasOne('NomProducto as Producto', array(
             'local' => 'producto_id',
             'foreign' => 'id'));
    }
}