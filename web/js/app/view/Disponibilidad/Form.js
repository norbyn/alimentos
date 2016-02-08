Ext.define('FV.view.Disponibilidad.Form', {
    extend: 'Ext.window.Window',
    alias: 'widget.disponibilidadWindow',
    title: 'Disponibilidad',
    width: 250,
    height: 260,
    resizable: false,
    modal: true,
    closeAction: 'hide',
    layout: 'fit',
    initComponent: function() {
        var proveedorStore = Ext.create('FV.store.sProveedor', {autoLoad: true});
        var productoStore = Ext.create('FV.store.sProducto', {autoLoad: false});
        productoStore.proxy.url = SITEURL + "/producto/findbyproveedor2";
        this.items = [
            {
                xtype: 'form',
                padding: 10,
                frame: true,
                defaultType: 'textfield',
                fieldDefaults: {
                    labelAlign: 'top',
                    msgTarget: 'side'
                },
                items: [
                    {
                        name: 'id',
                        xtype: 'hidden'
                    },
                    {
                        xtype: 'container',
                        anchor: '100%',
                        layout: 'column',
                        items: [
                            {
                                xtype: 'container',
                                columnWidth: 1,
                                layout: 'anchor',
                                defaults: {
                                    xtype: 'combobox',
                                    forceSelection: true,
                                    editable: false,
                                    queryMode: 'local',
                                    anchor: '96%'
                                },
                                items: [{
                                        xtype: 'combobox',
                                        forceSelection: true,
                                        fieldLabel: 'Proveedor',
                                        editable: false,
                                        queryMode: 'local',
                                        anchor: '96%',
                                        id: 'proveed_id',
                                        name: 'proveed_id',
                                        store: proveedorStore,
                                        displayField: 'nombre',
                                        valueField: 'id'
                                    },
                                    {
                                        xtype: 'combobox',
                                        forceSelection: true,
                                        fieldLabel: 'Producto',
                                        editable: false,
                                        queryMode: 'local',
                                        anchor: '96%',
                                        id: 'produc_id',
                                        name: 'produc_id',
                                        store: productoStore,
                                        displayField: 'nombre',
                                        valueField: 'id',
                                        disabled: true
                                    }]
                            }
                        ]
                    },
                    {
                        xtype: 'container',
                        anchor: '100%',
                        layout: 'column',
                        items: [
                            {
                                xtype: 'container',
                                columnWidth: 1,
                                layout: 'anchor',
                                items: [
                                    {
                                        xtype: 'numberfield',
                                        name: 'saldo',
                                        fieldLabel: 'Disponibilidad',
                                        decimalPrecision: 4,
                                        anchor: '96%'
                                    },
                                    {
                                        xtype: 'datefield',
                                        name: 'fecha',
                                        fieldLabel: 'Fecha',
                                        format: 'Y-m-d',
                                        anchor: '100%',
                                        value: new Date()
                                    }
                                ]
                            }
                        ]
                    }
                ]
            }
        ];
        this.buttons = [{
                text: 'Aceptar',
                action: 'create'
            }, {
                text: 'Cancelar',
                scope: this,
                handler: this.close
            }];
        this.callParent();
    }
});





