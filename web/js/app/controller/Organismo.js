Ext.define('FV.controller.Organismo', {
    extend: 'Ext.app.Controller',
    models: ["Organismo"],
    stores: ["Organismos"],
    views: ["Organismo.View", 'Organismo.Grid', 'Organismo.Form'],
    refs: [
        {ref: 'orgView', selector: 'organismoView'},
        {ref: 'organismoGrid', selector: 'organismoGrid'},
        {ref: 'organismoForm', selector: 'organismoForm'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'organismoGrid': {
                beforerender: this.loadView,
                selectionchange: this.loadOrganismo
            },
            'organismoForm button[action=add]': {
                click: this.saveOrganismo
            },
            'organismoForm button[action=cancel]': {
                click: this.resetForm
            },
            'organismoGrid button[action=delete]': {
                click: this.deleteOrganismo
            }
        });
    },
    loadView: function(grid) {
        grid.getStore().load();
    },
    loadOrganismo: function(selModel, selected) {
        var record = selected[0],
                formPanel = this.getOrganismoForm(),
                viewPanel = this.getOrganismoGrid();
        if (record) {
            formPanel.loadRecord(record);
            viewPanel.down("button[action=delete]").enable();
        } else {
            this.resetForm();
            viewPanel.down("button[action=delete]").disable();
        }
    },
    saveOrganismo: function() {
        var formPanel = this.getOrganismoForm(),
                grid = this.getOrganismoGrid(),
                subStore = formPanel.down('combobox').getStore(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
        } else {//es uno nuevo
            values.Subordinacion = subStore.getById(values.subordinacion_id).data;
            record = Ext.create('FV.model.Organismo', values);
            grid.getStore().add(record);
        }
        this.resetForm();
    },
    resetForm: function() {
        var formPanel = this.getOrganismoForm(),
                record = formPanel.getRecord();
        formPanel.getForm().reset();
        this.getOrganismoGrid().getSelectionModel().deselect(record);
    },
    deleteOrganismo: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar el organismo.?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getOrganismoGrid().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getOrganismoGrid().getStore().remove(record);
                    }
                    break;
                default:
                    break;
            }
        });
    }
});



