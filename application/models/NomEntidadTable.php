<?php

/**
 * NomOrganismo
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @package    ##PACKAGE##
 * @subpackage ##SUBPACKAGE##
 * @author     ##NAME## <##EMAIL##>
 * @version    SVN: $Id: Builder.php 7490 2010-03-29 19:53:27Z jwage $
 */
class NomEntidadTable extends Doctrine_Table {

    /**
     * Returns an instance of this class.
     *
     * @return NomOrganismoTable
     */
    public static function getInstance() {
        return Doctrine_Core::getTable('NomEntidad');
    }

    public function findAllWithOrganismo($start, $limit) {
        return $this->createQuery('entidad')
                        ->innerJoin('entidad.Organismo org')
                        ->orderBy('entidad.id ' . " LIMIT " . $start . ", " . $limit)
                        ->setHydrationMode(Doctrine::HYDRATE_ARRAY)->execute();
    }

}