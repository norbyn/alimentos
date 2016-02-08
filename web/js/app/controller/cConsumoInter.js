var year = '%';
var month = '%';
Ext.define('FV.controller.cConsumoInter', {
    extend: 'Ext.app.Controller',
    stores: ["sConsumoInter"],
    views: ['ConsumoIntermedio.Form', 'ConsumoIntermedio.FormName'],
    refs: [
        {ref: 'consumoInterView', selector: 'consumoInterView'},
        {ref: 'consumoInterForm', selector: 'consumoInterForm', autoCreate: true, xtype: 'consumoInterForm'},
        {ref: 'consumoInterGridName', selector: 'consumoInterGridName'},
        {ref: 'consumoInterFormName', selector: 'consumoInterFormName'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'consumoInterView': {
                beforerender: this.loadStore
            },
            'consumoInterForm button[action=accept]': {
                click: this.aceptar
            },
            'consumoInterForm combobox[id=organ__id]': {
                select: this.selectOrganismo
            },
            'consumoInterForm combobox[id=entidad__id1]': {
                select: this.selectEntidad
            },
            'consumoInterFormName combobox[id=proveedor__id]': {
                select: this.selectProveedor
            },
            'consumoInterView button[action=show]': {
                click: this.show
            },
            'consumoInterFormName button[action=create]': {
                click: this.saveConsumoInter
            },
            'consumoInterForm button[action=cancel]': {
                click: this.resetForm
            },
            'consumoInterGridName button[action=showFormName]': {
                click: this.showFormName
            },
            'consumoInterGridName button[action=deleteRow]': {
                click: this.deleteConsumoInter
            },
            'consumoInterGridName': {
                selectionchange: this.select
            },
            'consumoInterView button[action=reporte]': {
                click: this.reporte
            },
            'consumoInterView numberfield': {
                change: this.loadStoreYear
            },
            'consumoInterView combobox[id=combo__month]': {
                select: this.loadStore3
            }
        });
    },
    select: function(selModel, selected) {
        var record = selected[0];
        if (record) {
            this.getConsumoInterGridName().down("button[action=deleteRow]").enable();
        }
        else {
            this.getConsumoInterGridName().down("button[action=deleteRow]").disable();
        }
    },
    /**
     * Aqui vamos a mandar a cargar el store
     * 
     */
    loadStore: function(grid) {
        grid.getStore().load();
    },
    loadStore3: function(combo) {
        var id = combo.getValue();
        var desc = combo.getRawValue();
        if (id) {
            month = id;
            this.getConsumoInterView().getStore().load({
                params: {
                    mes: month,
                    year: year
                },
                callback: function(records, operation, success) {
                    if (success) {
                        // combo.setDisabled(!(records.length > 0));
                    }
                }
            });
        }
    },
    loadStoreYear: function(number) {
        var val = number.getValue();
        if (val) {
            year = val;
            this.getConsumoInterView().getStore().load({
                params: {
                    mes: month,
                    year: year
                },
                callback: function(records, operation, success) {
                    if (success) {
                        // combo.setDisabled(!(records.length > 0));
                    }
                }
            });
        }
    },
    /**
     * Muestra el formulario
     */
    show: function() {
        this.getConsumoInterForm().show();
    },
    showFormName: function() {
        var productosForm = Ext.widget('consumoInterFormName');
    },
    saveConsumoInter: function() {
        var formPanel = this.getConsumoInterForm().down('form'),
                grid = this.getConsumoInterGridName(),
                entStore = formPanel.down('#entidad__id1').getStore(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        var formNamePanel = this.getConsumoInterFormName().down('form'),
                productoStore = formNamePanel.down('#producto__id').getStore(),
                record2 = formNamePanel.getRecord(),
                values2 = formNamePanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
            formNamePanel.getForm().updateRecord(record2);
        } else {//es uno nuevo
            values.Entidad = entStore.getById(values.entidad__id1).data;
            values.Producto = productoStore.getById(values2.producto__id).data;
            values.producto_id = values.Producto.id;
            values.entidad_id = values.Entidad.id;
            values.fecha = new Date();
            values.cant = 0;
            record = Ext.create('FV.model.mConsumoInter', values);
            grid.getStore().add(record);
        }
        this.getConsumoInterFormName().close();
    },
    deleteConsumoInter: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar el elemento seleccionado permanentemente?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getConsumoInterGridName().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getConsumoInterGridName().getStore().remove(record);
                    }
                    break;
                default:
                    break;
            }
        });
    },
    /**
     * Resetea todos los campos del formulario
     * 
     * @return {void}
     */
    resetForm: function() {
        var formPanel = this.getFormPanel(),
                record = formPanel.getRecord();
        formPanel.getForm().reset();
        formPanel.down('#entidad__id1').disable(true);
        this.getConsumoInterGridName().getSelectionModel().deselect(record);
    },
    /**
     * Evento select del combobox de organismos
     * 
     * @param {Ext.form.field.ComboBox} combo
     */
    selectOrganismo: function(combo) {
        var id = combo.getValue();
        this.loadDependantCombo(id, '#entidad__id1', {
            organismo: id
        });
    },
    selectProveedor: function(combo) {
        var id = combo.getValue();
        var formPanel = this.getConsumoInterForm().down('form'),
                entStore = formPanel.down('#entidad__id1').getStore(),
                values = formPanel.getValues()
        values.Entidad = entStore.getById(values.entidad__id1).data;
        var ent = values.Entidad.id;
        this.loadDependantCombo2(id, '#producto__id', {
            proveedor: id,
            entidad: ent
        });
    },
    /**
     * Evento select del combobox de entidades
     * 
     * @param {Ext.form.field.ComboBox} combo
     */
    selectEntidad: function(combo) {
        var id = combo.getValue();
        this.loadConsumoInterStore(id, {
            entidad: id,
            mes: month,
            year: year
        });
    },
    /**
     * Carga en combobox que depende de otro
     * 
     * @param {int} id El valor seleccionado en el combobox1
     * @param {string} combo2Id El id del combobox2 en formato CSS. Ex: '#comboid'
     * @param {json} extraParams Parametros extra para pasar al load del store
     */
    loadDependantCombo: function(id, combo2Id, extraParams) {
        if (id) {
            var combo2 = this.getConsumoInterForm().down(combo2Id),
                    store = combo2.getStore();
            store.load({
                params: extraParams,
                callback: function(records, operation, success) {
                    if (success) {
                        combo2.setDisabled(!(records.length > 0));
                    }
                }
            });
        }
    },
    loadDependantCombo2: function(id, combo2Id, extraParams) {
        if (id) {
            var combo2 = this.getConsumoInterFormName().down(combo2Id),
                    store = combo2.getStore();
            store.load({
                params: extraParams,
                callback: function(records, operation, success) {
                    if (success) {
                        combo2.setDisabled(!(records.length > 0));
                    }
                }
            });
        }
    },
    loadConsumoInterStore: function(id, extraParams) {
        if (id) {
            this.getConsumoInterGridName().getStore().load({
                params: extraParams,
                callback: function(records, operation, success) {
                    if (success) {
                        //this.getComedoresGridName().setDisabled(!(records.length > 0));
                    }
                }
            });
            this.getConsumoInterGridName().setDisabled(false);
        }
    },
    /**
     * Devuelve el formulario para crear nivel de act.
     * 
     * @return {Ext.form.Panel} El formulario
     */
    getFormPanel: function() {
        return this.getConsumoInterForm().down('form');
    },
    aceptar: function() {
        this.getConsumoInterForm().close();
        this.getConsumoInterView().getStore().load({params: {
                mes: month,
                year: year
            }});
    },
    reporte: function(grid) {
        Ext.Ajax.request({
            scope: this,
            params: {
                //username: form.getForm().findField('username').getValue(),
                //password: form.getForm().findField('password').getValue()
            },
            url: SITEURL + '/reportes/consumointer',
            success: function(response, opts) {
                var obj = Ext.decode(response.responseText);
                var myData = Ext.decode(obj.data);
                // Ext.Msg.alert('Error', response.responseText);
                var store = Ext.create('Ext.data.ArrayStore', {
                    fields: Ext.decode(obj.fields),
                    groupField: 'org_nombre',
                    data: myData
                });
                Ext.create('Ext.window.Window', {
                    title: 'ConsumoInter',
                    height: 400,
                    layout: 'fit',
                    iconCls: 'reporte',
                    modal: true,
                    width: 900,
                    dockedItems: [{
                            xtype: 'toolbar',
                            items: [
                                '->',
                                {
                                    action: 'reporte',
                                    text: 'Generar PDF',
                                    tooltip: 'Generar PDF',
                                    iconCls: 'pdf',
                                    disabled: false,
                                    handler: function() {
                                        var uri_string = SITEURL + '/reportes/generar_pdf_consumointer';
                                        window.location.href = uri_string;
                                    }
                                },
                                {
                                    action: 'reporte',
                                    text: 'Generar Excel',
                                    tooltip: 'Generar Excel',
                                    iconCls: 'xls',
                                    disabled: false,
                                    handler: function() {
                                        var uri_string = SITEURL + '/reportes/generar_xls_consumointer';
                                        window.location.href = uri_string;
                                    }
                                }
                            ]
                        }],
                    items: {// Let's put an empty grid in just to illustrate fit layout
                        xtype: 'grid',
                        store: store,
                        stateful: true,
                        stateId: 'stateGrid',
                        columns: Ext.decode(obj.columns)
                                //title: 'Array Grid',
                        ,
                        features: [{
                                id: 'group',
                                ftype: 'groupingsummary',
                                groupHeaderTpl: '{name}',
                                enableGroupingMenu: false
                            }],
                        selModel: {
                            allowDeselect: true
                        },
                        viewConfig: {
                            stripeRows: true
                        }
                    }
                }).show();
            }
        });
    }
});



