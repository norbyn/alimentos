Ext.define('FV.store.sComedor', {
    extend: 'Ext.data.Store',
    model: "FV.model.mComedor",
    autoSync: true,
    groupField: 'entidad_nombre',
    proxy: {
        type: 'ajax',
        url: SITEURL + "/comedores",
        api: {
            create: SITEURL + "/comedores/save",
            update: SITEURL + "/comedores/save",
            destroy: SITEURL + "/comedores/remove"
        },
        reader: {
            type: 'json',
            root: 'data'
        }
    }
});


