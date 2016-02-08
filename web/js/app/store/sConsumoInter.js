Ext.define('FV.store.sConsumoInter', {
    extend: 'Ext.data.Store',
    model: "FV.model.mConsumoInter",
    autoSync: true,
    groupField: 'entidad_nombre',
    proxy: {
        type: 'ajax',
        url: SITEURL + "/c_consumointer",
        api: {
            create: SITEURL + "/c_consumointer/save",
            update: SITEURL + "/c_consumointer/save",
            destroy: SITEURL + "/c_consumointer/remove"
        },
        reader: {
            type: 'json',
            root: 'data'
        }
    }
});


