Ext.define('FV.view.Productomercado.View', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.productomercadoView',
    itemId: 'merc-panel',
    frame: true,
    bodyPadding: '5 5 5 0',
    flex: 1,
    layout: 'column',
    height: window.innerHeight,
    fieldDefaults: {
        labelAlign: 'left',
        msgTarget: 'qtip'
    },
    items: [{
            columnWidth: 0.63,
            xtype: 'productomercadoGrid'
        }, {
            xtype: 'productomercadoForm',
            columnWidth: 0.37
        }],
    initComponent: function() {

        this.callParent();
    }
});









