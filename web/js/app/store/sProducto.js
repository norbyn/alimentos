Ext.define('FV.store.sProducto', {
    extend: 'Ext.data.Store',
    model: "FV.model.mProducto",
    autoSync: true,
    //groupField: 'proveedor_nombre',
    //autoLoad: true,
    pageSize: 20,
    proxy: {
        type: 'ajax',
        url: SITEURL + "/producto",
        api: {
            create: SITEURL + "/producto/save",
            update: SITEURL + "/producto/save",
            destroy: SITEURL + "/producto/remove"
        },
        reader: {
            type: 'json',
            root: 'data',
            totalProperty: 'totalCount'
        }
    }
});


