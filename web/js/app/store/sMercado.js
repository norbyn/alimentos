Ext.define('FV.store.sMercado', {
    extend: 'Ext.data.Store',
    model: "FV.model.mMercado",
    autoSync: true,
    pageSize: 20,
    proxy: {
        type: 'ajax',
        url: SITEURL + "/mercado",
        api: {
            create: SITEURL + "/mercado/save",
            update: SITEURL + "/mercado/save",
            destroy: SITEURL + "/mercado/remove"
        },
        reader: {
            type: 'json',
            root: 'data',
            totalProperty: 'totalCount'
        }
    }
});


