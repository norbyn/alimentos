Ext.define('FV.view.Eventos.Grid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.eventosGrid',
    itemId: 'evt-panel',
    id: 'evt-panel',
    store: "sEventos",
    loadMask: {
        msg: "Cargando..."
    },
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
    listeners: {
        'selectionchange': function(view, records) {
            this.down('#delete').setDisabled(!records.length);//Se Habilita el Boton Delete
            this.down('#edit').setDisabled(!records.length);//Se Habilita el Boton Delete
        }
    },
    initComponent: function() {
        var monthsStore = Ext.create('FV.store.sMonths', {autoLoad: true});
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
                    header: 'Concepto',
                    dataIndex: 'concepto',
                    width: 125,
                    flex: 1
                },
                {
                    header: 'Cantidad',
                    dataIndex: 'cant',
                    flex: 1
                },
                {
                    header: 'Ajuste',
                    dataIndex: 'ajuste',
                    flex: 1,
                    hidden: true
                },
                {
                    header: 'Fecha',
                    dataIndex: 'fecha',
                    xtype: 'datecolumn',
                    format: 'd/m/Y'
                }

            ], dockedItems: [{
                    xtype: 'toolbar',
                    items: [
                        {
                            action: 'actAgregar',
                            text: 'Adicionar',
                            tooltip: 'Nuevo Evento',
                            iconCls: 'add'
                        }
                        , '-', {
                            itemId: 'edit',
                            text: 'Editar',
                            iconCls: 'edit',
                            scope: this,
                            action: 'actEditar'
                                    //handler:this.OnEditar
                        }, '-',
                        {
                            action: 'delete',
                            itemId: 'delete',
                            text: 'Eliminar',
                            tooltip: 'Eliminar Evento',
                            iconCls: 'remove',
                            disabled: true
                        }, '->',
                        {
                            xtype: 'combobox',
                            name: 'combo_month',
                            displayField: 'name',
                            valueField: 'num',
                            itemId: 'combo_monthID1',
                            queryMode: 'local',
                            emptyText: 'Mes',
                            hideLabel: true,
                            margins: '0 6 0 0',
                            store: monthsStore,
                            id: 'combo_month1',
                            flex: 1,
                            allowBlank: true,
                            forceSelection: true,
                            editable: false

                        },
                        {
                            xtype: 'numberfield',
                            name: 'year',
                            itemId: 'yearFieldID1',
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
                            menu: [/*{
                             text: 'Vista previa',
                             iconCls: 'preview',
                             handler: function() {
                             var mes = me.down('#combo_monthID1').getValue();
                             if (mes == null)
                             mes = -1;
                             Ext.Ajax.request({
                             scope: this,
                             params: {
                             //username: form.getForm().findField('username').getValue(),
                             //password: form.getForm().findField('password').getValue()
                             },
                             url: SITEURL + '/reportes/eventos/' + mes + '/' + me.down('#yearFieldID1').getValue(),
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
                             title: 'Eventos',
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
                             },*/
                                {
                                    action: 'reporte',
                                    text: 'Generar PDF',
                                    tooltip: 'Generar PDF',
                                    iconCls: 'pdf',
                                    disabled: false,
                                    handler: function() {
                                        var mes = me.down('#combo_monthID1').getValue();
                                        if (mes == null)
                                            mes = -1;
                                        var uri_string = SITEURL + '/reportes/generar_pdf_evento/' + mes + '/' + me.down('#yearFieldID1').getValue();
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
                                        var mes = me.down('#combo_monthID1').getValue();
                                        if (mes == null)
                                            mes = -1;
                                        var uri_string = SITEURL + '/reportes/generar_xls_evento/' + mes + '/' + me.down('#yearFieldID1').getValue();
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
                }]});
        this.callParent();
    },
    renderObjectColumn: function(obj) {
        return obj.nombre;
    }
});






