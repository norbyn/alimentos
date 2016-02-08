Ext.define('FV.view.Boleta.ContextMenu', {
    extend: 'Ext.menu.Menu',
    alias: 'widget.boletaContextMenu',
    config: {
        record: null
    },
    items: [
        {
            text: 'Asignar productos',
            action: 'assign',
            iconCls: 'accept'
        }
    ]
});
