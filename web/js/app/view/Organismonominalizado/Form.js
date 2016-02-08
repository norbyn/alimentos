Ext.define('FV.view.Organismonominalizado.Form', {
    extend: 'Ext.window.Window',
    alias: 'widget.nominalizadoForm',
    title: 'Nominalizados',
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
        var nominalizadoStore = Ext.create('FV.store.sOrganismonominalizado', {autoLoad: false});
        nominalizadoStore.proxy.url = SITEURL + "/organismonominalizado/findbyentidad";
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
                                        id: 'id_organismo',
                                        name: 'id_organismo',
                                        store: orgStore,
                                        displayField: 'nombre',
                                        valueField: 'id'
                                    }, {
                                        fieldLabel: 'Entidad',
                                        id: 'id_entidad',
                                        name: 'id_entidad',
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
                        items: Ext.create('FV.view.Organismonominalizado.GridName', {
                            height: 170, disabled: true, store: nominalizadoStore
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





