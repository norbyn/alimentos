Ext.define('FV.view.Boleta.Form', {
    extend: 'Ext.window.Window',
    alias: 'widget.boletasWindow',
    title: 'Control de reservas',
    width: 500,
    height: 270,
    resizable: false,
    modal: true,
    closeAction: 'hide',
    layout: 'fit',
    initComponent: function() {
        var orgStore = Ext.create('FV.store.Organismos', {autoLoad: true});
        var entStore = Ext.create('FV.store.sEntidad', {autoLoad: false});
        entStore.proxy.url = SITEURL + "/entidad/findbyorganismo";
        var proveedorStore = Ext.create('FV.store.sProveedor', {autoLoad: true});
        this.items = [
            {
                xtype: 'form',
                padding: 5,
                frame: true,
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
                        layout: 'fit',
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
                                        fieldLabel: 'Organismo',
                                        id: 'orgid',
                                        name: 'orgid',
                                        store: orgStore,
                                        displayField: 'nombre',
                                        valueField: 'id'
                                    }, {
                                        fieldLabel: 'Entidad',
                                        id: 'entidadid',
                                        name: 'entidadid',
                                        store: entStore,
                                        displayField: 'nombre',
                                        valueField: 'id',
                                        disabled: true
                                    },
                                    {
                                        fieldLabel: 'Proveedor',
                                        id: 'proveedorId',
                                        name: 'proveedorId',
                                        store: proveedorStore,
                                        displayField: 'nombre',
                                        valueField: 'id',
                                        disabled: true
                                    },
                                    {
                                        xtype: 'fieldset',
                                        anchor: '100%',
                                        layout: 'column',
                                        defaults: {
                                            xtype: 'container',
                                            columnWidth: .5,
                                            layout: 'anchor'
                                        },
                                        items: [
                                            {
                                                items: [
                                                    {
                                                        xtype: 'textfield',
                                                        name: 'consec',
                                                        fieldLabel: '# de Boleta',
                                                        anchor: '96%',
                                                        allowBlank: false,
                                                        readOnly: true,
                                                        id: 'consecId'
                                                    }
                                                ]
                                            },
                                            {
                                                items: [
                                                    {
                                                        xtype: 'datefield',
                                                        name: 'fecha',
                                                        fieldLabel: 'Fecha',
                                                        format: 'Y-m-d',
                                                        anchor: '100%',
                                                        editable: false
                                                    }
                                                ]
                                            }
                                        ]
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
                action: 'accept'
            }, {
                text: 'Cancelar',
                scope: this,
                handler: this.close
            }];
        this.callParent();
    }

});





