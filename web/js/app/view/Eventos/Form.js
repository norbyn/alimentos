Ext.define('FV.view.Eventos.Form', {
    extend: 'Ext.window.Window',
    alias: 'widget.eventosForm',
    title: 'Evento',
    width: 600,
    height: 240,
    resizable: false,
    modal: true,
    closeAction: 'hide',
    layout: 'fit',
    initComponent: function() {
        var orgStore = Ext.create('FV.store.Organismos', {autoLoad: true});
        var entStore = Ext.create('FV.store.sEntidad', {autoLoad: false});
        entStore.proxy.url = SITEURL + "/entidad/findbyorganismo";
        var proveedorStore = Ext.create('FV.store.sProveedor', {autoLoad: true});
        var productoStore = Ext.create('FV.store.sProducto', {autoLoad: true});
        productoStore.proxy.url = SITEURL + "/producto/findbyproveedor";
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
                                columnWidth: .5,
                                layout: 'anchor',
                                defaults: {
                                    xtype: 'combobox',
                                    forceSelection: true,
                                    editable: false,
                                    queryMode: 'local',
                                    anchor: '96%'
                                },
                                items: [
                                    {
                                        xtype: 'combobox',
                                        fieldLabel: 'Organismo',
                                        id: 'ev_organismo_id',
                                        name: 'ev_organismo_id',
                                        queryMode: 'local',
                                        store: orgStore,
                                        displayField: 'nombre',
                                        editable: false,
                                        valueField: 'id',
                                        forceSelection: true
                                    },
                                    {
                                        xtype: 'combobox',
                                        fieldLabel: 'Entidad',
                                        id: 'e_id',
                                        name: 'entidad_id',
                                        queryMode: 'local',
                                        store: entStore,
                                        displayField: 'nombre',
                                        editable: false,
                                        valueField: 'id',
                                        disabled: true
                                    }]
                            }, {
                                xtype: 'container',
                                columnWidth: .5,
                                layout: 'anchor',
                                items: [
                                    {
                                        xtype: 'combobox',
                                        forceSelection: true,
                                        fieldLabel: 'Proveedor',
                                        editable: false,
                                        queryMode: 'local',
                                        anchor: '96%',
                                        id: 'ev_proveedor_id',
                                        name: 'ev_proveedor_id',
                                        store: proveedorStore,
                                        displayField: 'nombre',
                                        valueField: 'id',
                                        disabled: true
                                    },
                                    {
                                        xtype: 'combobox',
                                        fieldLabel: 'Producto',
                                        id: 'p_id',
                                        name: 'producto_id',
                                        queryMode: 'local',
                                        store: productoStore,
                                        displayField: 'nombre',
                                        editable: false,
                                        valueField: 'id',
                                        anchor: '100%',
                                        disabled: true
                                    }
                                ]
                            }
                        ]
                    },
                    {
                        xtype: 'fieldset',
                        title: '',
                        anchor: '100%',
                        layout: 'column',
                        defaults: {
                            xtype: 'container',
                            columnWidth: .33,
                            layout: 'anchor'
                        },
                        items: [
                            {
                                items: [
                                    {
                                        xtype: 'textfield',
                                        name: 'concepto',
                                        fieldLabel: 'Concepto',
                                        anchor: '96%'
                                    }
                                ]
                            },
                            {
                                items: [
                                    {
                                        xtype: 'numberfield',
                                        name: 'cant',
                                        fieldLabel: 'Cantidad',
                                        decimalPrecision: 4,
                                        anchor: '96%'
                                    }
                                ]
                            },
                            {
                                items: [
                                    {
                                        xtype: 'numberfield',
                                        name: 'ajuste',
                                        fieldLabel: 'Ajuste',
                                        decimalPrecision: 0,
                                        anchor: '96%',
                                        hidden: true
                                    }
                                ]
                            }
                            ,
                            {
                                items: [
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
                action: 'add'
            }, {
                text: 'Cancelar',
                scope: this,
                handler: this.close
            }];
        this.callParent();
    }
});





