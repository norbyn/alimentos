Ext.define('FV.view.Actividad.Grid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.actividadGrid',
    store: "sActividad",
    loadMask: true,
    selModel: {
        allowDeselect: true
    },
    //height: window.innerHeight - 90,
    defaults: {
        flex: 1,
        sortable: true
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
                    text: 'Actividad',
                    dataIndex: 'nombre',
                    flex: 2
                }
            ],
            dockedItems: [{
                    xtype: 'toolbar',
                    items: [{
                            action: 'delete',
                            text: 'Eliminar',
                            tooltip: 'Eliminar',
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
    }
});






