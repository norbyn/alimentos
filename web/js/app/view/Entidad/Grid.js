Ext.define('FV.view.Entidad.Grid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.entidadGrid',
    store: "sEntidad",
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
                    text: 'Entidad',
                    dataIndex: 'nombre',
                    flex: 2
                },
                {
                    text: 'Organismo',
                    dataIndex: 'Organismo',
                    flex: 2,
                    renderer: this.renderObjectColumn
                },
                {
                    text: 'REEUP',
                    dataIndex: 'reeup'
                }
            ],
            dockedItems: [{
                    xtype: 'toolbar',
                    items: [{
                            action: 'delete',
                            text: 'Eliminar',
                            tooltip: 'Eliminar Entidad',
                            iconCls: 'remove',
                            disabled: true
                        }]
                }
                , {
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
    renderObjectColumn: function(obj) {
        return obj.nombre;
    }
});



