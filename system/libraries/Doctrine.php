<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed'); 
/*
 *
 * This class sets Doctrine 1.2.x up for CodeIgniter 1.x and 2.x
 * It's a library
 *
 * @package     Doctrine-1 for CodeIgniter
 * @author      Rayneris Sánchez Capote
 * @link        www.facebook.com/raynosc
 */
 
require_once 'Doctrine/Core.php';
require_once 'spyc.php';
class Doctrine extends Doctrine_Core
{
	public function __construct($load = true)
	{	
		if ($load) {
            $baseDir = dirname(__FILE__).'/../../'. APPPATH;
			$data = Spyc::YAMLLoad(realpath($baseDir.'config/database.yml'));
			$db['default'] = $data['db']['default'];				
			$db['default']['cachedir'] = ""; 
			$db['default']['dsn'] = 
				$db['default']['dbdriver'] . 
				'://' . $db['default']['username'] . 
				':' . $db['default']['password']. 
				'@' . $db['default']['hostname'] . 
				'/' . $db['default']['database'];

			// Set the autoloader
			spl_autoload_register(array('Doctrine', 'autoload'));
			
			// Load the Doctrine connection
			Doctrine_Manager::connection($db['default']['dsn'], $db['default']['database']);
			Doctrine_Manager::connection()->setCharset($db['default']['char_set']);
			// Load the models for the autoloader
			Doctrine::loadModels(realpath($baseDir) . '/models/generated');
			Doctrine::loadModels(realpath($baseDir) . '/models');  
            
		} 
	}
	
	public function changeDBConfig($config = 'default',$dirYml = null){
		$load = $dirYml;
		if ($dirYml == null){
			$load = realpath(dirname(__FILE__) . 'config/database.yml');
		} 				
		$data = Spyc::YAMLLoad($load);
		$db[$config] = $data['db']['default'];				
		$db[$config]['cachedir'] = ""; 
		$db[$config]['dsn'] = 
			$db[$config]['dbdriver'] . 
          	'://' . $db[$config]['username'] . 
            ':' . $db[$config]['password']. 
            '@' . $db[$config]['hostname'] . 
            '/' . $db[$config]['database'];

		// Set the autoloader
		spl_autoload_register(array('Doctrine', 'autoload'));
		
		// Load the Doctrine connection
		Doctrine_Manager::connection($db[$config]['dsn'],$db[$config]['database']);
		//Doctrine_Manager::connection()->setCharset($db[$config]['char_set']);
		// Load the models for the autoloader
		Doctrine::loadModels(APPPATH . '/models/generated');  
		Doctrine::loadModels(APPPATH . '/models');
	}
	
	public function setUpCommandLine()
	{
		$config = array('
				 data_fixtures_path'  =>  dirname(dirname(__FILE__)) . '/fixtures',
                'models_path'         =>  dirname(dirname(__FILE__)) . '/models',
                'migrations_path'     =>  dirname(dirname(__FILE__)) . '/migrations',
                'sql_path'            =>  dirname(dirname(__FILE__)) . '/sql',
                'yaml_schema_path'    =>  dirname(dirname(__FILE__)) . '/schema');

		$cli = new Doctrine_Cli($config);
		$cli->run($_SERVER['argv']);             
	}
	public function commandLine()
	{		
		$config = array('
				 data_fixtures_path'  =>  APPPATH . '/fixtures',
                'models_path'         =>  APPPATH . '/models',
                'migrations_path'     =>  APPPATH . '/migrations',
                'sql_path'            =>  APPPATH . '/sql',
                'yaml_schema_path'    =>  APPPATH . '/schema');

		$cli = new Doctrine_Cli($config);
		$cli->run($_SERVER['argv']);             
	}
}

/* End of file DoctrineSetup.php */