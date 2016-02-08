Ext.define('FV.store.sProductomercado', {
    extend: 'Ext.data.Store',
    model: "FV.model.mProductomercado",
    autoSync: true,
    pageSize: 20,
    proxy: {
        type: 'ajax',
        url: SITEURL + "/producto_mercado",
        api: {
            create: SITEURL + "/producto_mercado/save",
            update: SITEURL + "/producto_mercado/save",
            destroy: SITEURL + "/producto_mercado/remove"
        },
        reader: {
            type: 'json',
            root: 'data',
            totalProperty: 'totalCount'
        }
    }
});


