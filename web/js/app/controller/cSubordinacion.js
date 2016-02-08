Ext.define('FV.controller.cSubordinacion', {
    extend: 'Ext.app.Controller',
    models: ["mSubordinacion"],
    stores: ["sSubordinacion"],
    views: ["Subordinacion.View", 'Subordinacion.Grid', 'Subordinacion.Form'],
    refs: [
        {ref: 'subordinacionView', selector: 'subordinacionView'},
        {ref: 'subordinacionGrid', selector: 'subordinacionGrid'},
        {ref: 'subordinacionForm', selector: 'subordinacionForm'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'subordinacionGrid': {
                beforerender: this.loadView,
                selectionchange: this.loadSub
            },
            'subordinacionForm button[action=add]': {
                click: this.saveSub
            },
            'subordinacionForm button[action=cancel]': {
                click: this.resetForm
            },
            'subordinacionGrid button[action=delete]': {
                click: this.deleteSub
            }
        });
    },
    loadView: function(grid) {
        grid.getStore().load();
    },
    loadSub: function(selModel, selected) {
        var record = selected[0],
                formPanel = this.getSubordinacionForm(),
                viewPanel = this.getSubordinacionGrid();
        if (record) {
            formPanel.loadRecord(record);
            viewPanel.down("button[action=delete]").enable();
        } else {
            this.resetForm();
            viewPanel.down("button[action=delete]").disable();
        }
    },
    saveSub: function() {
        var formPanel = this.getSubordinacionForm(),
                grid = this.getSubordinacionGrid(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
        } else {//es uno nuevo
            record = Ext.create('FV.model.mSubordinacion', values);
            grid.getStore().add(record);
        }
        this.resetForm();
    },
    resetForm: function() {
        var formPanel = this.getSubordinacionForm(),
                record = formPanel.getRecord();
        formPanel.getForm().reset();
        this.getSubordinacionGrid().getSelectionModel().deselect(record);
    },
    deleteSub: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar la subordinación?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getSubordinacionGrid().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getSubordinacionGrid().getStore().remove(record);
                    }
                    break;
                default:
                    break;
            }
        });
    }
});






