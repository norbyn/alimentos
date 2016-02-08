Ext.define('FV.view.ActividadProducto.Form', {
    extend: 'Ext.window.Window',
    alias: 'widget.actividadesForm',
    title: 'Actividades',
    width: 500,
    height: 450,
    resizable: false,
    modal: true,
    closeAction: 'hide',
    layout: 'fit',
    initComponent: function() {
        var proveedorStore = Ext.create('FV.store.sProveedor', {autoLoad: true});
        var productoStore = Ext.create('FV.store.sProducto', {autoLoad: false});
        productoStore.proxy.url = SITEURL + "/producto/findbyproveedor";
        var actividadesStore = Ext.create('FV.store.sActividadProducto', {autoLoad: false});
        actividadesStore.proxy.url = SITEURL + "/c_actividadproducto/findbyproduct";
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
                                items: [{
                                        fieldLabel: 'Proveedor',
                                        id: 'proveedor_actividad_id',
                                        name: 'proveedor_actividad_id',
                                        store: proveedorStore,
                                        displayField: 'nombre',
                                        valueField: 'id'
                                    }, {
                                        fieldLabel: 'Producto',
                                        id: 'producto_actividad_id',
                                        name: 'producto_actividad_id',
                                        store: productoStore,
                                        displayField: 'nombre',
                                        valueField: 'id',
                                        disabled: true
                                    }]
                            }
                        ]
                    },
                    {
                        xtype: 'fieldset',
                        title: 'Actividades',
                        anchor: '100%',
                        height: 270,
                        items: Ext.create('FV.view.ActividadProducto.GridName', {
                            height: 250, disabled: true, store: actividadesStore
                        })

                    }
                ]
            }
        ];
        this.buttons = [{
                text: 'Aceptar',
                action: 'accept'
            }, {
                text: 'Cancelar',
                scope: this,
                handler: this.close
            }]
        this.callParent();
    }
});





