var month = '%';
var year = '%';
Ext.define('FV.controller.cProductomercado', {
    extend: 'Ext.app.Controller',
    models: ["mProductomercado"],
    stores: ["sProductomercado"],
    views: ["Productomercado.View", 'Productomercado.Grid', 'Productomercado.Form'],
    refs: [
        {ref: 'productomercadoView', selector: 'productomercadoView'},
        {ref: 'productomercadoGrid', selector: 'productomercadoGrid'},
        {ref: 'productomercadoForm', selector: 'productomercadoForm'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'productomercadoGrid': {
                beforerender: this.loadView,
                selectionchange: this.loadMercado
            },
            'productomercadoForm button[action=add]': {
                click: this.saveProductoMercado
            },
            'productomercadoForm button[action=cancel]': {
                click: this.resetForm
            },
            'productomercadoGrid button[action=delete]': {
                click: this.deleteProductoMercado
            },
            'productomercadoForm combobox[id=mercado_proveedor_id]': {
                select: this.selectProveedor
            },
            'productomercadoGrid numberfield': {
                spindown: this.loadStoreYear2,
                spinup: this.loadStoreYear1
            }
        });
    },
    loadStoreYear: function(number) {
        year = number;
        this.getProductomercadoGrid().getStore().load({
            params: {
                mes: month,
                year: year
            },
            callback: function(records, operation, success) {
                if (success) {
                    //Ext.example.msg("","");
                }
            }
        });

    },
    loadStoreYear1: function(number) {
        var val = number.getValue();
        if (val) {
            this.loadStoreYear(val + 1);
        }
    },
    loadStoreYear2: function(number) {
        var val = number.getValue();
        if (val) {
            this.loadStoreYear(val - 1);
        }
    },
    selectProveedor: function(combo) {
        var id = combo.getValue();
        this.loadDependantCombo2(id, '#producto_mercado_id', {
            proveedor: id
        });
    },
    loadDependantCombo2: function(id, combo2Id, extraParams) {
        if (id) {
            var combo2 = this.getProductomercadoForm().down(combo2Id),
                    store = combo2.getStore();
            store.load({
                params: extraParams,
                callback: function(records, operation, success) {
                    if (success) {
                        combo2.setDisabled(!(records.length > 0));
                    }
                }
            });
        }
    },
    loadView: function(grid) {
        grid.getStore().load({
            params: {
                mes: month,
                year: year
            },
            callback: function(records, operation, success) {
                if (success) {
                    //Ext.example.msg("","");
                }
            }
        });
    },
    loadMercado: function(selModel, selected) {
        var record = selected[0],
                formPanel = this.getProductomercadoForm(),
                viewPanel = this.getProductomercadoGrid();
        if (record) {
            formPanel.loadRecord(record);
            viewPanel.down("button[action=delete]").enable();
        } else {
            this.resetForm();
            viewPanel.down("button[action=delete]").disable();
        }
    },
    saveProductoMercado: function() {
        var formPanel = this.getProductomercadoForm(),
                grid = this.getProductomercadoGrid(),
                subStore = formPanel.down('#producto_mercado_id').getStore(),
                subStore1 = formPanel.down('#mercado_id').getStore(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
        } else {//es uno nuevo
            values.Producto = subStore.getById(values.producto_mercado_id).data;
            values.Mercado = subStore1.getById(values.mercado_id).data;
            values.producto_id = values.Producto.id;
            record = Ext.create('FV.model.mProductomercado', values);
            grid.getStore().add(record);
        }
        this.resetForm();
    },
    resetForm: function() {
        var formPanel = this.getProductomercadoForm(),
                record = formPanel.getRecord();
        formPanel.getForm().reset();
        this.getProductomercadoGrid().getSelectionModel().deselect(record);
    },
    deleteProductoMercado: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar el registro?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getProductomercadoGrid().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getProductomercadoGrid().getStore().remove(record);
                    }
                    break;
                default:
                    break;
            }
        });
    }
});






