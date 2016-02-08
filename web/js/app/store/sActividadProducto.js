Ext.define('FV.store.sActividadProducto', {
    extend: 'Ext.data.Store',
    model: "FV.model.mActividadProducto",
    autoSync: true,
    groupField: 'producto_nombre',
    proxy: {
        type: 'ajax',
        url: SITEURL + "/c_actividadproducto",
        api: {
            create: SITEURL + "/c_actividadproducto/save",
            update: SITEURL + "/c_actividadproducto/save",
            destroy: SITEURL + "/c_actividadproducto/remove"
        },
        reader: {
            type: 'json',
            root: 'data'
        }
    }
});


