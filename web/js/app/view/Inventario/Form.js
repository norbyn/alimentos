Ext.define('FV.view.Inventario.Form', {
    extend: 'Ext.window.Window',
    alias: 'widget.inventarioForm',
    title: 'Inventario',
    width: 500,
    height: 390,
    resizable: false,
    modal: true,
    closeAction: 'hide',
    layout: 'fit',
    initComponent: function() {
        var orgStore = Ext.create('FV.store.Organismos', {autoLoad: true});
        var entStore = Ext.create('FV.store.sEntidad', {autoLoad: false});
        entStore.proxy.url = SITEURL + "/entidad/findbyorganismo";
        var inventarioStore = Ext.create('FV.store.sInventario', {autoLoad: false});
        inventarioStore.proxy.url = SITEURL + "/inventarioc/findbyentidad";
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
                                        fieldLabel: 'Organismo',
                                        id: 'organ_id',
                                        name: 'organ_id',
                                        store: orgStore,
                                        displayField: 'nombre',
                                        valueField: 'id'
                                    }, {
                                        fieldLabel: 'Entidad',
                                        id: 'entidad_id1',
                                        name: 'entidad_id1',
                                        store: entStore,
                                        displayField: 'nombre',
                                        valueField: 'id',
                                        disabled: true
                                    }]
                            }
                        ]
                    },
                    {
                        xtype: 'fieldset',
                        title: 'Productos',
                        anchor: '100%',
                        height: 200,
                        items: Ext.create('FV.view.Inventario.GridName', {
                            height: 170, disabled: true, store: inventarioStore
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
            }];
        this.callParent();
    }
});





