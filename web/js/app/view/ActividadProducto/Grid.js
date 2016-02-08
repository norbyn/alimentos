Ext.define('FV.view.ActividadProducto.Grid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.actividadesView',
    id: 'actividades-panel',
    store: "sActividadProducto",
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
                    header: 'Producto/Actividad',
                    tdCls: 'group',
                    dataIndex: 'Actividad',
                    renderer: this.renderObjectName,
                    flex: 1
                },
                {
                    header: 'Plan',
                    dataIndex: 'plan',
                    summaryType: 'sum',
                    flex: 1
                },
                {
                    header: 'Real',
                    dataIndex: 'actual',
                    summaryType: 'sum',
                    flex: 1
                },
                {
                    header: '%',
                    //xtype: 'templatecolumn',
                    //tpl: '{actual*100}',
                    dataIndex: 'porciento',
                    //summaryType: 'average',
                    xtype: 'numbercolumn',
                    format: '0.0',
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
                            tooltip: 'Asignar actividad a producto',
                            iconCls: 'add'
                        },
                        '->',
                        {
                            xtype: 'combobox',
                            name: 'combo_month_activ',
                            displayField: 'name',
                            valueField: 'num',
                            itemId: 'combo_month_activ',
                            queryMode: 'local',
                            emptyText: 'Mes',
                            hideLabel: true,
                            margins: '0 6 0 0',
                            store: monthsStore,
                            id: 'combo_month_activ',
                            flex: 1,
                            allowBlank: true,
                            forceSelection: true,
                            editable: false

                        },
                        {
                            xtype: 'numberfield',
                            name: 'year',
                            itemId: 'yearFieldID',
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
                            menu: [
                                {
                                    action: 'reporte',
                                    text: 'Generar PDF',
                                    tooltip: 'Generar PDF',
                                    iconCls: 'pdf',
                                    disabled: false,
                                    handler: function() {
                                        var mes = me.down('#combo_month_activ').getValue();
                                        if (mes === null)
                                            mes = -1;
                                        var uri_string = SITEURL + '/reportes/generar_pdf_balance/' + me.down('#yearFieldID').getValue();
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
                                        var mes = me.down('#combo_month_activ').getValue();
                                        if (mes === null)
                                            mes = -1;
                                        var uri_string = SITEURL + '/reportes/generar_xls_balance/' + me.down('#yearFieldID').getValue();
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
                }]

        });
        this.callParent();
    },
    renderObjectName: function(obj) {
        return obj.nombre;
    }
});






