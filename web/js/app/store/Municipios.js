Ext.define('FV.store.Municipios', {
    extend: 'Ext.data.Store',
    model: "FV.model.Municipio",
    autoSync: true,
    proxy: {
        type: 'ajax',
        url: SITEURL + "/municipio",
        api: {
            create: SITEURL + "/municipio/save",
            update: SITEURL + "/municipio/save",
            destroy: SITEURL + "/municipio/remove"
        },
        reader: {
            type: 'json',
            root: 'data'
        }
    }
});