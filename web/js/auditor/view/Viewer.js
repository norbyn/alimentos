Ext.define('FV.view.Viewer', {
    extend: 'Ext.tab.Panel',
    alias: 'widget.viewer',
    requires: ['FV.view.Registros.Grid'],
    activeItem: 0,
    margins: '5 5 5 5',
    cls: 'preview',
    initComponent: function() {
        this.items = [{
                itemId: "main-tab",
                title: 'Auditoría del sistema',
                items: [{
                        itemId: 'content-panel',
                        region: 'center', // this is what makes this panel into a region within the containing layout
                        layout: 'card',
                        margins: '2 5 5 0',
                        activeItem: 0,
                        border: false,
                        items: [{
                                xtype: 'logGrid'
                            }]
                    }]
            }];

        this.callParent();
    }
});
