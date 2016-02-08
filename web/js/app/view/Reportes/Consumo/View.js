Ext.define('FV.view.Reportes.Consumo.View', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.consumoView',
    itemId: 'consumo-panel',
    frame: true,
    bodyPadding: '5 5 5 0',
    flex: 1,
    layout: 'fit',
    items: [{
            xtype: 'consumoGrid'
        }],
    initComponent: function() {

        this.callParent();
    }
});






