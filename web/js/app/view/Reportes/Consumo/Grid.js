Ext.define('FV.view.Reportes.Consumo.Grid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.consumoGrid',
    store: "Reportes.Consumo",
    loadMask: true,
    border: false,
    height: '540',
    selModel: {
        allowDeselect: true
    },
    defaults: {
        flex: 1,
        sortable: false
    },
    initComponent: function() {
        var me = this;
        Ext.applyIf(me, {columns: [
                new Ext.grid.RowNumberer(),
                {header: 'REEUP', width: 55, dataIndex: '', draggable: false, menuDisabled: true, resizable: false},
                {header: 'ENTIDAD/COMEDOR', width: 200, dataIndex: '', draggable: false, menuDisabled: true, resizable: false},
                {header: 'EMPA', draggable: false, menuDisabled: true, resizable: false,
                    columns: [
                        {header: 'AZUCAR<br>CRUDO', width: 55, dataIndex: '', menuDisabled: true, draggable: false, resizable: false},
                        {header: 'AZUCAR<br>REFINO', width: 55, menuDisabled: true, draggable: false, resizable: false},
                        {header: 'SAL', width: 55, menuDisabled: true, draggable: false, resizable: false},
                        {header: 'ACEITE', width: 55, menuDisabled: true, draggable: false, resizable: false},
                        {header: 'HARINA<br>DE MAIZ', width: 55, menuDisabled: true, dataIndex: '', draggable: false, resizable: false}
                    ]
                },
                {header: 'AVICOLA', draggable: false, resizable: false,
                    columns: [
                        {header: 'HUEVO<br>DESHIDRATADO', width: 90, dataIndex: '', menuDisabled: true, draggable: false, resizable: false},
                        {header: 'HUEVO<br>FRESCO', width: 55, menuDisabled: true, draggable: false, resizable: false
                        }
                    ]
                }
            ],
            dockedItems: [{
                    xtype: 'toolbar',
                    dock: 'top',
                    items: [{
                            action: 'exportar',
                            text: 'Exportar',
                            tooltip: 'Exportar datos',
                            iconCls: 'exportar',
                            disabled: true
                        }
                    ]
                },
                {
                    xtype: 'pagingtoolbar', //Barra Paginadora al fondo del Grid
                    dock: 'bottom',
                    displayInfo: true,
                    // pageSize: 15,
                    store: me.store,
                    beforePageText: 'Página',
                    afterPageText: 'de {0}',
                    displayMsg: 'Mostrando {0} - {1} de {2}',
                    emptyMsg: ""
                }
            ]

        });
        me.callParent(arguments);
        me.store.load({//Cargamos el Store, al crear la ventana
            params: {
                start: 0,
                limit: 100 //Muestra hasta 100 Registros Maximo
            }
        });
    }
});



