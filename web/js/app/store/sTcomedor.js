Ext.define('FV.store.sTcomedor', {
    extend: 'Ext.data.Store',
    model: "FV.model.mTcomedor",
    autoSync: true,
    autoLoad: true,
    pageSize: 100,
    proxy: {
        type: 'ajax',
        url: SITEURL + "/tcomedor",
        api: {
            create: SITEURL + "/tcomedor/save",
            update: SITEURL + "/tcomedor/save",
            destroy: SITEURL + "/tcomedor/remove"
        },
        reader: {
            type: 'json',
            root: 'data',
            totalProperty: 'totalCount'
        }
    }
});


