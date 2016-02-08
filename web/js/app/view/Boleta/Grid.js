Ext.define('FV.view.Boleta.Grid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.boletasGrid',
    itemId: 'boleta-panel',
    id: 'boleta-panel',
    store: "sBoleta",
    loadMask: true,
    autoScroll: true,
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
    listeners: {
        'selectionchange': function(view, records) {
            this.down('#delete').setDisabled(!records.length);//Se Habilita el Boton Delete
            //  this.down('#edit').setDisabled(!records.length);//Se Habilita el Boton Delete
        }
    },
    initComponent: function() {
        var proveedores = Ext.create('FV.store.sProveedor', {autoLoad: true});
        var monthsStore = Ext.create('FV.store.sMonths', {autoLoad: true});
        var me = this;
        Ext.applyIf(me, {columns: [
                new Ext.grid.RowNumberer(),
                {
                    header: 'Fecha',
                    dataIndex: 'fecha',
                    xtype: 'datecolumn',
                    format: 'd/m/Y'
                },
                {
                    header: '# de Boleta',
                    dataIndex: 'consec',
                    flex: 1
                },
                {
                    header: 'Entidad',
                    dataIndex: 'Entidad',
                    flex: 1,
                    renderer: this.renderObjectName
                },
                {
                    header: 'Proveedor',
                    dataIndex: 'Proveedor',
                    flex: 1,
                    renderer: this.renderObjectName
                }
            ],
            dockedItems: [{
                    xtype: 'toolbar',
                    items: [
                        {
                            action: 'add',
                            text: 'Adicionar',
                            tooltip: 'Adicionar',
                            iconCls: 'add'
                        },
                        {
                            action: 'remove',
                            itemId: 'delete',
                            text: 'Eliminar',
                            tooltip: 'Eliminar boleta',
                            iconCls: 'remove',
                            disabled: true
                        },
                        '->', {
                            xtype: 'combobox',
                            name: 'combo_proveedor',
                            displayField: 'nombre',
                            valueField: 'id',
                            queryMode: 'local',
                            emptyText: 'Proveedor',
                            hideLabel: true,
                            margins: '0 6 0 0',
                            store: proveedores,
                            id: 'combo_proveedor',
                            flex: 1,
                            allowBlank: true,
                            forceSelection: true,
                            editable: false,
                            listeners: {
                                'select': function(combo, obj) {
                                    me.down('#reporte_boleta').setDisabled(false);
                                    me.down('#reporte_boleta').setTooltip("Ver reporte (" + combo.getRawValue() + ")");
                                }
                            }
                        }, {
                            xtype: 'combobox',
                            name: 'combo_month',
                            displayField: 'name',
                            valueField: 'num',
                            queryMode: 'local',
                            emptyText: 'Mes',
                            hideLabel: true,
                            margins: '0 6 0 0',
                            store: monthsStore,
                            id: 'combo_montH',
                            flex: 1,
                            allowBlank: true,
                            forceSelection: true,
                            editable: false

                        },
                        {
                            xtype: 'numberfield',
                            name: 'year',
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
                            itemId: 'reporte_boleta',
                            tooltip: 'Debe filtrar por proveedor',
                            disabled: true,
                            menu: [{
                                    action: 'preview',
                                    text: 'Vista previa',
                                    iconCls: 'preview'
                                },
                                {
                                    action: 'pdf',
                                    text: 'Generar PDF',
                                    tooltip: 'Generar PDF',
                                    iconCls: 'pdf',
                                    disabled: false
                                }
                                ,
                                {
                                    action: 'excel',
                                    text: 'Generar Excel',
                                    tooltip: 'Generar Excel',
                                    iconCls: 'xls',
                                    disabled: false
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
                }
            ]
        });
        me.callParent();
    },
    renderObjectName: function(obj) {
        return obj.nombre;
    },
    renderObjectTC: function(obj) {
        return obj.tc;
    }
});






