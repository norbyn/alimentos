Ext.define('FV.view.Provincia.ContextMenu', {
    extend: 'Ext.menu.Menu',
    alias: 'widget.provinciaContextMenu',
    config: {
        record: null
    },
    items: [
        {
            text: 'NUEVO MUNICIPIO',
            action: 'assign',
            iconCls: 'accept'
        }
    ]
});
