Ext.define('FV.view.Tcomedor.View', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.tcomedorView',
    itemId: 'nomCom-panel',
    frame: true,
    bodyPadding: '5 5 5 0',
    flex: 1,
    layout: 'column',
    height: window.innerHeight,
    fieldDefaults: {
        labelAlign: 'left',
        msgTarget: 'side'
    },
    items: [{
            columnWidth: 0.70,
            xtype: 'tcomedorGrid'
        }, {
            xtype: 'tcomedorForm',
            columnWidth: 0.3
        }],
//    items: [{
//            columnWidth: 1,
//            xtype: 'tabpanel',
//            tabPosition: 'bottom',
//            items: [{
//                    title: 'Destinos',
//                    layout: 'column',
//                    items: [{
//                            columnWidth: 0.70,
//                            xtype: 'tcomedorGrid'
//                        }, {
//                            xtype: 'tcomedorForm',
//                            columnWidth: 0.3
//                        }]
//                }, {
//                    title: 'Otros destinos (Eventos)'
//                }]
//        }],
    initComponent: function() {

        this.callParent();
    }
});









