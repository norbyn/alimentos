Ext.define('FV.view.Viewport', {
    extend: 'Ext.container.Viewport',
    requires: [
        'FV.view.Viewer',
        'FV.view.MainMenu',
        'Ext.layout.container.Border'
    ],
    layout: 'border',
    items: [
        {
            xtype: 'panel',
            region: 'north',
            tbar: Ext.create("FV.view.Toolbar"),
            //html: '<div style="background: #c3daf9; color:#15498B; font-size: 20px; text-align: left; padding:0.1em; text-shadow: 5px 5px 10px rgba(255,255,255,1);"><h2>ALIPLAN</h2></div>'
            //html: '<div style="background: #ababab; color:#000000; font-size: 20px; text-align: left; padding:0.1em; text-shadow: 5px 5px 10px rgba(255,255,255,1);"><h2>ALIPLAN</h2></div>'
        },
        {
            region: 'center',
            xtype: 'viewer'
        }, {
            region: 'west',
            width: 245,
            xtype: 'mainmenu'
        }]
});

