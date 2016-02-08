Ext.define('FV.view.Registros.Grid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.logGrid',
    itemId: 'registros-panel',
    id: 'registros-panel',
    store: "sRegistros",
    loadMask: true,
    height: window.innerHeight - 100,
    selModel: {
        allowDeselect: true
    },
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
                    header: 'ID',
                    dataIndex: 'id',
                    hidden: true
                },
                {
                    header: 'Estado',
                    dataIndex: 'success',
                    renderer: this.success_func
                },
                {
                    header: 'Fecha/Hora',
                    dataIndex: 'attempt_time',
                    xtype: 'datecolumn',
                    format: 'Y-m-d H:i:s',
                    flex: 1
                },
                {
                    header: 'Usuario',
                    dataIndex: 'username',
                    flex: 1
                },
                {
                    header: 'Dirección IP',
                    dataIndex: 'ip_address',
                    flex: 1
                },
                {
                    header: 'Navegador',
                    dataIndex: 'user_agent',
                    flex: 2
                },
                {
                    header: 'Suceso',
                    dataIndex: 'note',
                    flex: 3
                }
            ],
            dockedItems: [{
                    xtype: 'toolbar',
                    items: [
                        '->'
                                ,
                        {
                            text: 'Reporte',
                            iconCls: 'reporte',
                            itemId: 'reporte_disponibilidad',
                            //tooltip: 'Debe filtrar por mes',
                            disabled: false,
                            menu: [
                                {
                                    action: 'xls',
                                    text: 'Generar Excel',
                                    tooltip: 'Generar Excel',
                                    iconCls: 'xls',
                                    disabled: false,
                                    handler: function() {
                                        var mes = me.down('#combo_month_disp').getValue();
                                        if (mes === null)
                                            mes = -1;
                                        var y = me.down('#yearFieldDisp').getValue();
                                        var uri_string = SITEURL + '/reportes/generar_xls_disp/' + mes + '/' + y;
                                        window.location.href = uri_string;
                                    }
                                }

                            ]
                        }/*,
                        {
                            action: 'ayuda',
                            text: '',
                            tooltip: 'Ayuda',
                            iconCls: 'help',
                            itemId: 'ayuda_boleta'
                        }*/]
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
    success_func: function(val, x, store) {
        return  '<img src="' + BASEURL + 'web/images/icons/fam/' + val + '.png" align="left">';
    }
});






