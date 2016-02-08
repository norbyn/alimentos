Ext.define('FV.view.BD.ContextMenu', {
    extend: 'Ext.menu.Menu',
    alias: 'widget.bdContextMenu',
    config: {
        record: null
    },
    items: [
        {
            text: 'Asignar productos',
            action: 'assign',
            iconCls: 'product'
        },
        {
            text: 'Asignar nivel de actividad real del mes',
            action: 'real_mes',
            iconCls: 'sitemap'
        }
    ]
});
