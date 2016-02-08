Ext.define('FV.view.Productomercado.Grid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.productomercadoGrid',
    store: "sProductomercado",
    loadMask: true,
    split: true,
    frame: true,
    columnLines: true,
    height: window.innerHeight - 100,
    selModel: {
        allowDeselect: true
    },
    defaults: {
        flex: 1,
        sortable: true
    },
    viewConfig: {
        emptyText: 'No hay resultados para esta fecha',
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
                    width: 40,
                    hidden: true
                },
                {
                    text: 'Producto',
                    dataIndex: 'Producto',
                    flex: 2,
                    renderer: this.renderObjectColumn
                },
                {
                    text: 'Mercado',
                    dataIndex: 'Mercado',
                    flex: 2,
                    renderer: this.renderObjectColumn
                },
                {
                    text: 'Cantidad',
                    dataIndex: 'cant',
                    flex: 2
                },
                {
                    header: 'Fecha',
                    dataIndex: 'fecha',
                    flex: 2,
                    xtype: 'datecolumn',
                    format: 'd/m/Y',
                    menuDisabled: true
                }
            ],
            dockedItems: [{
                    xtype: 'toolbar',
                    items: [{
                            action: 'delete',
                            text: 'Eliminar',
                            tooltip: 'Eliminar Mercado',
                            iconCls: 'remove',
                            disabled: true
                        },
                        '->',
                        {
                            xtype: 'numberfield',
                            name: 'year',
                            itemId: 'yearField',
                            hideLabel: true,
                            width: 55,
                            value: new Date().getFullYear(),
                            //minValue: new Date().getFullYear(),
                            allowBlank: false
                        }
                    ]
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
                    emptyMsg: "No se encontraron mercados"
                }
            ]
        });
        me.callParent(arguments);
    },
    renderObjectColumn: function(obj) {
        return obj.nombre;
    }
});






