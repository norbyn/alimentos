Ext.define('FV.store.sBoletaProducto', {
    extend: 'Ext.data.Store',
    model: "FV.model.mBoletaProducto",
    autoSync: true,
    autoLoad: false,
    proxy: {
        type: 'ajax',
        url: SITEURL + "/c_boletaproducto",
        api: {
            create: SITEURL + "/c_boletaproducto/save",
            update: SITEURL + "/c_boletaproducto/save",
            destroy: SITEURL + "/c_boletaproducto/remove"
        },
        reader: {
            type: 'json',
            root: 'data',
            totalProperty: 'totalCount'
        }
    }
});


