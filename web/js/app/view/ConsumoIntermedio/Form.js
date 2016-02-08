Ext.define('FV.view.ConsumoIntermedio.Form', {
    extend: 'Ext.window.Window',
    alias: 'widget.consumoInterForm',
    title: 'Consumo Intermedio',
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
        var consumoInterStore = Ext.create('FV.store.sConsumoInter', {autoLoad: false});
        consumoInterStore.proxy.url = SITEURL + "/c_consumointer/findbyentidad";
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
                                        id: 'organ__id',
                                        name: 'organ__id',
                                        store: orgStore,
                                        displayField: 'nombre',
                                        valueField: 'id',
                                    }, {
                                        fieldLabel: 'Entidad',
                                        id: 'entidad__id1',
                                        name: 'entidad__id1',
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
                        items: Ext.create('FV.view.ConsumoIntermedio.GridName', {
                            height: 170, disabled: true, store: consumoInterStore
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





