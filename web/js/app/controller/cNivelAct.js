var month = '%';
var month_desc = '%';
var year = '%';
Ext.define('FV.controller.cNivelAct', {
    extend: 'Ext.app.Controller',
    stores: ["sNivelAct", "sBD", "sNivelActMes"],
    views: ['NivelAct.Form', 'BD.Form', 'BD.ContextMenu', 'NivelAct.FormReal', 'BD.FormProducto', 'BD.FormName'],
    refs: [
        {ref: 'nivelActGrid', selector: 'nivelActGrid'},
        {ref: 'gridRealMes', selector: 'gridRealMes'},
        {
            ref: 'nivelactWindow',
            selector: 'nivelactWindow',
            autoCreate: true,
            xtype: 'nivelactWindow'
        },
        {
            ref: 'baseDatosWindow',
            selector: 'baseDatosWindow',
            autoCreate: true,
            xtype: 'baseDatosWindow'
        },
        {ref: 'bdGridName', selector: 'bdGridName'},
        {ref: 'bdFormProducto', selector: 'bdFormProducto', autoCreate: true, xtype: 'bdFormProducto'},
        {ref: 'formReal', selector: 'formReal', autoCreate: true, xtype: 'formReal'},
        {ref: 'bdFormName', selector: 'bdFormName'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'nivelActGrid': {
                beforerender: this.loadStore,
                render: this.createToolTip,
                itemcontextmenu: this.showContextMenu
            },
            'nivelactWindow combobox[id=or_id]': {
                select: this.selectOrganismo
            },
            'nivelActGrid combobox[id=combo_m]': {
                select: this.loadStoreMonth
            },
            'nivelactWindow combobox[id=entidad_id2]': {
                select: this.selectEntidad
            },
            'nivelactWindow combobox[id=comedor_id]': {
                select: this.activeEvents
            },
            'nivelActGrid button[action=add]': {
                click: this.addNivelAct
            },
            'nivelactWindow button[action=create]': {
                click: this.saveNivelAct
            },
            'nivelActGrid numberfield': {
                change: this.loadStoreYear
            },
            'nivelactWindow button[action=cancel]': {
                click: this.resetForm
            },
            'bdFormName button[action=create]': {
                click: this.newBDProducto
            },
            'bdFormProducto button[action=accept]': {
                click: this.actualizarIndice
            },
            'bdContextMenu menuitem[action="assign"]': {
                click: this.asignarProductos
            },
            'bdContextMenu menuitem[action="real_mes"]': {
                click: this.asignarRealMes
            },
            'bdGridName button[action=insertProduct]': {
                click: this.showFormName
            },
            'bdFormName combobox[id=proveed_id]': {
                select: this.selectProveedor
            },
            'bdGridName button[action=deleteRow]': {
                click: this.deleteProduct
            },
            'gridRealMes button[action=insert]': {
                click: this.addRow
            },
            'gridRealMes button[action=deleteRow]': {
                click: this.deleteReal
            }
        });
    },
    deleteReal: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar el elemento seleccionado?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getGridRealMes().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getGridRealMes().getStore().remove(record);
                    }
                    break;
                default:
                    break;
            }
        });
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
        var record = this.getNivelActGrid().getSelectionModel().getSelection()[0];
        var bd_id = record.get('id');
        this.loadDependantCombo2(id, '#bd_producto_id', {
            proveedor: id,
            bd_id: bd_id
        });
    },
    showFormName: function() {
        var productosForm = Ext.widget('bdFormName');
        productosForm.show();
    },
    asignarProductos: function(source, e) {
        var record = this.getNivelActGrid().getSelectionModel().getSelection()[0];
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
    asignarRealMes: function(source, e) {
        var record = this.getNivelActGrid().getSelectionModel().getSelection()[0];
        var entidad = record.get('entidad_nombre');
        var comedor = record.get('comedor_nombre');
        this.getFormReal().setTitle(entidad + ' (' + comedor + ')');
        

        var grid = this.getGridRealMes();
        grid.getStore().proxy.url = SITEURL + "/c_balance_mes/getstore";
        grid.getStore().load({
            params: {
                balance_id: record.get('id'),
                mes:month,
                year:year
            },
            callback: function(records, operation, success) {
                if (success) {
                }
            }
        });
        this.getFormReal().show();
       
    },
    actualizarIndice: function(number) {
        var record = this.getNivelActGrid().getSelectionModel().getSelection()[0];
        //record.set('norma',record.get('nivel_act')*record.get('indice_comensal'));
        this.getBdFormProducto().down('form').updateRecord(record);
        this.getBdFormProducto().close();
    },
    addRow: function() {
        var grid = this.getNivelActGrid();
        var record = grid.getSelectionModel().getSelection()[0];
        var balance_alim_id = record.get('id');
        var model = Ext.create('FV.model.mNivelActMes', 
                {balance_id:balance_alim_id,real_mes:0,created_at:new Date()});
        this.getGridRealMes().getStore().add(model);
    },
    newBDProducto: function() {
        var mainForm = this.getBdFormProducto().down('form');
        var record = this.getNivelActGrid().getSelectionModel().getSelection()[0];
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
    }
    , showContextMenu: function(view, rec, item, idx, e) {
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
            this.getNivelActGrid().getStore().load({
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
            this.getNivelActGrid().getStore().load({
                params: {
                    mes: month,
                    year: year
                },
                callback: function(records, operation, success) {
                    if (success) {

                    }
                }
            });
        }
    },
    /**
     * Aqui vamos a mandar a cargar el store
     * 
     * @param FV.view.NivelAct.Grid grid
     */
    loadStore: function(grid) {
        grid.getStore().load();
    },
    
    /**
     * Muestra el formulario
     */
    addNivelAct: function() {
        this.getNivelactWindow().show();
    },
    saveNivelAct: function() {
        var formPanel = this.getNivelactWindow().down('form'),
                grid = this.getNivelActGrid(),
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
            values.indice_comensal = 0;
            values.norma = 0;
            record = Ext.create('FV.model.mNivelAct', values);
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
        formPanel.down('#comedor_id').disable(true);
        formPanel.down('#entidad_id2').disable(true);
        this.getNivelActGrid().getSelectionModel().deselect(record);
    },
    /**
     * Evento select del combobox de organismos
     * 
     * @param {Ext.form.field.ComboBox} combo
     */
    selectOrganismo: function(combo) {
        var id = combo.getValue();
        var container = this.getNivelactWindow().down('#event_container');
        container.setDisabled(true);
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
    /**
     * Carga en combobox que depende de otro
     * 
     * @param {int} id El valor seleccionado en el combobox1
     * @param {string} combo2Id El id del combobox2 en formato CSS. Ex: '#comboid'
     * @param {json} extraParams Parametros extra para pasar al load del store
     */
    loadDependantCombo: function(id, combo2Id, extraParams) {
        if (id) {
            var combo2 = this.getNivelactWindow().down(combo2Id),
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
    loadDependantCombo2: function(id, combo2Id, extraParams) {
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
        return this.getNivelactWindow().down('form');
    },
    activeEvents: function(combo) {
        var id = combo.getValue();
        //var data = Ext.encode(combo.displayTplData);
        var data = combo.displayTplData[0];
        var is_event = data.is_evento;
        var container = this.getNivelactWindow().down('#event_container');
        container.setDisabled(!is_event);
    }
});



