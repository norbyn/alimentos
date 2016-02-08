Ext.define('FV.store.sNivelAct', {
    extend: 'Ext.data.Store',
    model: "FV.model.mNivelAct",
    autoSync: true,
    groupField: 'entidad_nombre',
    proxy: {
        type: 'ajax',
        url: SITEURL + "/nivelact",
        api: {
            create: SITEURL + "/nivelact/save",
            update: SITEURL + "/nivelact/save",
            destroy: SITEURL + "/nivelact/remove"
        },
        reader: {
            type: 'json',
            root: 'data'
        }
    }
});


