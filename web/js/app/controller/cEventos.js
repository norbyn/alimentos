var year = '%';
var month = '%';
Ext.define('FV.controller.cEventos', {
    extend: 'Ext.app.Controller',
    models: ["mEventos"],
    stores: ["sEventos"],
    views: ['Eventos.Form'],
    refs: [
        {ref: 'eventosGrid', selector: 'eventosGrid'},
        {ref: 'eventosForm', selector: 'eventosForm',
            autoCreate: true,
            xtype: 'eventosForm'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'eventosGrid': {
                beforerender: this.loadView,
                itemdblclick: this.Editar
            },
            'eventosGrid button[action=actAgregar]': //Usando Ext.Component.Query
                    {
                        click: this.Agregar
                    },
            'eventosGrid button[action=actEditar]': //Usando Ext.Component.Query
                    {
                        click: this.Editar
                    },
            'eventosForm button[action=add]': {
                click: this.save
            },
            'eventosGrid button[action=delete]': {
                click: this.delete
            },
            'eventosGrid numberfield': {
                change: this.loadStoreYear
            },
            'eventosGrid combobox[id=combo_month1]': {
                select: this.loadStore3
            },
            'eventosForm combobox[id=ev_organismo_id]': {
                select: this.selectOrganismo
            },
            'eventosForm combobox[id=ev_proveedor_id]': {
                select: this.selectProveedor
            },
            'eventosForm combobox[id=e_id]': {
                select: this.selectEntidad
            }
        });
    },
    loadView: function(grid) {
        grid.getStore().load();
    },
    Agregar: function() {
        this.getEventosForm().show();
        this.resetForm();
    },
    Editar: function(grid, record) {
        records = this.getEventosGrid().getSelectionModel().getSelection();
        if (records.length > 0) {
            var window = this.getEventosForm();
            window.show();
            var EditForm = window.down('form');
            var record = records[0];
            EditForm.loadRecord(record);
            EditForm.down('#p_id').clearValue();
        }
    },
    save: function() {
        var formPanel = this.getEventosForm().down('form'),
                grid = this.getEventosGrid(),
                subStore = formPanel.down('#e_id').getStore(),
                subStore1 = formPanel.down('#p_id').getStore(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
        } else {//es uno nuevo
            values.Entidad = subStore.getById(values.entidad_id).data;
            values.Producto = subStore1.getById(values.producto_id).data;
            values.producto_nombre = values.Producto.nombre;
            values.entidad_nombre = values.Entidad.nombre;
            record = Ext.create('FV.model.mEventos', values);
            grid.getStore().add(record);
        }
        this.resetForm();
        this.getEventosForm().close();
    },
    delete: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar el registro permanentemente?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getEventosGrid().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getEventosGrid().getStore().remove(record);
                    }
                    break;
                default:
                    break;
            }
        });
    },
    resetForm: function() {
        var formPanel = this.getFormPanel(),
                record = formPanel.getRecord();
        formPanel.getForm().reset();
        formPanel.down('#e_id').clearValue();
        formPanel.down('#p_id').clearValue();
        this.getEventosGrid().getSelectionModel().deselect(record);
        var combo2 = this.getEventosForm().down('#p_id');
        combo2.setDisabled(true);
    },
    /**
     * Devuelve el formulario para crear nivel de act.
     * 
     * @return {Ext.form.Panel} El formulario
     */
    getFormPanel: function() {
        return this.getEventosForm().down('form');
    },
    loadStoreYear: function(number) {
        var val = number.getValue();
        if (val) {
            year = val;
            this.getEventosGrid().getStore().load({
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
            this.getEventosGrid().getStore().load({
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
    selectOrganismo: function(combo) {
        var id = combo.getValue();
        this.loadDependantCombo(id, '#e_id', {
            organismo: id
        });
    },
    selectProveedor: function(combo) {
        var id = combo.getValue();
        var formPanel = this.getEventosForm().down('form'),
                entStore = formPanel.down('#e_id').getStore(),
                values = formPanel.getValues();
        values.Entidad = entStore.getById(values.entidad_id).data;
        var ent = values.Entidad.id;
        this.loadDependantCombo(id, '#p_id', {
            proveedor: id,
            entidad: ent
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
            var combo2 = this.getEventosForm().down(combo2Id),
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
    selectEntidad: function(combo) {
        var id = combo.getValue();
        if (id) {
            var combo2 = this.getEventosForm().down('#ev_proveedor_id');
            combo2.setDisabled(false);
        }
    }
});






