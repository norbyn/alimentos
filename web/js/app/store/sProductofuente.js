Ext.define('FV.store.sProductofuente', {
    extend: 'Ext.data.Store',
    model: "FV.model.mProductofuente",
    autoSync: true,
    pageSize: 20,
    proxy: {
        type: 'ajax',
        url: SITEURL + "/productofuente",
        api: {
            create: SITEURL + "/productofuente/save",
            update: SITEURL + "/productofuente/save",
            destroy: SITEURL + "/productofuente/remove"
        },
        reader: {
            type: 'json',
            root: 'data',
            totalProperty: 'totalCount'
        }
    }
});


