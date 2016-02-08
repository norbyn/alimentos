Ext.define('FV.view.NivelAct.Form', {
    extend: 'Ext.window.Window',
    alias: 'widget.nivelactWindow',
    title: 'Nivel de Actividad',
    width: 600,
    height: 310,
    resizable: false,
    modal: true,
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
                                        valueField: 'id'
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
                                        fieldLabel: 'Destino',
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
                                        xtype: 'numberfield',
                                        name: 'fisico',
                                        fieldLabel: 'Nivel de Act. Plan',
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
                                        xtype: 'numberfield',
                                        name: 'nivel_act',
                                        fieldLabel: 'Nivel de Act. Real',
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
                        id: 'event_container',
                        disabled: true,
                        defaults: {
                            xtype: 'container',
                            columnWidth: .333333,
                            layout: 'anchor'
                        },
                        items: [
                            {
                                items: [
                                    {
                                        xtype: 'numberfield',
                                        name: 'almuerzo_evt',
                                        fieldLabel: 'Almuerzo',
                                        anchor: '96%',
                                        minValue: 0,
                                        value: 0
                                    }
                                ]
                            },
                            {
                                items: [
                                    {
                                        xtype: 'numberfield',
                                        name: 'merienda_evt',
                                        fieldLabel: 'Merienda',
                                        anchor: '96%',
                                        minValue: 0,
                                        value: 0
                                    }
                                ]
                            },
                            {
                                items: [
                                    {
                                        xtype: 'numberfield',
                                        name: 'comida_evt',
                                        fieldLabel: 'Comida',
                                        anchor: '100%',
                                        minValue: 0,
                                        value: 0
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
                text: 'Cerrar',
                scope: this,
                handler: this.close
            }]
        this.callParent();
    }
});





