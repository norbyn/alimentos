<?php

/**
 * BaseNomComedor
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property integer $id
 * @property string $nombre
 * @property Doctrine_Collection $Comedor
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 7490 2010-03-29 19:53:27Z jwage $
 */
abstract class BaseNomComedor extends Doctrine_Record {

    public function setTableDefinition() {
        $this->setTableName('nom_comedor');
        $this->hasColumn('id', 'integer', 4, array(
            'type' => 'integer',
            'primary' => true,
            'autoincrement' => true,
            'length' => '4',
        ));
        $this->hasColumn('nombre', 'string', 100, array(
            'type' => 'string',
            'notnull' => true,
            'unique' => true,
            'length' => '100',
        ));
        $this->hasColumn('is_evento', 'integer', 1, array(
            'type' => 'integer',
            'default' => '0',
            'notnull' => true,
            'length' => '1',
        ));
        $this->hasColumn('periodo', 'float', null, array(
             'type' => 'float',
             'notnull' => true,
             'length' => '',
             ));
    }

    public function setUp() {
        parent::setUp();
        $this->hasMany('Comedor', array(
            'local' => 'id',
            'foreign' => 'nombre_comedor_id'));
    }

}