var month = '%';
var month_desc = '%';
var year = '%';
Ext.define('FV.controller.cDisponibilidad', {
    extend: 'Ext.app.Controller',
    stores: ["sDisponibilidad"],
    views: ['Disponibilidad.Form'],
    refs: [
        {ref: 'disponibilidadGrid', selector: 'disponibilidadGrid'},
        {
            ref: 'disponibilidadWindow',
            selector: 'disponibilidadWindow',
            autoCreate: true,
            xtype: 'disponibilidadWindow'
        }
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'disponibilidadGrid': {
                beforerender: this.loadStore
            },
            'disponibilidadGrid button[action=actEditar]': {
                click: this.Editar
            },
            'disponibilidadGrid button[action=delete]': {
                click: this.delete
            },
            'disponibilidadGrid combobox[id=combo_month2]': {
                select: this.loadStoreMonth
            },
            'disponibilidadGrid numberfield': {
                change: this.loadStoreYear
            },
            'disponibilidadWindow combobox[id=or_id]': {
                select: this.selectOrganismo
            },
            'disponibilidadGrid button[action=add]': {
                click: this.addDisponibilidad
            },
            'disponibilidadWindow button[action=create]': {
                click: this.saveDisponibilidad
            },
            'disponibilidadWindow button[action=cancel]': {
                click: this.resetForm
            },
            'disponibilidadWindow combobox[id=proveed_id]': {
                select: this.selectProveedor
            }
        });
    },
    loadStoreMonth: function(combo) {
        var id = combo.getValue();
        var desc = combo.getRawValue();
        if (id) {
            month = id;
            month_desc = desc;
            this.getDisponibilidadGrid().getStore().load({
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
            this.getDisponibilidadGrid().getStore().load({
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
    Editar: function(grid, record) {
        records = this.getDisponibilidadGrid().getSelectionModel().getSelection();
        if (records.length > 0) {
            var window = this.getDisponibilidadWindow();
            window.show();
            var EditForm = window.down('form');
            var record = records[0];
            EditForm.loadRecord(record);

        }
    },
    delete: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar el registro permanentemente?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getDisponibilidadGrid().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getDisponibilidadGrid().getStore().remove(record);
                    }
                    break;
                default:
                    break;
            }
        });
    },
    /**
     * Aqui vamos a mandar a cargar el store
     * 
     * @param FV.view.Disponibilidad.Grid grid
     */
    loadStore: function(grid) {
        grid.getStore().load();
    },
    /**
     * Muestra el formulario
     */
    addDisponibilidad: function() {
        var formPanel = this.getDisponibilidadWindow().down('form');
        formPanel.getForm().reset();
        this.getDisponibilidadWindow().show();
    },
    saveDisponibilidad: function() {
        //debugger;
        var formPanel = this.getDisponibilidadWindow().down('form'),
                grid = this.getDisponibilidadGrid(),
                prodStore = formPanel.down('#produc_id').getStore(),
                provStore = formPanel.down('#proveed_id').getStore(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
        } else {//es uno nuevo
            values.Producto = prodStore.getById(values.produc_id).data;
            values.producto_nombre = values.Producto.nombre;
            values.um = values.Producto.Um.nombre;
            values.producto_id = values.Producto.id;
            values.proveedor_nombre = provStore.getById(values.proveed_id).data.nombre;
            record = Ext.create('FV.model.mDisponibilidad', values);
            grid.getStore().add(record);
        }
        this.resetForm();
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
        formPanel.down('#produc_id').disable(true);
        this.getDisponibilidadGrid().getSelectionModel().deselect(record);
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
            var combo2 = this.getDisponibilidadWindow().down(combo2Id),
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
    selectProveedor: function(combo) {
        var id = combo.getValue();
        this.loadDependantCombo(id, '#produc_id', {
            proveedor: id
        });
    },
    /**
     * Devuelve el formulario para crear disponibilidad de act.
     * 
     * @return {Ext.form.Panel} El formulario
     */
    getFormPanel: function() {
        return this.getDisponibilidadWindow().down('form');
    }
});



