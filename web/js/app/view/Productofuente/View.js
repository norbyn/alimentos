Ext.define('FV.view.Productofuente.View', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.productofuenteView',
    itemId: 'fte-panel',
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
            xtype: 'productofuenteGrid'
        }, {
            xtype: 'productofuenteForm',
            columnWidth: 0.37
        }],
    initComponent: function() {

        this.callParent();
    }
});









