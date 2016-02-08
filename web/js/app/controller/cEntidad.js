Ext.define('FV.controller.cEntidad', {
    extend: 'Ext.app.Controller',
    models: ["mEntidad"],
    stores: ["sEntidad"],
    views: ["Entidad.View", 'Entidad.Grid', 'Entidad.Form'],
    refs: [
        {ref: 'entidadView', selector: 'entidadView'},
        {ref: 'entidadGrid', selector: 'entidadGrid'},
        {ref: 'entidadForm', selector: 'entidadForm'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'entidadGrid': {
                beforerender: this.loadView,
                selectionchange: this.loadEntidad
            },
            'entidadForm button[action=add]': {
                click: this.saveEntidad
            },
            'entidadForm button[action=cancel]': {
                click: this.resetForm
            },
            'entidadGrid button[action=delete]': {
                click: this.deleteEntidad
            }
        });
    },
	loadView: function(grid) {
        grid.getStore().load();
    },
    loadEntidad: function(selModel, selected) {
        var record = selected[0],
                formPanel = this.getEntidadForm(),
                viewPanel = this.getEntidadGrid();
        if (record) {
            formPanel.loadRecord(record);
            viewPanel.down("button[action=delete]").enable();
        } else {
            this.resetForm();
            viewPanel.down("button[action=delete]").disable();
        }
    },
    saveEntidad: function() {
        var formPanel = this.getEntidadForm(),
                grid = this.getEntidadGrid(),
                subStore = formPanel.down('combobox').getStore(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
        } else {//es uno nuevo
            values.Organismo = subStore.getById(values.organismo_id).data;
            record = Ext.create('FV.model.mEntidad', values);
            grid.getStore().add(record);
        }
        this.resetForm();
    },
    resetForm: function() {
        var formPanel = this.getEntidadForm(),
                record = formPanel.getRecord();
        formPanel.getForm().reset();
        this.getEntidadGrid().getSelectionModel().deselect(record);
    },
    deleteEntidad: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar la entidad?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getEntidadGrid().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getEntidadGrid().getStore().remove(record);
                    }
                    break;
                default:
                    break;
            }
        });
    }
});






