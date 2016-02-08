<?php

/**
 * BaseNomMercado
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property integer $id
 * @property string $nombre
 * @property Doctrine_Collection $ProductoMercado
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 7490 2010-03-29 19:53:27Z jwage $
 */
abstract class BaseNomMercado extends Doctrine_Record {

    public function setTableDefinition() {
        $this->setTableName('nom_mercado');
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
    }

    public function setUp() {
        parent::setUp();
        $this->hasMany('ProductoMercado', array(
            'local' => 'id',
            'foreign' => 'mercado_id'));
    }

}
