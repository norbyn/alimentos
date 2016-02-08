Ext.define('FV.store.sProveedor', {
    extend: 'Ext.data.Store',
    model: "FV.model.mProveedor",
    autoSync: true,
    pageSize: 100,
    proxy: {
        type: 'ajax',
        url: SITEURL + "/proveedor",
        api: {
            create: SITEURL + "/proveedor/save",
            update: SITEURL + "/proveedor/save",
            destroy: SITEURL + "/proveedor/remove"
        },
        reader: {
            type: 'json',
            root: 'data',
            totalProperty: 'totalCount'
        }
    }
});


