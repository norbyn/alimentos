Ext.define('FV.view.Organismonominalizado.Grid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.nominalizadoView',
    itemId: 'org_nom-panel',
    id: 'org_nom-panel',
    store: "sOrganismonominalizado",
    loadMask: true,
    selModel: {
        allowDeselect: true
    },
    height: window.innerHeight - 65,
    defaults: {
        flex: 1,
        sortable: true
    },
    viewConfig: {
        emptyText: 'No hay resultados para esta fecha',
        deferEmptyText: false,
        loadMask: {msg: "Cargando"}
    },
    features: [{
            id: 'group',
            ftype: 'groupingsummary',
            groupHeaderTpl: '{name}',
            enableGroupingMenu: false
        }],
    initComponent: function() {
        var monthsStore = Ext.create('FV.store.sMonths', {autoLoad: true});
        var me = this;
        Ext.applyIf(me, {columns: [
                new Ext.grid.RowNumberer(),
                {
                    header: 'Entidad/Producto',
                    tdCls: 'group',
                    dataIndex: 'producto_nombre',
                    summaryType: 'count',
                    summaryRenderer: function(value) {
                        return ((value === 0 || value > 1) ? '(' + value + ' Productos)' : '(1 Producto)');
                    },
                    flex: 1
                },
                {
                    header: 'Proveedor',
                    dataIndex: 'proveedor',
                    flex: 1
                },
                {
                    header: 'Cantidad',
                    dataIndex: 'ctd',
                    //summaryType: 'sum',
                    flex: 1
                },
                {
                    header: 'Fecha',
                    dataIndex: 'fecha',
                    xtype: 'datecolumn',
                    format: 'd/m/Y',
                    hidden: false
                }

            ],
            dockedItems: [{
                    xtype: 'toolbar',
                    items: [
                        {
                            action: 'show',
                            text: 'Asignar',
                            tooltip: 'Nuevo Inventario',
                            iconCls: 'add'
                        },
                        '->',
                        {
                            xtype: 'combobox',
                            name: 'combo_month',
                            displayField: 'name',
                            valueField: 'num',
                            itemId: 'combo_monthID2',
                            queryMode: 'local',
                            emptyText: 'Mes',
                            hideLabel: true,
                            margins: '0 6 0 0',
                            store: monthsStore,
                            id: 'combo_montH2',
                            flex: 1,
                            allowBlank: true,
                            forceSelection: true,
                            editable: false

                        },
                        {
                            xtype: 'numberfield',
                            name: 'year',
                            itemId: 'yearFieldID2',
                            hideLabel: true,
                            width: 55,
                            value: new Date().getFullYear(),
                            //minValue: new Date().getFullYear(),
                            allowBlank: false,
                            editable: false
                        },
                        {
                            text: 'Reporte',
                            iconCls: 'reporte',
                            menu: [{
                                    text: 'Vista previa',
                                    iconCls: 'preview',
                                    handler: function() {
                                        var mes = me.down('#combo_monthID2').getValue();
                                        if (mes == null)
                                            mes = -1;
                                        Ext.Ajax.request({
                                            scope: this,
                                            params: {
                                                //username: form.getForm().findField('username').getValue(),
                                                //password: form.getForm().findField('password').getValue()
                                            },
                                            url: SITEURL + '/reportes/nominalizados_y_otros/' + mes + '/' + me.down('#yearFieldID2').getValue(),
                                            success: function(response, opts) {
                                                var obj = Ext.decode(response.responseText);
                                                var myData = Ext.decode(obj.data);
                                                // Ext.Msg.alert('Error', response.responseText);
                                                var store = Ext.create('Ext.data.ArrayStore', {
                                                    fields: Ext.decode(obj.fields),
                                                    //groupField: 'nombre_producto',
                                                    data: myData
                                                });
                                                Ext.create('Ext.window.Window', {
                                                    title: 'Organismos Nominalizados',
                                                    height: 400,
                                                    layout: 'fit',
                                                    iconCls: 'preview',
                                                    modal: true,
                                                    width: 900,
                                                    items: {// Let's put an empty grid in just to illustrate fit layout
                                                        xtype: 'grid',
                                                        store: store,
                                                        stateful: true,
                                                        stateId: 'stateGrid',
                                                        columns: Ext.decode(obj.columns)
                                                                //title: 'Array Grid',
                                                        ,
                                                        features: [{
                                                                id: 'group',
                                                                ftype: 'groupingsummary',
                                                                groupHeaderTpl: '{name}',
                                                                enableGroupingMenu: false
                                                            }],
                                                        selModel: {
                                                            allowDeselect: true
                                                        },
                                                        viewConfig: {
                                                            stripeRows: true
                                                        }
                                                    }
                                                }).show();
                                            }
                                        });

                                    }
                                },
                                {
                                    action: 'reporte',
                                    text: 'Generar PDF',
                                    tooltip: 'Generar PDF',
                                    iconCls: 'pdf',
                                    disabled: false,
                                    handler: function() {
                                        var mes = me.down('#combo_monthID2').getValue();
                                        if (mes == null)
                                            mes = -1;
                                        var uri_string = SITEURL + '/reportes/generar_pdf_nominalizados/' + mes + '/' + me.down('#yearFieldID2').getValue();
                                        window.location.href = uri_string;
                                    }
                                }
                                ,
                                {
                                    action: 'reporte',
                                    text: 'Generar Excel',
                                    tooltip: 'Generar Excel',
                                    iconCls: 'xls',
                                    disabled: false,
                                    handler: function() {
                                        var mes = me.down('#combo_monthID2').getValue();
                                        if (mes == null)
                                            mes = -1;
                                        var uri_string = SITEURL + '/reportes/generar_xls_nominalizados/' + mes + '/' + me.down('#yearFieldID2').getValue();
                                        window.location.href = uri_string;
                                        Ext.Msg.wait('<img src="' + BASEURL + 'web/images/icons/fam/xls.gif" style="float:left; margin-right:5px;">Generando Excel!');
                                        window.setTimeout(function() {
                                            Ext.Msg.hide();
                                        }, 3000);
                                    }
                                }

                            ]
                        }

                    ]
                }]});
        this.callParent();
    }
});






