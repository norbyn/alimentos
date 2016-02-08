Ext.define('FV.controller.cProveedor', {
    extend: 'Ext.app.Controller',
    models: ["mProveedor"],
    stores: ["sProveedor"],
    views: ["Proveedor.View", 'Proveedor.Grid', 'Proveedor.Form'],
    refs: [
        {ref: 'proveedorView', selector: 'proveedorView'},
        {ref: 'proveedorGrid', selector: 'proveedorGrid'},
        {ref: 'proveedorForm', selector: 'proveedorForm'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'proveedorGrid': {
                beforerender: this.loadView,
                selectionchange: this.loadProve
            },
            'proveedorForm button[action=add]': {
                click: this.saveProve
            },
            'proveedorForm button[action=cancel]': {
                click: this.resetForm
            },
            'proveedorGrid button[action=delete]': {
                click: this.deleteProve
            }
        });
    },
    loadView: function(grid) {
        grid.getStore().load();
    },
    loadProve: function(selModel, selected) {
        var record = selected[0],
                formPanel = this.getProveedorForm(),
                viewPanel = this.getProveedorGrid();
        if (record) {
            formPanel.loadRecord(record);
            viewPanel.down("button[action=delete]").enable();
        } else {
            this.resetForm();
            viewPanel.down("button[action=delete]").disable();
        }
    },
    saveProve: function() {
        var formPanel = this.getProveedorForm(),
                grid = this.getProveedorGrid(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
        } else {//es uno nuevo
            record = Ext.create('FV.model.mProveedor', values);
            grid.getStore().add(record);
        }
        this.resetForm();
    },
    resetForm: function() {
        var formPanel = this.getProveedorForm(),
                record = formPanel.getRecord();
        formPanel.getForm().reset();
        this.getProveedorGrid().getSelectionModel().deselect(record);
    },
    deleteProve: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar el proveedor?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getProveedorGrid().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getProveedorGrid().getStore().remove(record);
                    }
                    break;
                default:
                    break;
            }
        });
    }
});






