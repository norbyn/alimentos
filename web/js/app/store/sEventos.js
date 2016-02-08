Ext.define('FV.store.sEventos', {
    extend: 'Ext.data.Store',
    model: "FV.model.mEventos",
    autoSync: true,
    groupField: 'entidad_nombre',
    proxy: {
        type: 'ajax',
        url:SITEURL+"/eventosc",
        api: {
            create: SITEURL + "/eventosc/save",
            update: SITEURL + "/eventosc/save",
            destroy: SITEURL + "/eventosc/remove"
        },
        reader: {
            type: 'json',
            root: 'data'
        }
    }
});


