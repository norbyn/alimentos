<?php

/**
 * BaseProductoFuentes
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property integer $id
 * @property integer $producto_id
 * @property integer $fuentes_id
 * @property float $cant
 * @property date $fecha
 * @property NomProducto $Producto
 * @property NomFuentes $Fuente
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 7490 2010-03-29 19:53:27Z jwage $
 */
abstract class BaseProductoFuentes extends Doctrine_Record
{
    public function setTableDefinition()
    {
        $this->setTableName('producto_fuentes');
        $this->hasColumn('id', 'integer', 8, array(
             'type' => 'integer',
             'primary' => true,
             'autoincrement' => true,
             'length' => '8',
             ));
        $this->hasColumn('producto_id', 'integer', 4, array(
             'type' => 'integer',
             'notnull' => true,
             'length' => '4',
             ));
        $this->hasColumn('fuentes_id', 'integer', 4, array(
             'type' => 'integer',
             'notnull' => true,
             'length' => '4',
             ));
        $this->hasColumn('cant', 'float', null, array(
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

        $this->hasOne('NomFuentes as Fuente', array(
             'local' => 'fuentes_id',
             'foreign' => 'id'));
    }
}