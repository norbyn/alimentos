Ext.define('FV.store.sOrganismonominalizado', {
    extend: 'Ext.data.Store',
    model: "FV.model.mOrganismonominalizado",
    autoSync: true,
    groupField: 'entidad_nombre',
    proxy: {
        type: 'ajax',
        url: SITEURL + "/organismonominalizado",
        api: {
            create: SITEURL + "/organismonominalizado/save",
            update: SITEURL + "/organismonominalizado/save",
            destroy: SITEURL + "/organismonominalizado/remove"
        },
        reader: {
            type: 'json',
            root: 'data'
        }
    }
});





