//Store de Actividad
Ext.define('FV.store.sActividad', {
    extend: 'Ext.data.Store',
    model: "FV.model.mActividad",
    autoSync: true,
    proxy: {
        type: 'ajax',
        url: SITEURL + "/c_actividad",
        api: {
            create: SITEURL + "/c_actividad/save",
            update: SITEURL + "/c_actividad/save",
            destroy: SITEURL + "/c_actividad/remove"
        },
        reader: {
            type: 'json',
            root: 'data'
        }
    }
});


