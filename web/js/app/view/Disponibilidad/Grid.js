Ext.define('FV.view.Disponibilidad.Grid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.disponibilidadGrid',
    itemId: 'disponibilidad-panel',
    id: 'disponibilidad-panel',
    store: "sDisponibilidad",
    loadMask: true,
    height: window.innerHeight - 65,
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
        var me = this;
        Ext.applyIf(me, {columns: [
                new Ext.grid.RowNumberer(),
                {
                    header: 'Proveedor/Productos',
                    width: 200,
                    tdCls: 'group',
                    dataIndex: 'producto_nombre'
//                summaryType: 'count',
//                summaryRenderer: function(value) {
//                    return ((value === 0 || value > 1) ? '(' + value + ' Productos)' : '(1 Producto)');
//                }
                },
                {
                    header: 'UM',
                    dataIndex: 'um'
                },
                {
                    header: 'Saldo inicial',
                    dataIndex: 'saldo'
                            // summaryType: 'sum'
                },
                {
                    header: 'Fecha',
                    dataIndex: 'fecha',
                    xtype: 'datecolumn',
                    format: 'd/m/Y',
                    flex: 2
                }
            ],
            dockedItems: [{
                    xtype: 'toolbar',
                    items: [
                        {
                            action: 'add',
                            text: 'Adicionar',
                            tooltip: 'Nuevo',
                            iconCls: 'add'
                        },
                        {
                            itemId: 'edit',
                            text: 'Editar',
                            iconCls: 'edit',
                            scope: this,
                            action: 'actEditar'
                                    //handler:this.OnEditar
                        },
                        {
                            action: 'delete',
                            itemId: 'delete',
                            text: 'Eliminar',
                            tooltip: 'Eliminar Fuente',
                            iconCls: 'remove',
                            disabled: true
                        },
                        '->'
                                , {
                                    xtype: 'combobox',
                                    name: 'combo_month2',
                                    itemId: 'combo_month_disp',
                                    displayField: 'name',
                                    valueField: 'num',
                                    queryMode: 'local',
                                    emptyText: 'Mes',
                                    hideLabel: true,
                                    margins: '0 6 0 0',
                                    store: Ext.create('FV.store.sMonths', {autoLoad: true}),
                                    id: 'combo_month2',
                                    flex: 1,
                                    allowBlank: true,
                                    forceSelection: true,
                                    editable: false,
                                    listeners: {
                                        'select': function(combo, obj) {
                                            me.down('#reporte_disponibilidad').setDisabled(false);
                                            me.down('#reporte_disponibilidad').setTooltip("Ver reporte (" + combo.getRawValue() + ")");
                                        }
                                    }
                                },
                        {
                            xtype: 'numberfield',
                            name: 'year',
                            itemId: 'yearFieldDisp',
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
                            itemId: 'reporte_disponibilidad',
                            tooltip: 'Debe filtrar por mes',
                            disabled: true,
                            menu: [
                                {
                                    action: 'pdf',
                                    text: 'Generar PDF',
                                    tooltip: 'Generar PDF',
                                    iconCls: 'pdf',
                                    disabled: false,
                                    handler: function() {
                                        var mes = me.down('#combo_month_disp').getValue();
                                        if (mes === null)
                                            mes = -1;
                                        var y = me.down('#yearFieldDisp').getValue();
                                        var uri_string = SITEURL + '/reportes/generar_pdf_disp/' + mes + '/' + y;
                                        window.location.href = uri_string;
                                    }
                                }
                                ,
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
                                        Ext.Msg.wait('<img src="' + BASEURL + 'web/images/icons/fam/xls.gif" style="float:left; margin-right:5px;">Generando Excel!');
                                        window.setTimeout(function() {
                                            Ext.Msg.hide();
                                        }, 4000);
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
                }]
        });
        me.callParent();
    }
});






