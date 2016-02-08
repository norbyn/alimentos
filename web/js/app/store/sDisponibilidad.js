Ext.define('FV.store.sDisponibilidad', {
    extend: 'Ext.data.Store',
    model: "FV.model.mDisponibilidad",
    autoSync: true,
    groupField: 'proveedor_nombre',
    proxy: {
        type: 'ajax',
        url: SITEURL + "/c_disponibilidad",
        api: {
            create: SITEURL + "/c_disponibilidad/save",
            update: SITEURL + "/c_disponibilidad/save",
            destroy: SITEURL + "/c_disponibilidad/remove"
        },
        reader: {
            type: 'json',
            root: 'data'
        }
    }
});


