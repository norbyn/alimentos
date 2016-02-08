var year = '%';
var month = '%';
Ext.define('FV.controller.cActividadProducto', {
    extend: 'Ext.app.Controller',
    stores: ["sActividadProducto"],
    views: ['ActividadProducto.Form', 'ActividadProducto.FormName'],
    refs: [
        {ref: 'actividadesView', selector: 'actividadesView'},
        {ref: 'actividadesForm', selector: 'actividadesForm', autoCreate: true, xtype: 'actividadesForm'},
        {ref: 'actividadesGridName', selector: 'actividadesGridName'},
        {ref: 'actividadesFormName', selector: 'actividadesFormName'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'actividadesView': {
                beforerender: this.loadStore
            },
            'actividadesForm button[action=accept]': {
                click: this.aceptar
            },
            'actividadesForm combobox[id=proveedor_actividad_id]': {
                select: this.selectProveedor
            },
            'actividadesForm combobox[id=producto_actividad_id]': {
                select: this.selectProducto
            },
            'actividadesView button[action=show]': {
                click: this.show
            },
            'actividadesFormName button[action=create]': {
                click: this.saveActividadProducto
            },
            'actividadesForm button[action=cancel]': {
                click: this.resetForm
            },
            'actividadesGridName button[action=showActivities]': {
                click: this.showActivities
            },
            'actividadesGridName button[action=deleteRow]': {
                click: this.deleteActividadProducto
            },
            'actividadesGridName': {
                selectionchange: this.select
            },
            'actividadesView button[action=reporte]': {
                click: this.reporte
            },
            'actividadesView numberfield': {
                change: this.loadStoreYear
            },
            'actividadesView combobox[id=combo_month_activ]': {
                select: this.loadStore3
            }
        });
    },
    select: function(selModel, selected) {
        var record = selected[0];
        if (record) {
            this.getActividadesGridName().down("button[action=deleteRow]").enable();
        }
        else {
            this.getActividadesGridName().down("button[action=deleteRow]").disable();
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
            this.getActividadesView().getStore().load({
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
            this.getActividadesView().getStore().load({
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
        this.getActividadesForm().show();
    },
    showActivities: function() {
        var activitiesForm = Ext.widget('actividadesFormName');
    },
    saveActividadProducto: function() {
        var formPanel = this.getActividadesForm().down('form'),
                grid = this.getActividadesGridName(),
                productoStore = formPanel.down('#producto_actividad_id').getStore(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        var formNamePanel = this.getActividadesFormName().down('form'),
                actividadStore = formNamePanel.down('#actividades_id').getStore(),
                record2 = formNamePanel.getRecord(),
                values2 = formNamePanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
            formNamePanel.getForm().updateRecord(record2);
        } else {//es uno nuevo
            values.Producto = productoStore.getById(values.producto_actividad_id).data;
            values.Actividad = actividadStore.getById(values2.actividades_id).data;
            values.producto_id = values.Producto.id;
            values.actividad_id = values.Actividad.id;
            values.fecha = new Date();
            values.plan = 0;
            values.actual = 0;
            values.producto_nombre = values.Producto.nombre;
            values.porciento = 0;
            record = Ext.create('FV.model.mActividadProducto', values);
            grid.getStore().add(record);
        }
        this.getActividadesFormName().close();
    },
    deleteActividadProducto: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar la seleccionada permanentemente?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getActividadesGridName().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getActividadesGridName().getStore().remove(record);
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
        formPanel.down('#producto_actividad_id').disable(true);
        this.getActividadesGridName().getSelectionModel().deselect(record);
    },
    /**
     * Evento select del combobox de organismos
     * 
     * @param {Ext.form.field.ComboBox} combo
     */
    selectOrganismo: function(combo) {
        var id = combo.getValue();
        this.loadDependantCombo(id, '#producto_actividad_id', {
            organismo: id
        });
    },
    selectProveedor: function(combo) {
        var id = combo.getValue();
        this.loadDependantCombo2(id, '#producto_actividad_id', {
            proveedor: id
        });
    },
    /**
     * Evento select del combobox de productos
     * 
     * @param {Ext.form.field.ComboBox} combo
     */
    selectProducto: function(combo) {
        var id = combo.getValue();
        this.loadActividadProductoStore(id, {
            producto_id: id, mes: month,
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
            var combo2 = this.getActividadesForm().down(combo2Id),
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
            var combo2 = this.getActividadesForm().down(combo2Id),
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
    loadActividadProductoStore: function(id, extraParams) {
        if (id) {
            this.getActividadesGridName().getStore().load({
                params: extraParams,
                callback: function(records, operation, success) {
                    if (success) {
                        //this.getComedoresGridName().setDisabled(!(records.length > 0));
                    }
                }
            });
            this.getActividadesGridName().setDisabled(false);
        }
    },
    /**
     * Devuelve el formulario para crear nivel de act.
     * 
     * @return {Ext.form.Panel} El formulario
     */
    getFormPanel: function() {
        return this.getActividadesForm().down('form');
    },
    aceptar: function() {
        this.getActividadesForm().close();
        this.getActividadesView().getStore().load({params: {
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
            url: SITEURL + '/reportes/actividades',
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
                    title: 'ActividadProducto',
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
                                        var uri_string = SITEURL + '/reportes/generar_pdf_actividades';
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
                                        var uri_string = SITEURL + '/reportes/generar_xls_actividades';
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



