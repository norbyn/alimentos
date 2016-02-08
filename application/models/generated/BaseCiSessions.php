<?php

/**
 * BaseCiSessions
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property string $session_id
 * @property string $ip_address
 * @property string $user_agent
 * @property integer $last_activity
 * @property string $user_data
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 7490 2010-03-29 19:53:27Z jwage $
 */
abstract class BaseCiSessions extends Doctrine_Record
{
    public function setTableDefinition()
    {
        $this->setTableName('ci_sessions');
        $this->hasColumn('session_id', 'string', 40, array(
             'type' => 'string',
             'primary' => true,
             'length' => '40',
             ));
        $this->hasColumn('ip_address', 'string', 16, array(
             'type' => 'string',
             'default' => '0',
             'notnull' => true,
             'length' => '16',
             ));
        $this->hasColumn('user_agent', 'string', 120, array(
             'type' => 'string',
             'notnull' => true,
             'length' => '120',
             ));
        $this->hasColumn('last_activity', 'integer', 4, array(
             'type' => 'integer',
             'fixed' => 0,
             'unsigned' => true,
             'default' => '0',
             'notnull' => true,
             'length' => '4',
             ));
        $this->hasColumn('user_data', 'string', null, array(
             'type' => 'string',
             'notnull' => true,
             'length' => '',
             ));
    }

    public function setUp()
    {
        parent::setUp();
        
    }
}