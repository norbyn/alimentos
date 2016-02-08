/** 
 * Paths Store
 *
 *
 * A grouping store that uses the {@link AppuntoAuth.model.Path} model and contains 
 * valid CodeIgniter paths defined by controller/function.
 *
 * @cfg {int} [pageSize=9999] Setting pageSize high since this store does not page. 
 * @cfg {boolean} [remoteSort=false] This store uses local sorting.
 * @cfg {boolean} [remoteFilter=false] This store uses local filtering.
 * @cfg {String} [groupField="ci_controller"] Sort by the "controller" field by default.
 * @cfg {boolean} [autoLoad=false] Do not automatically load this store.
 */
Ext.require('Ext.data.Store');
Ext.require('AppuntoAuth.model.Path');

Ext.define('AppuntoAuth.store.Paths', {
    extend: 'Ext.data.Store',
    model : 'AppuntoAuth.model.Path',
    pageSize : 9999,
    remoteSort: false,
    remoteFilter: false,
	groupField: 'ci_controller',
    autoLoad: false
});
