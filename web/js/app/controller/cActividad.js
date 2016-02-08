//Controlador de Actividad
Ext.define('FV.controller.cActividad', {
    extend: 'Ext.app.Controller',
    models: ["mActividad"],
    stores: ["sActividad"],
    views: ["Actividad.View", 'Actividad.Grid', 'Actividad.Form'],
    refs: [
        {ref: 'actividadView', selector: 'actividadView'},
        {ref: 'actividadGrid', selector: 'actividadGrid'},
        {ref: 'actividadForm', selector: 'actividadForm'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'actividadGrid': {
                beforerender: this.loadView,
                selectionchange: this.loadActividad
            },
            'actividadForm button[action=add]': {
                click: this.saveActividad
            },
            'actividadForm button[action=cancel]': {
                click: this.resetForm
            },
            'actividadGrid button[action=delete]': {
                click: this.deleteActividad
            }
        });
    },
    loadView: function(grid) {
        grid.getStore().load();
    },
    loadActividad: function(selModel, selected) {
        var record = selected[0],
                formPanel = this.getActividadForm(),
                viewPanel = this.getActividadGrid();
        if (record) {
            formPanel.loadRecord(record);
            viewPanel.down("button[action=delete]").enable();
        } else {
            this.resetForm();
            viewPanel.down("button[action=delete]").disable();
        }
    },
    saveActividad: function() {
        var formPanel = this.getActividadForm(),
                grid = this.getActividadGrid(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
        } else {//es uno nuevo
            record = Ext.create('FV.model.mActividad', values);
            grid.getStore().add(record);
        }
        this.resetForm();
    },
    resetForm: function() {
        var formPanel = this.getActividadForm(),
                record = formPanel.getRecord();
        formPanel.getForm().reset();
        this.getActividadGrid().getSelectionModel().deselect(record);
    },
    deleteActividad: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar el actividad?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getActividadGrid().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getActividadGrid().getStore().remove(record);
                    }
                    break;
                default:
                    break;
            }
        });
    }
});






