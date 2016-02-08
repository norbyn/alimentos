Ext.define('FV.controller.cTcomedor', {
    extend: 'Ext.app.Controller',
    models: ["mTcomedor"],
    stores: ["sTcomedor"],
    views: ["Tcomedor.View", 'Tcomedor.Grid', 'Tcomedor.Form'],
    refs: [
        {ref: 'tcomedorView', selector: 'tcomedorView'},
        {ref: 'tcomedorGrid', selector: 'tcomedorGrid'},
        {ref: 'tcomedorForm', selector: 'tcomedorForm'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'tcomedorGrid': {
                beforerender: this.loadView,
                selectionchange: this.loadTcomedor
            },
            'tcomedorForm button[action=add]': {
                click: this.saveTcomedor
            },
            'tcomedorForm button[action=cancel]': {
                click: this.resetForm
            },
            'tcomedorGrid button[action=delete]': {
                click: this.deleteTcomedor
            }
        });
    },
    loadView: function(grid) {
        grid.getStore().load();
    },
    loadTcomedor: function(selModel, selected) {
        var record = selected[0],
                formPanel = this.getTcomedorForm(),
                viewPanel = this.getTcomedorGrid();
        if (record) {
            formPanel.loadRecord(record);
            viewPanel.down("button[action=delete]").enable();
        } else {
            this.resetForm();
            viewPanel.down("button[action=delete]").disable();
        }
    },
    saveTcomedor: function() {
        var formPanel = this.getTcomedorForm(),
                grid = this.getTcomedorGrid(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
        } else {//es uno nuevo
            record = Ext.create('FV.model.mTcomedor', values);
            grid.getStore().add(record);
        }
        this.resetForm();
    },
    resetForm: function() {
        var formPanel = this.getTcomedorForm(),
                record = formPanel.getRecord();
        formPanel.getForm().reset();
        this.getTcomedorGrid().getSelectionModel().deselect(record);
    },
    deleteTcomedor: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar el tipo de comedor?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getTcomedorGrid().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getTcomedorGrid().getStore().remove(record);
                    }
                    break;
                default:
                    break;
            }
        });
    }
});






