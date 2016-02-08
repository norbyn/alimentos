Ext.define('FV.view.NivelAct.Grid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.nivelActGrid',
    itemId: 'nivelAct-panel',
    id: 'nivelAct-panel',
    store: "sNivelAct",
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
        var me = this;
        Ext.applyIf(me, {columns: [
                new Ext.grid.RowNumberer(),
                {
                    header: 'Entidad/Comedor',
                    tdCls: 'group',
                    dataIndex: 'comedor_nombre',
                    summaryType: 'count',
                    summaryRenderer: function(value) {
                        return ((value === 0 || value > 1) ? '(' + value + ' Comedores)' : '(1 Comedor)');
                    },
                    flex: 1
                },
                {
                    header: 'T.C.',
                    dataIndex: 'comedor_tc',
                    //summaryType: 'count',
                    flex: 1
                },
                {
                    header: 'Nivel de Act. Plan',
                    dataIndex: 'fisico',
                    summaryType: 'sum',
                    flex: 1
                },
                {
                    header: 'Nivel de Act. Real',
                    dataIndex: 'nivel_act',
                    summaryType: 'sum',
                    flex: 1
                },
                {
                    header: 'Eventos',
                    columns: [
                        {
                            header: 'Almuerzo',
                            dataIndex: 'almuerzo_evt',
                            summaryType: 'sum',
                            flex: 1
                        },
                        {
                            header: 'Comida',
                            dataIndex: 'comida_evt',
                            summaryType: 'sum',
                            flex: 1
                        },
                        {
                            header: 'Merienda',
                            dataIndex: 'merienda_evt',
                            summaryType: 'sum',
                            flex: 1
                        }
                    ]
                }
            ], dockedItems: [{
                    xtype: 'toolbar',
                    items: [
                        {
                            action: 'add',
                            text: 'Adicionar',
                            tooltip: 'Nuevo Nivel de Actividad',
                            iconCls: 'add'
                        },
                        {
                            action: 'delete',
                            text: 'Eliminar',
                            tooltip: 'Eliminar Fuente',
                            iconCls: 'remove',
                            disabled: true
                        },
                        '->',
                        /* {
                         xtype: 'combobox',
                         name: 'combo_m',
                         displayField: 'name',
                         valueField: 'num',
                         queryMode: 'local',
                         emptyText: 'Mes',
                         hideLabel: true,
                         margins: '0 6 0 0',
                         store: Ext.create('FV.store.sMonths', {autoLoad: true}),
                         id: 'combo_m',
                         flex: 1,
                         allowBlank: true,
                         forceSelection: true,
                         editable: false
                         },*/ {
                            xtype: 'numberfield',
                            name: 'year',
                            itemId: 'yearField',
                            hideLabel: true,
                            width: 55,
                            value: new Date().getFullYear(),
                            //minValue: new Date().getFullYear(),
                            allowBlank: false,
                            editable: false
                        }
                        ,
                        {
                            text: 'Reporte',
                            iconCls: 'reporte',
                            menu: [
                                {
                                    text: 'Generar PDF',
                                    tooltip: 'Generar PDF',
                                    iconCls: 'pdf',
                                    disabled: false,
                                    handler: function() {
                                        var uri_string = SITEURL + '/reportes/generar_pdf_nivel_actividad/' + me.down('#yearField').getValue();
                                        window.location.href = uri_string;
                                    }
                                }
                                , {
                                    text: 'Generar Excel',
                                    iconCls: 'xls',
                                    menu: [
                                        {
                                            text: 'Nivel de Actividad',
                                            iconCls: 'xls',
                                            disabled: false,
                                            handler: function() {
                                                var uri_string = SITEURL + '/reportes/generar_xls_nivel_actividad/' + me.down('#yearField').getValue();
                                                window.location.href = uri_string;
                                                Ext.Msg.wait('<img src="' + BASEURL + 'web/images/icons/fam/xls.gif" style="float:left; margin-right:5px;">Generando Excel!');
                                                window.setTimeout(function() {
                                                    Ext.Msg.hide();
                                                }, 4000);
                                            }
                                        },
                                        {
                                            text: 'Base de Datos',
                                            iconCls: 'xls',
                                            disabled: false,
                                            handler: function() {
                                                var uri_string = SITEURL + '/reportes/generar_xls_basedatos/' + me.down('#yearField').getValue();
                                                window.location.href = uri_string;
                                                Ext.Msg.wait('<img src="' + BASEURL + 'web/images/icons/fam/xls.gif" style="float:left; margin-right:5px;">Generando Excel!');
                                                window.setTimeout(function() {
                                                    Ext.Msg.hide();
                                                }, 4000);
                                            }
                                        },
                                        {
                                            text: 'Mensual',
                                            iconCls: 'xls',
                                            disabled: false,
                                            handler: function() {
                                                var uri_string = SITEURL + '/reportes/generar_xls_mensual/' + me.down('#yearField').getValue();
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
                        }
                    ]
                }]});
        this.callParent();
    },
    renderObjectName: function(obj) {
        return obj.TipoComedor.nombre;
    },
    renderObjectTC: function(obj) {
        return obj.tc;
    }
});






