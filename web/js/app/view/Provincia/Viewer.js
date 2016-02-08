Ext.define('FV.view.Provincia.Viewer', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.provPanel',
	itemId: "provincia-panel",
    //requires: [],
    margins: '5 5 5 5',
    cls: 'preview',
	items: [
        { xtype: 'provGrid'},
        { xtype: 'municipiosGrid', title: 'Municpios'}
    ],
    initComponent: function() {
        
        this.callParent();
    }
});
