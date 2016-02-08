Ext.define('FV.view.Proveedor.View', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.proveedorView',
    itemId: 'nomProve-panel',
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
            xtype: 'proveedorGrid'
        }, {
            xtype: 'proveedorForm',
            columnWidth: 0.3
        }],
    initComponent: function() {

        this.callParent();
    }
});









