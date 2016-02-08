Ext.define('FV.view.Inventario.ContextMenu', {
    extend: 'Ext.menu.Menu',
    alias: 'widget.inventario_contextmenu',
    config: {
        record: null
    },
    items: [
        {
            text: 'Add',
            action: 'add',
            iconCls: 'add'
        },
        {
            text: 'Edit',
            action: 'edit',
            iconCls: 'edit'
        },
        {
            text: 'Delete',
            action: 'delete',
            iconCls: 'remove'
        }
    ]
})
