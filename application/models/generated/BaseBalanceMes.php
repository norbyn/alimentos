<?php
/**
 * BaseBalanceMes
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property integer $id
 * @property integer $balance_id
 * @property float $real
 * @property BalanceAlim $BalanceAlim
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 7490 2010-03-29 19:53:27Z jwage $
 */
abstract class BaseBalanceMes extends Doctrine_Record {

    public function setTableDefinition() {
        $this->setTableName('balance_mes');
        $this->hasColumn('id', 'integer', 8, array(
            'type' => 'integer',
            'primary' => true,
            'autoincrement' => true,
            'length' => '8',
        ));
        $this->hasColumn('balance_id', 'integer', 8, array(
            'type' => 'integer',
            'notnull' => true,
            'length' => '8',
        ));
        $this->hasColumn('real_mes', 'float', null, array(
            'type' => 'float',
            'notnull' => true,
            'length' => '',
        ));
    }

    public function setUp() {
        parent::setUp();
        $this->hasOne('BalanceAlim', array(
             'local' => 'balance_id',
             'foreign' => 'id'));
        $timestampable0 = new Doctrine_Template_Timestampable();
        $this->actAs($timestampable0);
    }

}
