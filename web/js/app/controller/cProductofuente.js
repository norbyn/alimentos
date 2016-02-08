var month = '%';
var year = '%';
Ext.define('FV.controller.cProductofuente', {
    extend: 'Ext.app.Controller',
    models: ["mProductofuente"],
    stores: ["sProductofuente"],
    views: ["Productofuente.View", 'Productofuente.Grid', 'Productofuente.Form'],
    refs: [
        {ref: 'productofuenteView', selector: 'productofuenteView'},
        {ref: 'productofuenteGrid', selector: 'productofuenteGrid'},
        {ref: 'productofuenteForm', selector: 'productofuenteForm'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'productofuenteGrid': {
                beforerender: this.loadView,
                selectionchange: this.loadFuente
            },
            'productofuenteForm button[action=add]': {
                click: this.saveProductoFuente
            },
            'productofuenteForm button[action=cancel]': {
                click: this.resetForm
            },
            'productofuenteGrid button[action=delete]': {
                click: this.deleteProductoFuente
            },
            'productofuenteForm combobox[id=fuente_proveedor_id]': {
                select: this.selectProveedor
            },
            'productofuenteGrid numberfield': {
                spindown: this.loadStoreYear2,
                spinup: this.loadStoreYear1
            }
        });
    },
    loadStoreYear: function(number) {
        year = number;
        this.getProductofuenteGrid().getStore().load({
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
        this.loadDependantCombo2(id, '#producto_id', {
            proveedor: id
        });
    },
    loadDependantCombo2: function(id, combo2Id, extraParams) {
        if (id) {
            var combo2 = this.getProductofuenteForm().down(combo2Id),
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
    loadFuente: function(selModel, selected) {
        var record = selected[0],
                formPanel = this.getProductofuenteForm(),
                viewPanel = this.getProductofuenteGrid();
        if (record) {
            formPanel.loadRecord(record);
            viewPanel.down("button[action=delete]").enable();
        } else {
            this.resetForm();
            viewPanel.down("button[action=delete]").disable();
        }
    },
    saveProductoFuente: function() {
        var formPanel = this.getProductofuenteForm(),
                grid = this.getProductofuenteGrid(),
                subStore = formPanel.down('#producto_id').getStore(),
                subStore1 = formPanel.down('#fuentes_id').getStore(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
        } else {//es uno nuevo
            values.Producto = subStore.getById(values.producto_id).data;
            values.Fuente = subStore1.getById(values.fuentes_id).data;
            record = Ext.create('FV.model.mProductofuente', values);
            grid.getStore().add(record);
        }
        this.resetForm();
    },
    resetForm: function() {
        var formPanel = this.getProductofuenteForm(),
                record = formPanel.getRecord();
        formPanel.getForm().reset();
        this.getProductofuenteGrid().getSelectionModel().deselect(record);
    },
    deleteProductoFuente: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar la entrada de fuente?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getProductofuenteGrid().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getProductofuenteGrid().getStore().remove(record);
                    }
                    break;
                default:
                    break;
            }
        });
    }
});






