Ext.define('FV.store.sUm', {
    extend: 'Ext.data.Store',
    model: "FV.model.mUm",
    autoSync: true,
    pageSize: 20,
    proxy: {
        type: 'ajax',
        url: SITEURL + "/um",
        api: {
            create: SITEURL + "/um/save",
            update: SITEURL + "/um/save",
            destroy: SITEURL + "/um/remove"
        },
        reader: {
            type: 'json',
            root: 'data',
            totalProperty: 'totalCount'
        }
    }
});


