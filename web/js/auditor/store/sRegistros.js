Ext.define('FV.store.sRegistros', {
    extend: 'Ext.data.Store',
    model: "FV.model.mRegistro",
    //autoLoad: true,
    pageSize: 20,
    proxy: {
        type: 'ajax',
        url: SITEURL + "/registros_del_sistema",
        reader: {
            type: 'json',
            root: 'data',
            totalProperty: 'totalCount'
        }
    }
});


