Ext.define('FV.view.Entidad.View', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.entidadView',
    itemId: 'nomEnt-panel',
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
            xtype: 'entidadGrid',
        }, {
            xtype: 'entidadForm',
            columnWidth: 0.3
        }],
    initComponent: function() {

        this.callParent();
    }
});


