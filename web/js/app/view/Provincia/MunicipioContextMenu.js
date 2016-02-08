Ext.define('FV.view.Provincia.MunicipioContextMenu', {
    extend: 'Ext.menu.Menu',
    alias: 'widget.municipioContextMenu',
    config: {
        record: null
    },
    items: [
        {
            text: 'Editar Municipio',
            action: 'edit',
            iconCls: 'edit'
        },
        {
            text: 'Eliminar Municipio',
            action: 'delete',
            iconCls: 'remove'
        }
    ]
});
