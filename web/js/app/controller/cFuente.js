Ext.define('FV.controller.cFuente', {
    extend: 'Ext.app.Controller',
    models: ["mFuente"],
    stores: ["sFuente"],
    views: ["Fuente.View", 'Fuente.Grid', 'Fuente.Form'],
    refs: [
        {ref: 'fuenteView', selector: 'fuenteView'},
        {ref: 'fuenteGrid', selector: 'fuenteGrid'},
        {ref: 'fuenteForm', selector: 'fuenteForm'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'fuenteGrid': {
                beforerender: this.loadView,
                selectionchange: this.loadFuente
            },
            'fuenteForm button[action=add]': {
                click: this.saveFuente
            },
            'fuenteForm button[action=cancel]': {
                click: this.resetForm
            },
            'fuenteGrid button[action=delete]': {
                click: this.deleteFuente
            }
        });
    },
    loadView: function(grid) {
        grid.getStore().load();
    },
    loadFuente: function(selModel, selected) {
        var record = selected[0],
                formPanel = this.getFuenteForm(),
                viewPanel = this.getFuenteGrid();
        if (record) {
            formPanel.loadRecord(record);
            viewPanel.down("button[action=delete]").enable();
        } else {
            this.resetForm();
            viewPanel.down("button[action=delete]").disable();
        }
    },
    saveFuente: function() {
        var formPanel = this.getFuenteForm(),
                grid = this.getFuenteGrid(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
        } else {//es uno nuevo
            record = Ext.create('FV.model.mFuente', values);
            grid.getStore().add(record);
        }
        this.resetForm();
    },
    resetForm: function() {
        var formPanel = this.getFuenteForm(),
                record = formPanel.getRecord();
        formPanel.getForm().reset();
        this.getFuenteGrid().getSelectionModel().deselect(record);
    },
    deleteFuente: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar la fuente?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getFuenteGrid().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getFuenteGrid().getStore().remove(record);
                    }
                    break;
                default:
                    break;
            }
        });
    }
});






