Ext.define('FV.store.sSubordinacion', {
    extend: 'Ext.data.Store',
    model: "FV.model.mSubordinacion",
    autoSync: true,
    proxy: {
        type: 'ajax',
        url:SITEURL+"/subordinacion",
        api: {
            create: SITEURL + "/subordinacion/save",
            update: SITEURL + "/subordinacion/save",
            destroy: SITEURL + "/subordinacion/remove"
        },
        reader: {
            type: 'json',
            root: 'data'
        }
    }
});


