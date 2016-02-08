Ext.define('FV.view.BD.Form', {
    extend: 'Ext.window.Window',
    alias: 'widget.baseDatosWindow',
    title: 'Base de Datos',
    width: 600,
    height: 290,
    resizable:false,
    modal:true,
    closeAction: 'hide',
    layout: 'fit',
    initComponent: function() {
        var orgStore = Ext.create('FV.store.Organismos', {autoLoad: true});
        var entStore = Ext.create('FV.store.sEntidad', {autoLoad: false});
        entStore.proxy.url = SITEURL + "/entidad/findbyorganismo";
        var comedorStore = Ext.create('FV.store.sComedor', {autoLoad: false});
        comedorStore.proxy.url = SITEURL + "/comedores/findbyentidad";
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
                                        id: 'or_id',
                                        name: 'or_id',
                                        store: orgStore,
                                        displayField: 'nombre',
                                        valueField: 'id',
                                    }, {
                                        fieldLabel: 'Entidad',
                                        id: 'entidad_id2',
                                        name: 'entidad_id2',
                                        store: entStore,
                                        displayField: 'nombre',
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
                                        fieldLabel: 'Comedor',
                                        id: 'comedor_id',
                                        name: 'comedor_id',
                                        queryMode: 'local',
                                        store: comedorStore,
                                        displayField: 'nombre',
                                        editable: false,
                                        valueField: 'id',
                                        disabled: true,
                                        forceSelection: true,
                                        anchor: '100%'
                                    }
                                ]
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
                                columnWidth: .5,
                                layout: 'anchor',
                                items: [
                                    {
                                        xtype: 'textfield',
                                        name: 'fisico',
                                        fieldLabel: 'Físicos',
                                        anchor: '96%'
                                    }
                                ]
                            },
                            {
                                xtype: 'container',
                                columnWidth: .5,
                                layout: 'anchor',
                                items: [
                                    {
                                        xtype: 'textfield',
                                        name: 'nivel_act',
                                        fieldLabel: 'Nivel de Actividad',
                                        anchor: '100%'
                                    }
                                ]
                            }
                        ]
                    },
                    {
                        xtype: 'fieldset',
                        title: 'Eventos',
                        anchor: '100%',
                        layout: 'column',
                        defaults: {
                            xtype: 'container',
                            columnWidth: .333333,
                            layout: 'anchor'
                        },
                        items: [
                            {
                                items: [
                                    {
                                        xtype: 'textfield',
                                        name: 'almuerzo_evt',
                                        fieldLabel: 'Almuerzo',
                                        anchor: '96%'
                                    }
                                ]
                            },
                            {
                                items: [
                                    {
                                        xtype: 'textfield',
                                        name: 'merienda_evt',
                                        fieldLabel: 'Merienda',
                                        anchor: '96%'
                                    }
                                ]
                            },
                            {
                                items: [
                                    {
                                        xtype: 'textfield',
                                        name: 'comida_evt',
                                        fieldLabel: 'Comida',
                                        anchor: '100%'
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
            }]
        this.callParent();
    }
});





