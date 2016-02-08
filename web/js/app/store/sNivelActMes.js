Ext.define('FV.store.sNivelActMes', {
    extend: 'Ext.data.Store',
    model: "FV.model.mNivelActMes",
    autoSync: true,
    autoLoad: false,
    proxy: {
        type: 'ajax',
        url: SITEURL + "/c_balance_mes",
        api: {
            create: SITEURL + "/c_balance_mes/save",
            update: SITEURL + "/c_balance_mes/save",
            destroy: SITEURL + "/c_balance_mes/remove"
        },
        reader: {
            type: 'json',
            root: 'data'
        }
    }
});


