Ext.define('FV.store.Organismos', {
    extend: 'Ext.data.Store',
    model: "FV.model.Organismo",
    autoSync: true,
    pageSize: 100,
    proxy: {
        type: 'ajax',
        url: SITEURL + "/organismo",
        api: {
            create: SITEURL + "/organismo/save",
            update: SITEURL + "/organismo/save",
            destroy: SITEURL + "/organismo/remove"
        },
        reader: {
            type: 'json',
            root: 'data',
            totalProperty: 'totalCount'
        }
    }
});


