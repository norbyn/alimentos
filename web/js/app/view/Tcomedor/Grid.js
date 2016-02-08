Ext.define('FV.view.Tcomedor.Grid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.tcomedorGrid',
    store: "sTcomedor",
    loadMask: true,
    selModel: {
        allowDeselect: true
    },
    //height: window.innerHeight - 160,
    defaults: {
        flex: 1,
        sortable: true
    },
    viewConfig: {
        emptyText: 'No hay resultados',
        deferEmptyText: false,
        loadMask: {msg: "Cargando"}
    },
    initComponent: function() {

        var me = this;
        Ext.applyIf(me, {columns: [
                new Ext.grid.RowNumberer(),
                {
                    header: 'Nro',
                    dataIndex: 'id',
                    hidden: true
                },
                {
                    text: 'Destino',
                    dataIndex: 'nombre',
                    flex: 2
                },
                {
                    text: 'Evento',
                    dataIndex: 'is_evento',
                    renderer: this.renderBooleanColumn
                },
                {
                    text: 'Periodo',
                    dataIndex: 'periodo'
                }
            ],
            dockedItems: [{
                    xtype: 'toolbar',
                    items: [{
                            action: 'delete',
                            text: 'Eliminar',
                            tooltip: 'Eliminar Comedor',
                            iconCls: 'remove',
                            disabled: true
                        }]
                },
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
    },
    renderBooleanColumn: function(val) {
        return val === true ? 'Si' : 'No';
    }
});






