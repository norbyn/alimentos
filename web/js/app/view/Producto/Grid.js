Ext.define('FV.view.Producto.Grid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.productoGrid',
    store: Ext.create('FV.store.sProducto', {autoLoad: true, pageSize: 20}),
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
//    features: [{
//            id: 'group',
//            ftype: 'groupingsummary',
//            groupHeaderTpl: '{name}',
//            enableGroupingMenu: false
//        }],
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
                    header: 'Producto',
//                    header: 'Proveedor/Producto',
//                    tdCls: 'group',
                    dataIndex: 'nombre',
                    flex: 2
                },
                {
                    text: 'Unidad de Medida',
                    dataIndex: 'Um',
                    flex: 2,
                    renderer: this.renderObjectColumn
                },
                 {
                    text: 'Norma',
                    dataIndex: 'norma',
                    flex: 2
                },
                {
                    text: 'Proveedor',
                    dataIndex: 'Proveedor',
                    flex: 2,
                    renderer: this.renderObjectColumn
                            // hidden: true
                }

            ],
            dockedItems: [{
                    xtype: 'toolbar',
                    items: [{
                            action: 'delete',
                            text: 'Eliminar',
                            tooltip: 'Eliminar Producto',
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
    renderObjectColumn: function(obj) {
        return obj.nombre;
    }
});
