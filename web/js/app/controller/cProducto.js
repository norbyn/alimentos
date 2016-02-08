Ext.define('FV.controller.cProducto', {
    extend: 'Ext.app.Controller',
    models: ["mProducto"],
    stores: ["sProducto"],
    views: ["Producto.View", 'Producto.Grid', 'Producto.Form'],
    refs: [
        {ref: 'productoView', selector: 'productoView'},
        {ref: 'productoGrid', selector: 'productoGrid'},
        {ref: 'productoForm', selector: 'productoForm'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'productoGrid': {
                beforerender: this.loadView,
                selectionchange: this.loadProducto
            },
            'productoForm button[action=add]': {
                click: this.saveProducto
            },
            'productoForm button[action=cancel]': {
                click: this.resetForm
            },
            'productoGrid button[action=delete]': {
                click: this.deleteProducto
            }
        });
    },
    loadView: function(grid) {
        grid.getStore().load();
    },
    loadProducto: function(selModel, selected) {
        var record = selected[0],
                formPanel = this.getProductoForm(),
                viewPanel = this.getProductoGrid();
        if (record) {
            formPanel.loadRecord(record);
            viewPanel.down("button[action=delete]").enable();
        } else {
            this.resetForm();
            viewPanel.down("button[action=delete]").disable();
        }
    },
    saveProducto: function() {
        var formPanel = this.getProductoForm(),
                grid = this.getProductoGrid(),
                subStore = formPanel.down('#um_id').getStore(),
                subStore1 = formPanel.down('#proveedor_id').getStore(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
        } else {//es uno nuevo
            values.Um = subStore.getById(values.um_id).data;
            values.Proveedor = subStore1.getById(values.proveedor_id).data;
            record = Ext.create('FV.model.mProducto', values);
            grid.getStore().add(record);
        }
        this.resetForm();
    },
    resetForm: function() {
        var formPanel = this.getProductoForm(),
                record = formPanel.getRecord();
        formPanel.getForm().reset();
        this.getProductoGrid().getSelectionModel().deselect(record);
    },
    deleteProducto: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar el producto.?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getProductoGrid().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getProductoGrid().getStore().remove(record);
                    }
                    break;
                default:
                    break;
            }
        });
    }
});



