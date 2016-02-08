Ext.define('FV.store.sInventario', {
    extend: 'Ext.data.Store',
    model: "FV.model.mInventario",
    autoSync: true,
    groupField: 'entidad_nombre',
    proxy: {
        type: 'ajax',
        url:SITEURL+"/inventarioc",
        api: {
            create: SITEURL + "/inventarioc/save",
            update: SITEURL + "/inventarioc/save",
            destroy: SITEURL + "/inventarioc/remove"
        },
        reader: {
            type: 'json',
            root: 'data'
        }
    }
});


