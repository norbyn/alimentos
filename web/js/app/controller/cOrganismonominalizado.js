var year = '%';
var month = '%';
Ext.define('FV.controller.cOrganismonominalizado', {
    extend: 'Ext.app.Controller',
    stores: ["sOrganismonominalizado"],
    views: ['Organismonominalizado.Form', 'Organismonominalizado.FormName'],
    refs: [
        {ref: 'nominalizadoView', selector: 'nominalizadoView'},
        {ref: 'nominalizadoForm', selector: 'nominalizadoForm', autoCreate: true, xtype: 'nominalizadoForm'},
        {ref: 'nominalizadoGridName', selector: 'nominalizadoGridName'},
        {ref: 'nominalizadoFormName', selector: 'nominalizadoFormName'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'nominalizadoView': {
                beforerender: this.loadStore
            },
            'nominalizadoForm button[action=accept]': {
                click: this.aceptar
            },
            'nominalizadoForm combobox[id=id_organismo]': {
                select: this.selectOrganismo
            },
            'nominalizadoForm combobox[id=id_entidad]': {
                select: this.selectEntidad
            },
            'nominalizadoFormName combobox[id=proveedor_id]': {
                select: this.selectProveedor
            },
            'nominalizadoView button[action=show]': {
                click: this.show
            },
            'nominalizadoFormName button[action=create]': {
                click: this.saveNominalizado
            },
            'nominalizadoForm button[action=cancel]': {
                click: this.resetForm
            },
            'nominalizadoGridName button[action=showFormName]': {
                click: this.showFormName
            },
            'nominalizadoGridName button[action=deleteRow]': {
                click: this.deleteNominalizado
            },
            'nominalizadoGridName': {
                selectionchange: this.select
            },
            'nominalizadoView button[action=reporte]': {
                click: this.reporte
            },
            'nominalizadoView numberfield': {
                change: this.loadStoreYear
            },
            'nominalizadoView combobox[id=combo_montH2]': {
                select: this.loadStore3
            }
        });
    },
    select: function(selModel, selected) {
        var record = selected[0];
        if (record) {
            this.getNominalizadoGridName().down("button[action=deleteRow]").enable();
        }
        else {
            this.getNominalizadoGridName().down("button[action=deleteRow]").disable();
        }
    },
    /**
     * Aqui vamos a mandar a cargar el store
     * 
     * @param FV.view.NivelAct.Grid grid
     */
    loadStore: function(grid) {
        grid.getStore().load();
    },
    /**
     * Muestra el formulario
     */
    show: function() {
        this.getNominalizadoForm().show();
    },
    showFormName: function() {
        var productosForm = Ext.widget('nominalizadoFormName');
    },
    saveNominalizado: function() {
        var formPanel = this.getNominalizadoForm().down('form'),
                grid = this.getNominalizadoGridName(),
                entStore = formPanel.down('#id_entidad').getStore(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        var formNamePanel = this.getNominalizadoFormName().down('form'),
                productoStore = formNamePanel.down('#producto_id').getStore(),
                record2 = formNamePanel.getRecord(),
                values2 = formNamePanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
            formNamePanel.getForm().updateRecord(record2);
        } else {//es uno nuevo
            values.Entidad = entStore.getById(values.id_entidad).data;
            values.Producto = productoStore.getById(values2.producto_id).data;
            values.producto_id = values.Producto.id;
            values.entidad_id = values.Entidad.id;
            values.fecha = new Date();
            values.ctd = 0;
            record = Ext.create('FV.model.mOrganismonominalizado', values);
            grid.getStore().add(record);
        }
        this.getNominalizadoFormName().close();
    },
    deleteNominalizado: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar el registro seleccionado permanentemente?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getNominalizadoGridName().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getNominalizadoGridName().getStore().remove(record);
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
        formPanel.down('#id_entidad').disable(true);
        this.getNominalizadoGridName().getSelectionModel().deselect(record);
    },
    /**
     * Evento select del combobox de organismos
     * 
     * @param {Ext.form.field.ComboBox} combo
     */
    selectOrganismo: function(combo) {
        var id = combo.getValue();
        this.loadDependantCombo(id, '#id_entidad', {
            organismo: id
        });
    },
    selectProveedor: function(combo) {
        var id = combo.getValue();
        var formPanel = this.getNominalizadoForm().down('form'),
                entStore = formPanel.down('#id_entidad').getStore(),
                values = formPanel.getValues();
        values.Entidad = entStore.getById(values.id_entidad).data;
        var ent = values.Entidad.id;
        this.loadDependantCombo2(id, '#producto_id', {
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
        this.loadNominalizadoStore(id, {
            entidad: id, mes: month,
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
            var combo2 = this.getNominalizadoForm().down(combo2Id),
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
            var combo2 = this.getNominalizadoFormName().down(combo2Id),
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
    loadNominalizadoStore: function(id, extraParams) {
        if (id) {
            this.getNominalizadoGridName().getStore().load({
                params: extraParams,
                callback: function(records, operation, success) {
                    if (success) {
                        //this.getComedoresGridName().setDisabled(!(records.length > 0));
                    }
                }
            });
            this.getNominalizadoGridName().setDisabled(false);
        }
    },
    /**
     * Devuelve el formulario para crear nivel de act.
     * 
     * @return {Ext.form.Panel} El formulario
     */
    getFormPanel: function() {
        return this.getNominalizadoForm().down('form');
    },
    aceptar: function() {
        this.getNominalizadoForm().close();
        this.getNominalizadoView().getStore().load({params: {
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
            url: SITEURL + '/reportes/nominalizados_y_otros',
            success: function(response, opts) {
                var obj = Ext.decode(response.responseText);
                var myData = Ext.decode(obj.data);
                // Ext.Msg.alert('Error', response.responseText);
                var store = Ext.create('Ext.data.ArrayStore', {
                    fields: Ext.decode(obj.fields),
                    //groupField: 'nombre_producto',
                    data: myData
                });
                Ext.create('Ext.window.Window', {
                    title: 'Organismos Nominalizados',
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
                                    text: 'Generar PDF',
                                    tooltip: 'Generar PDF',
                                    iconCls: 'pdf',
                                    disabled: false,
                                    handler: function() {
                                        var uri_string = SITEURL + '/reportes/generar_pdf_nominalizados';
                                        window.location.href = uri_string;
                                    }
                                },
                                {
                                    text: 'Generar Excel',
                                    tooltip: 'Generar Excel',
                                    iconCls: 'xls',
                                    disabled: false,
                                    handler: function() {
                                        var uri_string = SITEURL + '/reportes/generar_xls_nominalizados';
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
    },
    loadStoreYear: function(number) {
        var val = number.getValue();
        if (val) {
            year = val;
            this.getNominalizadoView().getStore().load({
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
    loadStore3: function(combo) {
        var id = combo.getValue();
        var desc = combo.getRawValue();
        if (id) {
            month = id;
            this.getNominalizadoView().getStore().load({
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
    }
});


