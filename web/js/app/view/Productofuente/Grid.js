Ext.define('FV.view.Productofuente.Grid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.productofuenteGrid',
    store: "sProductofuente",
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
                    text: 'Fuente',
                    dataIndex: 'Fuente',
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
                            tooltip: 'Eliminar Fuente',
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
                        },
                        {
                            text: 'Reporte',
                            iconCls: 'reporte',
                            menu: [
                                {
                                    text: 'Generar PDF',
                                    iconCls: 'pdf',
                                    disabled: false,
                                    handler: function() {
                                        var uri_string = SITEURL + '/reportes/generar_pdf_portada/' + me.down('#yearField').getValue();
                                        window.location.href = uri_string;
                                    }
                                },
                                {
                                    text: 'Generar Excel',
                                    iconCls: 'xls',
                                    disabled: false,
                                    handler: function() {
                                        var uri_string = SITEURL + '/reportes/generar_xls_portada/' + me.down('#yearField').getValue();
                                        window.location.href = uri_string;
                                        Ext.Msg.wait('<img src="' + BASEURL + 'web/images/icons/fam/xls.gif" style="float:left; margin-right:5px;">Generando Excel!');
                                        window.setTimeout(function() {
                                            Ext.Msg.hide();
                                        }, 6000);
                                    }
                                }
                            ]
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
                    emptyMsg: "No se encontraron fuentes"
                }
            ]
        });
        me.callParent(arguments);
    },
    renderObjectColumn: function(obj) {
        return obj.nombre;
    }
});






