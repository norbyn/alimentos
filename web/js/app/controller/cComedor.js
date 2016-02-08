Ext.define('FV.controller.cComedor', {
    extend: 'Ext.app.Controller',
    stores: ["sComedor"],
    views: ['Comedor.Form', 'Comedor.FormName'],
    refs: [
        {ref: 'comedoresGrid', selector: 'comedoresGrid'},
        {ref: 'comedoresWindow', selector: 'comedoresWindow', autoCreate: true, xtype: 'comedoresWindow'},
        {ref: 'comedoresGridName', selector: 'comedoresGridName'},
        {ref: 'comedorFormName', selector: 'comedorFormName'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'comedoresGrid': {
                beforerender: this.loadStore,
                selectionchange: this.select
            },
            'comedoresGridName': {
                selectionchange: this.select
            },
            'comedoresWindow combobox[id=org_id]': {
                select: this.selectOrganismo
            },
            'comedoresWindow combobox[id=entidad_id]': {
                select: this.selectEntidad
            },
            'comedoresWindow button[action=accept]': {
                click: this.close
            },
            'comedoresGrid button[action=add]': {
                click: this.addComedor
            },
            'comedoresGridName button[action=showFormName]': {
                click: this.showFormName
            },
            'comedoresGridName button[action=deleteRow]': {
                click: this.deleteComedor
            },
            'comedoresWindow button[action=create]': {
                click: this.saveComedor
            },
            'comedoresWindow button[action=cancel]': {
                click: this.resetForm
            },
            'comedorFormName button[action=create]': {
                click: this.saveComedor
            }
        });
    },
    select: function(selModel, selected) {
        var record = selected[0];
        if (record) {
            this.getComedoresGridName().down("button[action=deleteRow]").enable();
        }
        else {
            this.getComedoresGridName().down("button[action=deleteRow]").disable();
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
    addComedor: function() {
        this.getComedoresWindow().show();
    },
    /**
     * Muestra el formulario
     */
    showFormName: function() {
        var comedorFormName = Ext.widget('comedorFormName');

        var formPanel = this.getComedoresWindow().down('form'),
                values = formPanel.getValues(),
                entStore = formPanel.down('#entidad_id').getStore();
        values.Entidad = entStore.getById(values.entidad_id).data;
        var id = values.Entidad.id;

        var store = comedorFormName.down('#nombre_comedor_id').getStore();
        store.load({
            params: {entidad: id},
            callback: function(records, operation, success) {
                if (success) {
                }
            }
        });
    },
    saveComedor: function() {
        var formPanel = this.getComedoresWindow().down('form'),
                grid = this.getComedoresGridName(),
                entStore = formPanel.down('#entidad_id').getStore(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        var formNamePanel = this.getComedorFormName().down('form'),
                comStore = formNamePanel.down('#nombre_comedor_id').getStore(),
                record2 = formNamePanel.getRecord(),
                values2 = formNamePanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
            formNamePanel.getForm().updateRecord(record2);
        } else {//es uno nuevo
            values.Entidad = entStore.getById(values.entidad_id).data;
            values.TipoComedor = comStore.getById(values2.nombre_comedor_id).data;
            values.nombre_comedor_id = values.TipoComedor.id;
            values.entidad_id = values.Entidad.id;
            values.reup = "";
            values.tc = "";
            record = Ext.create('FV.model.mComedor', values);
            grid.getStore().add(record);
        }
        this.getComedorFormName().close();
    },
    deleteComedor: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar el comedor permanentemente?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getComedoresGridName().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getComedoresGridName().getStore().remove(record);
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
        formPanel.down('#entidad_id').disable(true);
        this.getComedoresGridName().setDisabled(true);
    },
    close: function() {
        this.getComedoresWindow().close();
        this.getComedoresGrid().getStore().load();
    },
    /**
     * Evento select del combobox de organismos
     * 
     * @param {Ext.form.field.ComboBox} combo
     */
    selectOrganismo: function(combo) {
        var id = combo.getValue();
        this.loadDependantCombo(id, '#entidad_id', {
            organismo: id
        });
    },
    /**
     * Evento select del combobox de entidades
     * 
     * @param {Ext.form.field.ComboBox} combo
     */
    selectEntidad: function(combo) {
        var id = combo.getValue();
        this.loadComedoresStore(id, {
            entidad: id
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
            var combo2 = this.getComedoresWindow().down(combo2Id),
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
    loadComedoresStore: function(id, extraParams) {
        if (id) {
            this.getComedoresGridName().getStore().load({
                params: extraParams,
                callback: function(records, operation, success) {
                    if (success) {
                        //this.getComedoresGridName().setDisabled(!(records.length > 0));
                    }
                }
            });
            this.getComedoresGridName().setDisabled(false);
        }
    },
    /**
     * Devuelve el formulario.
     * 
     * @return {Ext.form.Panel} El formulario
     */
    getFormPanel: function() {
        return this.getComedoresWindow().down('form');
    }
});



