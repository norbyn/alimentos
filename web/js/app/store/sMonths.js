Ext.define('FV.store.sMonths', {
    extend: 'Ext.data.Store',
    model: "FV.model.mMonths",
    autoLoad: true,
    proxy: {
        type: 'ajax',
        url: SITEURL + "/months",
        reader: {
            type: 'json',
            root: 'data'
        }
    }
});