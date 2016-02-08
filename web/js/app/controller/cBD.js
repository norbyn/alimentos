var month = '%';
var month_desc = '%';
var year = '%';
Ext.define('FV.controller.cBD', {
    extend: 'Ext.app.Controller',
    stores: ["sNivelAct", "sBD"],
    views: ['BD.Form', 'BD.ContextMenu', 'BD.FormProducto', 'BD.FormName'],
    refs: [
        {ref: 'baseDatosGrid', selector: 'baseDatosGrid'},
        {
            ref: 'baseDatosWindow',
            selector: 'baseDatosWindow',
            autoCreate: true,
            xtype: 'baseDatosWindow'
        },
        {ref: 'bdGridName', selector: 'bdGridName'},
        {ref: 'bdFormProducto', selector: 'bdFormProducto', autoCreate: true, xtype: 'bdFormProducto'},
        {ref: 'bdFormName', selector: 'bdFormName'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'baseDatosGrid': {
                beforerender: this.loadStore,
                render: this.createToolTip,
                itemcontextmenu: this.showContextMenu
            },
            'baseDatosGrid button[action=assign]': {
                click: this.asignarProductos
            },
            'bdFormName button[action=create]': {
                click: this.newBDProducto
            },
            'baseDatosWindow combobox[id=or_id]': {
                select: this.selectOrganismo
            },
            'baseDatosGrid combobox[id=combo_m]': {
                select: this.loadStoreMonth
            },
            'baseDatosWindow combobox[id=entidad_id2]': {
                select: this.selectEntidad
            },
            'baseDatosGrid button[action=add]': {
                click: this.addBD
            },
            'baseDatosWindow button[action=create]': {
                click: this.saveBD
            },
            'baseDatosGrid numberfield': {
                change: this.loadStoreYear
            },
            'bdFormProducto button[action=accept]': {
                click: this.actualizarIndice
            },
            'baseDatosWindow button[action=cancel]': {
                click: this.resetForm
            },
            'bdContextMenu menuitem[action="assign"]': {
                click: this.asignarProductos
            },
            'bdGridName button[action=insertProduct]': {
                click: this.showFormName
            },
            'bdFormName combobox[id=proveed_id]': {
                select: this.selectProveedor
            },
            'bdGridName button[action=deleteRow]': {
                click: this.deleteProduct
            }
        });
    },
    actualizarIndice: function(number) {
        var record = this.getBaseDatosGrid().getSelectionModel().getSelection()[0];
        //record.set('norma',record.get('nivel_act')*record.get('indice_comensal'));
        this.getBdFormProducto().down('form').updateRecord(record);
        this.getBdFormProducto().close();
    },
    deleteProduct: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar este producto?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getBdGridName().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getBdGridName().getStore().remove(record);
                    }
                    break;
                default:
                    break;
            }
        });
    },
    selectProveedor: function(combo) {
        var id = combo.getValue();
        var record = this.getBaseDatosGrid().getSelectionModel().getSelection()[0];
        var bd_id = record.get('id');
        this.loadDependantCombo(id, '#bd_producto_id', {
            proveedor: id,
            bd_id: bd_id
        });
    },
    newBDProducto: function() {
        var mainForm = this.getBdFormProducto().down('form');
        var record = this.getBaseDatosGrid().getSelectionModel().getSelection()[0];
        var balance_alim_id = record.get('id');
        var formNamePanel = this.getBdFormName().down('form'),
                combo = formNamePanel.down("#bd_producto_id"),
                store = combo.getStore(),
                values = mainForm.getValues();
        var grid = this.getBdGridName();
        values.Producto = store.getById(formNamePanel.getValues().bd_producto_id).data;
        values.balance_alim_id = balance_alim_id;
        values.producto_id = values.Producto.id;
        values.ajuste = 0;
        var databaseModel = Ext.create('FV.model.mBD', values);
        grid.getStore().proxy.url = SITEURL + "/c_database/save";
        grid.getStore().add(databaseModel);

        this.getBdFormName().close();
    },
    showFormName: function() {
        var productosForm = Ext.widget('bdFormName');
        productosForm.show();
    },
    asignarProductos: function(source, e) {
        var record = this.getBaseDatosGrid().getSelectionModel().getSelection()[0];
        var entidad = record.get('entidad_nombre');
        var comedor = record.get('comedor_nombre');
        this.getBdFormProducto().setTitle(entidad + ' (' + comedor + ')');
        this.getBdGridName().getStore().proxy.url = SITEURL + "/c_database/getstore";
        this.getBdGridName().getStore().load({
            params: {
                balance_alim_id: record.get('id')
            },
            callback: function(records, operation, success) {
                if (success) {
                }
            }
        });
        this.getBdFormProducto().down('form').loadRecord(record);
        this.getBdFormProducto().show();
    },
    showContextMenu: function(view, rec, item, idx, e) {
        e.preventDefault();

        var menu = Ext.widget('bdContextMenu');

        // pass the contextmenu the record so we don't have to worry about a selection change	
        menu.setRecord(rec);

        // select the record that was context-clicked
        view.getSelectionModel().select(rec, false, true); // keepExisting=false, suppressEvent=true

        menu.showAt(e.getXY());
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
                        tip.update('Click derecho para asignar productos a <a href="">' + view.getRecord(tip.triggerElement).get('comedor_nombre') + '</a>');
                    }
                }
            });
        });
    },
    loadStoreMonth: function(combo) {
        var id = combo.getValue();
        var desc = combo.getRawValue();
        if (id) {
            month = id;
            month_desc = desc;
            this.getBaseDatosGrid().getStore().load({
                params: {
                    mes: month,
                    year: year
                },
                callback: function(records, operation, success) {
                    if (success) {
                        // combo.setDisabled(!(records.length > 0));
                    }
                }
            });
        }
    },
    loadStoreYear: function(number) {
        var val = number.getValue();
        if (val) {
            year = val;
            this.getBaseDatosGrid().getStore().load({
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
        }
    },
    /**
     * Aqui vamos a mandar a cargar el store
     * 
     * @param FV.view.BD.Grid grid
     */
    loadStore: function(grid) {
        grid.getStore().load();
    },
    /**
     * Muestra el formulario
     */
    addBD: function() {
        //this.resetForm();
        this.getBaseDatosWindow().show();
    },
    saveBD: function() {
        var formPanel = this.getBaseDatosWindow().down('form'),
                grid = this.getBaseDatosGrid(),
                comStore = formPanel.down('#comedor_id').getStore(),
                entStore = formPanel.down('#entidad_id2').getStore(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
        } else {//es uno nuevo
            values.Comedor = comStore.getById(values.comedor_id).data;
            values.Entidad = entStore.getById(values.entidad_id2).data;
            values.entidad_nombre = values.Entidad.nombre;
            values.comedor_tc = values.Comedor.tc;
            values.comedor_nombre = values.Comedor.nombre;
            record = Ext.create('FV.model.mBD', values);
            grid.getStore().add(record);
        }
        this.resetForm();
    },
    /**
     * Resetea todos los campos del formulario
     * 
     * @return {void}
     */
    resetForm: function() {
        var formPanel = this.getFormPanel(),
                record = formPanel.getRecord();
        formPanel.getForm().reset();
        this.getBaseDatosGrid().getSelectionModel().deselect(record);
    },
    /**
     * Evento select del combobox de organismos
     * 
     * @param {Ext.form.field.ComboBox} combo
     */
    selectOrganismo: function(combo) {
        var id = combo.getValue();
        this.loadDependantCombo(id, '#entidad_id2', {
            organismo: id
        });
    },
    /**
     * Evento select del combobox de entidades
     * 
     * @param {Ext.form.field.ComboBox} combo
     */
    selectEntidad: function(combo) {
        var id = combo.getValue();
        this.loadDependantCombo(id, '#comedor_id', {
            entidad: id
        });
    },
    loadDependantCombo: function(id, combo2Id, extraParams) {
        if (id) {
            var combo2 = this.getBdFormName().down(combo2Id),
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
    /**
     * Devuelve el formulario para crear nivel de act.
     * 
     * @return {Ext.form.Panel} El formulario
     */
    getFormPanel: function() {
        return this.getBaseDatosWindow().down('form');
    }
});



