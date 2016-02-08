Ext.define('FV.view.ActividadProducto.ContextMenu', {
    extend: 'Ext.menu.Menu',
    alias: 'widget.actividades_contextmenu',
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
