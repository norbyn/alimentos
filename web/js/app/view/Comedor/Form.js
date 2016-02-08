Ext.define('FV.view.Comedor.Form', {
    extend: 'Ext.window.Window',
    alias: 'widget.comedoresWindow',
    title: 'Comedores',
    width: 400,
    height: 400,
    resizable: false,
    modal: true,
    closeAction: 'hide',
    layout: 'fit',
    initComponent: function() {
        var orgStore = Ext.create('FV.store.Organismos', {autoLoad: true});
        var entStore = Ext.create('FV.store.sEntidad', {autoLoad: false});
        entStore.proxy.url = SITEURL + "/entidad/findbyorganismo";
        var comedorStore = Ext.create('FV.store.sComedor', {autoLoad: false});
        comedorStore.proxy.url = SITEURL + "/comedores/findallbyentidad";
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
                                items: [{
                                        fieldLabel: 'Organismo',
                                        id: 'org_id',
                                        name: 'org_id',
                                        store: orgStore,
                                        displayField: 'nombre',
                                        valueField: 'id',
                                    }, {
                                        fieldLabel: 'Entidad',
                                        id: 'entidad_id',
                                        name: 'entidad_id',
                                        store: entStore,
                                        displayField: 'nombre',
                                        valueField: 'id',
                                        disabled: true
                                    }]
                            }
                        ]
                    }, {
                        xtype: 'fieldset',
                        title: 'Asignar Comedores a la Entidad',
                        anchor: '100%',
                        height: 200,
                        items: Ext.create('FV.view.Comedor.GridName', {height: 170, disabled: true, store: comedorStore})

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





