<?php

/**
 * BaseNomActividad
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property integer $id
 * @property string $nombre
 * @property  $relations
 * @property Doctrine_Collection $ActividadProducto
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 7490 2010-03-29 19:53:27Z jwage $
 */
abstract class BaseNomActividad extends Doctrine_Record
{
    public function setTableDefinition()
    {
        $this->setTableName('nom_actividad');
        $this->hasColumn('id', 'integer', 4, array(
             'type' => 'integer',
             'primary' => true,
             'autoincrement' => true,
             'length' => '4',
             ));
        $this->hasColumn('nombre', 'string', 255, array(
             'type' => 'string',
             'notnull' => true,
             'unique' => true,
             'length' => '255',
             ));
       
    }

    public function setUp()
    {
        parent::setUp();
        $this->hasMany('ActividadProducto', array(
             'local' => 'id',
             'foreign' => 'actividad_id'));
    }
}