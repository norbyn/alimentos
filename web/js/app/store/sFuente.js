Ext.define('FV.store.sFuente', {
    extend: 'Ext.data.Store',
    model: "FV.model.mFuente",
    autoSync: true,
    pageSize: 20,
    proxy: {
        type: 'ajax',
        url: SITEURL + "/fuente",
        api: {
            create: SITEURL + "/fuente/save",
            update: SITEURL + "/fuente/save",
            destroy: SITEURL + "/fuente/remove"
        },
        reader: {
            type: 'json',
            root: 'data',
            totalProperty: 'totalCount'
        }
    }
});


