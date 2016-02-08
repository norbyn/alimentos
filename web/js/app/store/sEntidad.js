Ext.define('FV.store.sEntidad', {
    extend: 'Ext.data.Store',
    model: "FV.model.mEntidad",
    autoSync: true,
    autoLoad: true,
    pageSize: 100,
    proxy: {
        type: 'ajax',
        url: SITEURL + "/entidad",
        api: {
            create: SITEURL + "/entidad/save",
            update: SITEURL + "/entidad/save",
            destroy: SITEURL + "/entidad/remove"
        },
        reader: {
            type: 'json',
            root: 'data',
            totalProperty: 'totalCount'
        }
    }
});





