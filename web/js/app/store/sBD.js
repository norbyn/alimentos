Ext.define('FV.store.sBD', {
    extend: 'Ext.data.Store',
    model: "FV.model.mBD",
    autoSync: true,
    autoLoad: false,
    proxy: {
        type: 'ajax',
        url: SITEURL + "/c_database",
        api: {
            create: SITEURL + "/c_database/save",
            update: SITEURL + "/c_database/save",
            destroy: SITEURL + "/c_database/remove"
        },
        reader: {
            type: 'json',
            root: 'data'
        }
    }
});


