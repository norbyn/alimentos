Ext.define('FV.view.Viewport', {
    extend: 'Ext.container.Viewport',
    requires: [
        'FV.view.Viewer'
    ],
    layout: 'border',
    items: [
        {
            xtype: 'panel',
            region: 'north',
            tbar: Ext.create("FV.view.Toolbar")
        },
        {
            region: 'center',
            xtype: 'viewer'
        }]
});

