Ext.define('FV.controller.cMercado', {
    extend: 'Ext.app.Controller',
    models: ["mMercado"],
    stores: ["sMercado"],
    views: ["Mercado.View", 'Mercado.Grid', 'Mercado.Form'],
    refs: [
        {ref: 'mercadoView', selector: 'mercadoView'},
        {ref: 'mercadoGrid', selector: 'mercadoGrid'},
        {ref: 'mercadoForm', selector: 'mercadoForm'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'mercadoGrid': {
                beforerender: this.loadView,
                selectionchange: this.loadMercado
            },
            'mercadoForm button[action=add]': {
                click: this.saveMercado
            },
            'mercadoForm button[action=cancel]': {
                click: this.resetForm
            },
            'mercadoGrid button[action=delete]': {
                click: this.deleteMercado
            }
        });
    },
    loadView: function(grid) {
        grid.getStore().load();
    },
    loadMercado: function(selModel, selected) {
        var record = selected[0],
                formPanel = this.getMercadoForm(),
                viewPanel = this.getMercadoGrid();
        if (record) {
            formPanel.loadRecord(record);
            viewPanel.down("button[action=delete]").enable();
        } else {
            this.resetForm();
            viewPanel.down("button[action=delete]").disable();
        }
    },
    saveMercado: function() {
        var formPanel = this.getMercadoForm(),
                grid = this.getMercadoGrid(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
        } else {//es uno nuevo
            record = Ext.create('FV.model.mMercado', values);
            grid.getStore().add(record);
        }
        this.resetForm();
    },
    resetForm: function() {
        var formPanel = this.getMercadoForm(),
                record = formPanel.getRecord();
        formPanel.getForm().reset();
        this.getMercadoGrid().getSelectionModel().deselect(record);
    },
    deleteMercado: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar el registro?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getMercadoGrid().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getMercadoGrid().getStore().remove(record);
                    }
                    break;
                default:
                    break;
            }
        });
    }
});






