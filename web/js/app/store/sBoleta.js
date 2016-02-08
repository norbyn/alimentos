Ext.define('FV.store.sBoleta', {
    extend: 'Ext.data.Store',
    model: "FV.model.mBoleta",
    autoSync: true,
    proxy: {
        type: 'ajax',
        url: SITEURL + "/c_boleta",
        api: {
            create: SITEURL + "/c_boleta/save",
            update: SITEURL + "/c_boleta/save",
            destroy: SITEURL + "/c_boleta/remove"
        },
        reader: {
            type: 'json',
            root: 'data',
            totalProperty: 'totalCount'
        }
    }
});


