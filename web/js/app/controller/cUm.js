Ext.define('FV.controller.cUm', {
    extend: 'Ext.app.Controller',
    models: ["mUm"],
    stores: ["sUm"],
    views: ["Um.View", 'Um.Grid', 'Um.Form'],
    refs: [
        {ref: 'umView', selector: 'umView'},
        {ref: 'umGrid', selector: 'umGrid'},
        {ref: 'umForm', selector: 'umForm'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'umGrid': {
                beforerender: this.loadView,
                selectionchange: this.loadUm
            },
            'umForm button[action=add]': {
                click: this.saveUm
            },
            'umForm button[action=cancel]': {
                click: this.resetForm
            },
            'umGrid button[action=delete]': {
                click: this.deleteUm
            }
        });
    },
    loadView: function(grid) {
        grid.getStore().load();
        //console.log(grid);
    },
    loadUm: function(selModel, selected) {
        var record = selected[0],
                formPanel = this.getUmForm(),
                viewPanel = this.getUmGrid();
        if (record) {
            formPanel.loadRecord(record);
            viewPanel.down("button[action=delete]").enable();
        } else {
            this.resetForm();
            viewPanel.down("button[action=delete]").disable();
        }
    },
    saveUm: function() {
        var formPanel = this.getUmForm(),
                grid = this.getUmGrid(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
        } else {//es uno nuevo
            record = Ext.create('FV.model.mUm', values);
            grid.getStore().add(record);
        }
        this.resetForm();
    },
    resetForm: function() {
        var formPanel = this.getUmForm(),
                record = formPanel.getRecord();
        formPanel.getForm().reset();
        this.getUmGrid().getSelectionModel().deselect(record);
    },
    deleteUm: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar la unidad de medida?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getUmGrid().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getUmGrid().getStore().remove(record);
                    }
                    break;
                default:
                    break;
            }
        });
    }
});






