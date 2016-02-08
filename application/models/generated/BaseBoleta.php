<?php

/**
 * BaseBoleta
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property integer $id
 * @property integer $entidad_id
 * @property integer $consec
 * @property date $fecha
 * @property NomEntidad $Entidad
 * @property NomProveedor $Proveedor
 * @property Doctrine_Collection $BoletaProducto
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 7490 2010-03-29 19:53:27Z jwage $
 */
abstract class BaseBoleta extends Doctrine_Record
{
    public function setTableDefinition()
    {
        $this->setTableName('boleta');
        $this->hasColumn('id', 'integer', 4, array(
             'type' => 'integer',
             'primary' => true,
             'autoincrement' => true,
             'length' => '4',
             ));
        $this->hasColumn('entidad_id', 'integer', 4, array(
             'type' => 'integer',
             'notnull' => true,
             'length' => '4',
             ));
        $this->hasColumn('consec', 'integer', 4, array(
             'type' => 'integer',
             'notnull' => true,
             'length' => '4',
             ));
        $this->hasColumn('fecha', 'date', 25, array(
             'type' => 'date',
             'notnull' => true,
             'length' => '25',
             ));
         $this->hasColumn('proveedor_id', 'integer', 4, array(
            'type' => 'integer',
            'notnull' => true,
            'length' => '4',
        ));
    }

    public function setUp()
    {
        parent::setUp();
        $this->hasOne('NomEntidad as Entidad', array(
             'local' => 'entidad_id',
             'foreign' => 'id'));

        $this->hasOne('NomProveedor as Proveedor', array(
             'local' => 'proveedor_id',
             'foreign' => 'id'));

        $this->hasMany('BoletaProducto', array(
             'local' => 'id',
             'foreign' => 'boleta_id'));
    }
}