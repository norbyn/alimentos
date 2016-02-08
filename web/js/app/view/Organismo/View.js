Ext.define('FV.view.Organismo.View', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.organismoView',
    itemId: 'organismo-panel',
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
            columnWidth: 0.7,
            xtype: 'organismoGrid'
        }, {
            xtype: 'organismoForm',
            columnWidth: 0.3
        }],
    initComponent: function() {

        this.callParent();
    }
});
