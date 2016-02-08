var year = '%';
var month = '%';
Ext.define('FV.controller.cInventario', {
    extend: 'Ext.app.Controller',
    stores: ["sInventario"],
    views: ['Inventario.Form', 'Inventario.FormName'],
    refs: [
        {ref: 'inventarioView', selector: 'inventarioView'},
        {ref: 'inventarioForm', selector: 'inventarioForm', autoCreate: true, xtype: 'inventarioForm'},
        {ref: 'inventariosGridName', selector: 'inventariosGridName'},
        {ref: 'inventarioFormName', selector: 'inventarioFormName'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'inventarioView': {
                beforerender: this.loadStore
            },
            'inventarioForm button[action=accept]': {
                click: this.aceptar
            },
            'inventarioForm combobox[id=organ_id]': {
                select: this.selectOrganismo
            },
            'inventarioForm combobox[id=entidad_id1]': {
                select: this.selectEntidad
            },
            'inventarioFormName combobox[id=proveedor_id]': {
                select: this.selectProveedor
            },
            'inventarioView button[action=show]': {
                click: this.show
            },
            'inventarioFormName button[action=create]': {
                click: this.saveInventario
            },
            'inventarioForm button[action=cancel]': {
                click: this.resetForm
            },
            'inventariosGridName button[action=showFormName]': {
                click: this.showFormName
            },
            'inventariosGridName button[action=deleteRow]': {
                click: this.deleteInventario
            },
            'inventariosGridName': {
                selectionchange: this.select
            },
            'inventarioView button[action=reporte]': {
                click: this.reporte
            },
            'inventarioView numberfield': {
                change: this.loadStoreYear
            },
            'inventarioView combobox[id=combo_month]': {
                select: this.loadStore3
            }
        });
    },
    select: function(selModel, selected) {
        var record = selected[0];
        if (record) {
            this.getInventariosGridName().down("button[action=deleteRow]").enable();
        }
        else {
            this.getInventariosGridName().down("button[action=deleteRow]").disable();
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
            this.getInventarioView().getStore().load({
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
            this.getInventarioView().getStore().load({
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
        this.getInventarioForm().show();
    },
    showFormName: function() {
        var productosForm = Ext.widget('inventarioFormName');
    },
    saveInventario: function() {
        var formPanel = this.getInventarioForm().down('form'),
                grid = this.getInventariosGridName(),
                entStore = formPanel.down('#entidad_id1').getStore(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        var formNamePanel = this.getInventarioFormName().down('form'),
                productoStore = formNamePanel.down('#producto_id').getStore(),
                record2 = formNamePanel.getRecord(),
                values2 = formNamePanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
            formNamePanel.getForm().updateRecord(record2);
        } else {//es uno nuevo
            values.Entidad = entStore.getById(values.entidad_id1).data;
            values.Producto = productoStore.getById(values2.producto_id).data;
            values.producto_id = values.Producto.id;
            values.entidad_id = values.Entidad.id;
            values.fecha = new Date();
            values.cant = 0;
            record = Ext.create('FV.model.mInventario', values);
            grid.getStore().add(record);
        }
        this.getInventarioFormName().close();
    },
    deleteInventario: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar el inventario seleccionado permanentemente?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getInventariosGridName().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getInventariosGridName().getStore().remove(record);
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
        formPanel.down('#entidad_id1').disable(true);
        this.getInventariosGridName().getSelectionModel().deselect(record);
    },
    /**
     * Evento select del combobox de organismos
     * 
     * @param {Ext.form.field.ComboBox} combo
     */
    selectOrganismo: function(combo) {
        var id = combo.getValue();
        this.loadDependantCombo(id, '#entidad_id1', {
            organismo: id
        });
    },
    selectProveedor: function(combo) {
        var id = combo.getValue();
        var formPanel = this.getInventarioForm().down('form'),
                entStore = formPanel.down('#entidad_id1').getStore(),
                values = formPanel.getValues();
        values.Entidad = entStore.getById(values.entidad_id1).data;
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
        this.loadInventarioStore(id, {
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
            var combo2 = this.getInventarioForm().down(combo2Id),
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
            var combo2 = this.getInventarioFormName().down(combo2Id),
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
    loadInventarioStore: function(id, extraParams) {
        if (id) {
            this.getInventariosGridName().getStore().load({
                params: extraParams,
                callback: function(records, operation, success) {
                    if (success) {
                        //this.getComedoresGridName().setDisabled(!(records.length > 0));
                    }
                }
            });
            this.getInventariosGridName().setDisabled(false);
        }
    },
    /**
     * Devuelve el formulario para crear nivel de act.
     * 
     * @return {Ext.form.Panel} El formulario
     */
    getFormPanel: function() {
        return this.getInventarioForm().down('form');
    },
    aceptar: function() {
        this.getInventarioForm().close();
        this.getInventarioView().getStore().load({params: {
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
            url: SITEURL + '/reportes/inventario',
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
                    title: 'Inventario',
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
                                        var uri_string = SITEURL + '/reportes/generar_pdf_inventario';
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
                                        var uri_string = SITEURL + '/reportes/generar_xls_inventario';
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



