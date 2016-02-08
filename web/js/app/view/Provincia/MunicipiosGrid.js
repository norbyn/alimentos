Ext.define('FV.view.Provincia.MunicipiosGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.municipiosGrid',
    itemId: "municipios-panel",
    store: "Municipios",
    title: "Municipios",
    margins: '5 5 5 5',
    cls: 'preview',
    height: 350,
    viewConfig: {
        loadMask: {msg: "Cargando..."}
    },
    initComponent: function() {
        var me = this;
        Ext.applyIf(me, {columns: [new Ext.grid.RowNumberer(),
                {header: 'Nro', dataIndex: 'id', hidden: true},
                {header: 'Municipio', dataIndex: 'nombre', flex: 1}],
            dockedItems: [
                {
                    xtype: 'pagingtoolbar', //Barra Paginadora al fondo del Grid
                    dock: 'bottom',
                    displayInfo: true,
                    store: me.store,
                    firstText: 'Primera página',
                    prevText: 'Página anterior',
                    beforePageText: 'Página',
                    afterPageText: 'de {0}',
                    nextText: 'Página siguiente',
                    lastText: 'Última página',
                    refreshText: 'Recargar',
                    displayMsg: 'Mostrando {0} - {1} de {2}',
                    emptyMsg: "No se encontraron registros"
                }
            ]
        });
        me.callParent();
    }
});
