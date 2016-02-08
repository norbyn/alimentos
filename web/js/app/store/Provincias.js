Ext.define('FV.store.Provincias', {
    extend: 'Ext.data.Store',
    model: "FV.model.Provincia",
    autoSync: true,
    pageSize: 20,
    proxy: {
        type: 'ajax',
        url: SITEURL + "/provincia",
        api: {
            create: SITEURL + "/provincia/save",
            update: SITEURL + "/provincia/save",
            destroy: SITEURL + "/provincia/remove"
        },
        reader: {
            type: 'json',
            root: 'data',
            totalProperty: 'totalCount'
        }
    }
});