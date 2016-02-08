Ext.define('FV.view.Mercado.View', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.mercadoView',
    itemId: 'nomMercado-panel',
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
            xtype: 'mercadoGrid'
        }, {
            xtype: 'mercadoForm',
            columnWidth: 0.3
        }],
    initComponent: function() {

        this.callParent();
    }
});









