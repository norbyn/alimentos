//"use strict";
Ext.define('FV.controller.Provincia', {
    extend: 'Ext.app.Controller',
    models: ["Provincia", "Municipio"],
    stores: ["Provincias", "Municipios"],
    views: ["Provincia.Grid", "Provincia.MunicipiosGrid", "Provincia.Viewer", 'Provincia.ContextMenu', 'Provincia.MunicipioContextMenu', 'Provincia.Form', 'Provincia.ProvForm'],
    refs: [
        {ref: 'provGrid', selector: 'provGrid'},
        {ref: 'municipiosGrid', selector: 'municipiosGrid'},
        {
            ref: 'provinciaWindow',
            selector: 'provinciaWindow',
            autoCreate: true,
            xtype: 'provinciaWindow'
        },
        {
            ref: 'provWindow',
            selector: 'provWindow',
            autoCreate: true,
            xtype: 'provWindow'
        }
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'municipiosGrid': {
                render: this.createToolTip2,
                itemcontextmenu: this.showContextMenu2
            },
            'provGrid': {
                beforerender: this.loadView,
                render: this.createToolTip,
                selectionchange: this.loadMunicipios,
                itemcontextmenu: this.showContextMenu
            },
            'provGrid button[action=add]': {
                click: this.addProv
            },
            'provGrid button[action=edit]': {
                click: this.editarProvincia
            },
            'provGrid button[action=remove]': {
                click: this.eliminarProvincia
            },
            'municipioContextMenu menuitem[action="delete"]': {
                click: this.eliminarMunicipio
            },
            'provinciaContextMenu menuitem[action="assign"]': {
                click: this.asignarMunicipios
            },
            'municipioContextMenu menuitem[action="edit"]': {
                click: this.editarMunicipio
            },
            'provinciaWindow button[action=create]': {
                click: this.salvarMunicipio
            },
            'provWindow button[action=create]': {
                click: this.salvarProvincia
            }
        });
    },
    editarProvincia: function(grid, record) {
        var records = this.getProvGrid().getSelectionModel().getSelection();
        if (records.length > 0) {
            var window = this.getProvWindow();
            window.setTitle('Editar Provincia');
            window.show();
            var EditForm = window.down('form');
            var record = records[0];
            EditForm.loadRecord(record);
        }
    },
    editarMunicipio: function(grid, record) {
        var records = this.getMunicipiosGrid().getSelectionModel().getSelection();
        if (records.length > 0) {
            var window = this.getProvinciaWindow();
            window.setTitle('Editar Municipio');
            window.show();
            var EditForm = window.down('form');
            var record = records[0];
            EditForm.loadRecord(record);
        }
    },
    eliminarProvincia: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar esta provincia?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getProvGrid().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getProvGrid().getStore().remove(record);
                    }
                    break;
                default:
                    break;
            }
        });
    },
    eliminarMunicipio: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar este municipio?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getMunicipiosGrid().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getMunicipiosGrid().getStore().remove(record);
                    }
                    break;
                default:
                    break;
            }
        });
    },
    /**
     * Muestra el formulario
     */
    addProv: function() {
        this.getProvWindow().show();
    },
    salvarProvincia: function() {
        var formPanel = this.getProvWindow().down('form'),
                grid = this.getProvGrid(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
            this.getProvWindow().close();
        } else {//es uno nuevo
            record = Ext.create('FV.model.Provincia', values);
            grid.getStore().add(record);
            formPanel.getForm().reset();
        }
    },
    salvarMunicipio: function() {
        var formPanel = this.getProvinciaWindow().down('form'),
                grid = this.getMunicipiosGrid(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        var provRecord = this.getProvGrid().getSelectionModel().getSelection()[0];
        var prov = provRecord.get('id');
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
            this.getProvinciaWindow().close();
        } else {//es uno nuevo
            values.provincia_id = prov;
            record = Ext.create('FV.model.Municipio', values);
            grid.getStore().add(record);
            formPanel.getForm().reset();
        }
    },
    asignarMunicipios: function(source, e) {
        var record = this.getProvGrid().getSelectionModel().getSelection()[0];
        var prov = record.get('nombre');
        this.getProvinciaWindow().setTitle('Adicionar municipio a ' + prov);
        this.getProvinciaWindow().down('form').getForm().reset();
        this.getProvinciaWindow().show();
    },
    createToolTip: function(grid) {
        grid.getView().on('render', function(view) {
            view.tip = Ext.create('Ext.tip.ToolTip', {
                // The overall target element.
                target: view.el,
                // Each grid row causes its own seperate show and hide.
                delegate: view.itemSelector,
                // Moving within the row should not hide the tip.
                trackMouse: true,
                // Render immediately so that tip.body can be referenced prior to the first show.
                renderTo: Ext.getBody(),
                listeners: {
                    // Change content dynamically depending on which element triggered the show.
                    beforeshow: function updateTipBody(tip) {
                        tip.update('Click derecho para adicionar un municipio');
                    }
                }
            });
        });
    },
    createToolTip2: function(grid) {
        grid.getView().on('render', function(view) {
            view.tip = Ext.create('Ext.tip.ToolTip', {
                // The overall target element.
                target: view.el,
                // Each grid row causes its own seperate show and hide.
                delegate: view.itemSelector,
                // Moving within the row should not hide the tip.
                trackMouse: true,
                // Render immediately so that tip.body can be referenced prior to the first show.
                renderTo: Ext.getBody(),
                listeners: {
                    // Change content dynamically depending on which element triggered the show.
                    beforeshow: function updateTipBody(tip) {
                        tip.update('Click derecho para editar o eliminar');
                    }
                }
            });
        });
    },
    showContextMenu: function(view, rec, item, idx, e) {
        e.preventDefault();

        var menu = Ext.widget('provinciaContextMenu');

        // pass the contextmenu the record so we don't have to worry about a selection change	
        menu.setRecord(rec);

        // select the record that was context-clicked
        view.getSelectionModel().select(rec, false, true); // keepExisting=false, suppressEvent=true

        menu.showAt(e.getXY());
    },
    showContextMenu2: function(view, rec, item, idx, e) {
        e.preventDefault();

        var menu = Ext.widget('municipioContextMenu');

        // pass the contextmenu the record so we don't have to worry about a selection change	
        menu.setRecord(rec);

        // select the record that was context-clicked
        view.getSelectionModel().select(rec, false, true); // keepExisting=false, suppressEvent=true

        menu.showAt(e.getXY());
    },
    loadView: function(grid) {
        var provStore = grid.getStore();
        provStore.load(function(records, operation, success) {
            if (success) {
                grid.getSelectionModel().select(records[0]);
            }
        });
        //grid.getSelectionModel().select(provStore.getAt(0));
    },
    loadMunicipios: function(selModel, selected) {
        var record = selected[0];
        if (record) {
            var store = this.getMunicipiosStore();
            store.load({
                params: {
                    provincia: record.get("id")
                }
            });
        }
    }
});
