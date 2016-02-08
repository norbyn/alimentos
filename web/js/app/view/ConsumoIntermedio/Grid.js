Ext.define('FV.view.ConsumoIntermedio.Grid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.consumoInterView',
    itemId: 'cons_inter-panel',
    id: 'cons_inter-panel',
    store: "sConsumoInter",
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
                    dataIndex: 'cant',
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
                            tooltip: 'Nuevo',
                            iconCls: 'add'
                        },
                        '->',
                        {
                            xtype: 'combobox',
                            name: 'combo__month',
                            displayField: 'name',
                            valueField: 'num',
                            itemId: 'combo__monthID',
                            queryMode: 'local',
                            emptyText: 'Mes',
                            hideLabel: true,
                            margins: '0 6 0 0',
                            store: monthsStore,
                            id: 'combo__month',
                            flex: 1,
                            allowBlank: true,
                            forceSelection: true,
                            editable: false

                        },
                        {
                            xtype: 'numberfield',
                            name: 'year',
                            itemId: 'year_FieldID',
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
                                        var mes = me.down('#combo__monthID').getValue();
                                        if (mes == null)
                                            mes = -1;
                                        Ext.Ajax.request({
                                            scope: this,
                                            params: {
                                                //username: form.getForm().findField('username').getValue(),
                                                //password: form.getForm().findField('password').getValue()
                                            },
                                            url: SITEURL + '/reportes/consumointer/' + mes + '/' + me.down('#year_FieldID').getValue(),
                                            success: function(response, opts) {
                                                var obj = Ext.decode(response.responseText);
                                                var myData = Ext.decode(obj.data);
                                                // Ext.Msg.alert('Error', response.responseText);
                                                var store = Ext.create('Ext.data.ArrayStore', {
                                                    fields: Ext.decode(obj.fields),
                                                    groupField: 'org_nombre',
                                                    data: myData
                                                });
                                                Ext.create('Ext.window.Window', {
                                                    title: 'ConsumoInter',
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
                                        var mes = me.down('#combo__monthID').getValue();
                                        if (mes === null)
                                            mes = -1;
                                        var uri_string = SITEURL + '/reportes/generar_pdf_consumointer/' + mes + '/' + me.down('#year_FieldID').getValue();
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
                                        var mes = me.down('#combo__monthID').getValue();
                                        if (mes === null)
                                            mes = -1;
                                        var uri_string = SITEURL + '/reportes/generar_xls_consumointer/' + mes + '/' + me.down('#year_FieldID').getValue();
                                        window.location.href = uri_string;
                                        Ext.Msg.wait('<img src="' + BASEURL + 'web/images/icons/fam/xls.gif" style="float:left; margin-right:5px;">Generando Excel!');
                                        window.setTimeout(function() {
                                            Ext.Msg.hide();
                                        }, 4000);
                                    }
                                }

                            ]
                        }
                    ]
                }]

        });
        this.callParent();
    }
});






