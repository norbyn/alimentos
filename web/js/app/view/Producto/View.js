Ext.define('FV.view.Producto.View', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.productoView',
    itemId: 'nomProd-panel',
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
            columnWidth: 0.63,
            xtype: 'productoGrid'
        }, {
            xtype: 'productoForm',
            columnWidth: 0.37
        }],
    initComponent: function() {

        this.callParent();
    }
});
