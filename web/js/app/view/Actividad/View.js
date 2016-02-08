Ext.define('FV.view.Actividad.View', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.actividadView',
    itemId: 'actividad-panel',
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
            xtype: 'actividadGrid'
        }, {
            xtype: 'actividadForm',
            columnWidth: 0.3
        }],
    initComponent: function() {

        this.callParent();
    }
});









