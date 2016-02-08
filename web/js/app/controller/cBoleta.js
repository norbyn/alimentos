var idProveedor = '%';
var month = '%';
var month_desc = '%';
var year = '%';
var desc_prov = '%';
Ext.define('FV.controller.cBoleta', {
    extend: 'Ext.app.Controller',
    stores: ["sBoleta", "sBoletaProducto"],
    views: ['Boleta.Form', 'Boleta.ContextMenu', 'Boleta.FormProducto', 'Boleta.FormName'],
    refs: [
        {ref: 'boletasGrid', selector: 'boletasGrid'},
        {ref: 'boletasWindow', selector: 'boletasWindow', autoCreate: true, xtype: 'boletasWindow'},
        {ref: 'boletasGridName', selector: 'boletasGridName'},
        {ref: 'boletasFormProducto', selector: 'boletasFormProducto', autoCreate: true, xtype: 'boletasFormProducto'},
        {ref: 'boletaFormName', selector: 'boletaFormName'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'boletasGrid': {
                beforerender: this.loadStore,
                render: this.createToolTip,
                itemcontextmenu: this.showContextMenu
            },
            'boletaFormName button[action=create]': {
                click: this.newBoletaProducto
            },
            'boletasGridName button[action=insertProduct]': {
                click: this.showFormName
            },
            'boletasGridName button[action=deleteRow]': {
                click: this.deleteProduct
            },
            'boletasGrid combobox[id=combo_proveedor]': {
                select: this.loadStore2
            },
            'boletasGrid combobox[id=combo_montH]': {
                select: this.loadStore3
            },
            'boletasGrid numberfield': {
                change: this.loadStore4
            },
            'boletasWindow combobox[id=orgid]': {
                select: this.selectOrganismo
            },
            'boletasWindow combobox[id=entidadid]': {
                select: this.selectEntidad
            },
            'boletasWindow button[action=accept]': {
                click: this.saveBoleta
            },
            'boletasGrid button[action=add]': {
                click: this.addBoleta
            },
            'boletasWindow button[action=cancel]': {
                click: this.resetForm
            },
            'boletasGrid button[action=reporte]': {
                click: this.reporte
            },
            'boletaContextMenu menuitem[action="assign"]': {
                click: this.asignarProductos
            },
            'boletasGrid button[action="remove"]': {
                click: this.deleteBoleta
            },
            'boletasGrid menuitem[action="preview"]': {
                click: this.reporte
            },
            'boletasGrid menuitem[action="pdf"]': {
                click: this.pdf
            },
            'boletasGrid menuitem[action="excel"]': {
                click: this.excel
            }
        });
    },
    message: function(grid) {
        // Ext.example.msg('Date Selected', 'You choose .');
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
                        tip.update('Boleta #' + view.getRecord(tip.triggerElement).get('consec') + ' "' + view.getRecord(tip.triggerElement).get('Entidad').nombre + '" (Click derecho para asignar productos)');
                    }
                }
            });
        });
    },
    deleteProduct: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar este producto?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getBoletasGridName().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getBoletasGridName().getStore().remove(record);
                    }
                    break;
                default:
                    break;
            }
        });
    },
    showFormName: function() {
        var productosForm = Ext.widget('boletaFormName');
        var combo = productosForm.down("#boleta_producto_id"),
                store = combo.getStore();
        var record = this.getBoletasGrid().getSelectionModel().getSelection()[0];
        var proveedor = record.get('Proveedor').id;
        var boleta_id = record.get('id');
        store.load({
            params: {proveedor: proveedor, boleta_id: boleta_id},
            callback: function(records, operation, success) {
                if (success) {
                    productosForm.show();
                }
            }
        });

    },
    newBoletaProducto: function() {
        var mainForm = this.getBoletasFormProducto().down('form');
        var record = this.getBoletasGrid().getSelectionModel().getSelection()[0];
        var boleta_id = record.get('id');
        var formNamePanel = this.getBoletaFormName().down('form'),
                combo = formNamePanel.down("#boleta_producto_id"),
                store = combo.getStore(),
                values = mainForm.getValues();
        var grid = this.getBoletasGridName();
        values.Producto = store.getById(formNamePanel.getValues().boleta_producto_id).data;
        values.boleta_id = boleta_id;
        values.producto_id = values.Producto.id;
        values.cantidad = 0;
        var boleta_producto = Ext.create('FV.model.mBoletaProducto', values);
        grid.getStore().proxy.url = SITEURL + "/c_boletaproducto/save";
        grid.getStore().add(boleta_producto);

        this.getBoletaFormName().close();
    },
    asignarProductos: function(source, e) {
        var record = this.getBoletasGrid().getSelectionModel().getSelection()[0];
        var num = record.get('consec');
        var entidad = record.get('Entidad').nombre;
        var proveedor = record.get('Proveedor').nombre;
        this.getBoletasFormProducto().setTitle('Boleta #' + num + ' "' + entidad + '" ' + proveedor);
        this.getBoletasGridName().getStore().proxy.url = SITEURL + "/c_boletaproducto/getstore";
        this.getBoletasGridName().getStore().load({
            params: {
                boleta_id: record.get('id')
            },
            callback: function(records, operation, success) {
                if (success) {
                }
            }
        });
        this.getBoletasFormProducto().show();
    },
    showContextMenu: function(view, rec, item, idx, e) {
        e.preventDefault();

        var menu = Ext.widget('boletaContextMenu');

        // pass the contextmenu the record so we don't have to worry about a selection change	
        menu.setRecord(rec);

        // select the record that was context-clicked
        view.getSelectionModel().select(rec, false, true); // keepExisting=false, suppressEvent=true

        menu.showAt(e.getXY());
    },
    /**
     * Aqui vamos a mandar a cargar el store
     * 
     * @param Grid grid
     */
    loadStore: function(grid) {
        grid.getStore().load();
    },
    loadProductos: function(grid) {
        var formPanel = this.getBoletasWindow().down('form'),
                provStore = formPanel.down('#proveedorId').getStore(),
                values = formPanel.getValues();
        var Proveedor = provStore.getById(values.proveedorId).data;
        grid.getStore().load({
            params: {
                proveedor: Proveedor.id
            },
            callback: function(records, operation, success) {
                if (success) {
                }
            }
        });
    },
    loadStore2: function(combo) {
        var id = combo.getValue();
        var desc = combo.getRawValue();
        if (id) {
            idProveedor = id;
            desc_prov = desc;
            this.getBoletasGrid().getStore().proxy.url = SITEURL + "/c_boleta/findbyproveedor";
            this.getBoletasGrid().getStore().load({
                params: {
                    proveedor: id,
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
    loadStore3: function(combo) {
        var id = combo.getValue();
        var desc = combo.getRawValue();
        if (id) {
            month = id;
            month_desc = desc;
            this.getBoletasGrid().getStore().proxy.url = SITEURL + "/c_boleta/findbyproveedor";
            this.getBoletasGrid().getStore().load({
                params: {
                    proveedor: idProveedor,
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
    loadStore4: function(number) {
        var val = number.getValue();
        if (val) {
            year = val;
            this.getBoletasGrid().getStore().proxy.url = SITEURL + "/c_boleta/findbyproveedor";
            this.getBoletasGrid().getStore().load({
                params: {
                    proveedor: idProveedor,
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
    /**
     * Muestra el formulario
     */
    addBoleta: function() {
        var formPanel = this.getBoletasWindow().down('form').getForm();
        var consec = 1;
        Ext.Ajax.request({
            scope: this,
            params: {
                //username: form.getForm().findField('username').getValue(),
                //password: form.getForm().findField('password').getValue()
            },
            url: SITEURL + '/c_boleta/consecutivo',
            success: function(response, opts) {
                var obj = Ext.decode(response.responseText);
                //var myData = Ext.decode(obj.data);
                consec = obj.data.consec;
                formPanel.setValues({
                    consec: consec,
                    fecha: new Date()
                });
                this.getBoletasWindow().show();
            }
        });
    },
    saveBoleta: function() {
        var formPanel = this.getBoletasWindow().down('form'),
                grid = this.getBoletasGrid(),
                entStore = formPanel.down('#entidadid').getStore(),
                provStore = formPanel.down('#proveedorId').getStore(),
                record = formPanel.getRecord(),
                values = formPanel.getValues();
        if (values.id) {//es editar
            formPanel.getForm().updateRecord(record);
        } else {//es uno nuevo
            values.Entidad = entStore.getById(values.entidadid).data;
            values.Proveedor = provStore.getById(values.proveedorId).data;
            values.entidad_id = values.entidadid;
            values.proveedor_id = values.proveedorId;
            record = Ext.create('FV.model.mBoleta', values);
            grid.getStore().add(record);
            this.resetForm();
        }
    },
    deleteBoleta: function() {
        var cThis = this;
        Ext.Msg.confirm('Confirmar', 'Desea eliminar esta boleta permanentemente?', function(btn) {
            switch (btn) {
                case 'yes':
                    var record = cThis.getBoletasGrid().getSelectionModel().getSelection()[0];
                    if (record) {
                        cThis.getBoletasGrid().getStore().remove(record);
                    }
                    break;
                default:
                    break;
            }
        });
    },
    /**
     * Resetea todos los campos del formulario
     * 
     * @return {void}
     */
    resetForm: function() {
        var formPanel = this.getBoletasWindow().down('form');
        formPanel.getForm().reset();
        formPanel.down('#entidadid').disable(true);
        formPanel.down('#proveedorId').disable(true);
        this.getBoletasWindow().close();
    },
    close: function() {
        this.getBoletasWindow().close();
        this.getBoletasGrid().getStore().proxy.url = SITEURL + "/c_boleta/findbyproveedor";
        this.getBoletasGrid().getStore().load({
            params: {
                proveedor: idProveedor,
                mes: month,
                year: year
            },
            callback: function(records, operation, success) {
                if (success) {
                    // combo.setDisabled(!(records.length > 0));
                }
            }
        });
    },
    /**
     * Evento select del combobox de organismos
     * 
     * @param {Ext.form.field.ComboBox} combo
     */
    selectOrganismo: function(combo) {
        var id = combo.getValue();
        this.loadDependantCombo(id, '#entidadid', {
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
        var combo2 = this.getBoletasWindow().down("#proveedorId");
        combo2.setDisabled(false);
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
            var combo2 = this.getBoletasWindow().down(combo2Id),
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
     * Devuelve el formulario.
     * 
     * @return {Ext.form.Panel} El formulario
     */
    getFormPanel: function() {
        return this.getBoletasWindow().down('form');
    },
    pdf: function() {
        if (month === '%')
            month = -1;
        if (year === '%')
            year = new Date().getFullYear();
        if (month_desc === '%')
            month_desc = -1;
        var uri_string = SITEURL + '/reportes/generar_pdf_boleta/' + idProveedor
                + '/' + desc_prov + '/' + month + '/' + year + '/' + month_desc;
        window.location.href = uri_string;
    },
    excel: function() {
        if (month === '%')
            month = -1;
        if (year === '%')
            year = new Date().getFullYear();
        if (month_desc === '%')
            month_desc = -1;
        var uri_string = SITEURL + '/reportes/generar_xls_boleta/' + idProveedor
                + '/' + desc_prov + '/' + month + '/' + year + '/' + month_desc;
        window.location.href = uri_string;
        Ext.Msg.wait('<img src="' + BASEURL + 'web/images/icons/fam/xls.gif" style="float:left; margin-right:5px;">Generando Excel!');
        window.setTimeout(function() {
            Ext.Msg.hide();
        }, 4000);
    },
    reporte: function(grid) {
        Ext.Ajax.request({
            scope: this,
            params: {
                proveedor: idProveedor,
                mes: month,
                year: year,
                month_desc: month_desc
            },
            url: SITEURL + '/reportes/boleta',
            success: function(response, opts) {
                var obj = Ext.decode(response.responseText);
                var myData = Ext.decode(obj.data);
                var mes = obj.fecha;
                // Ext.Msg.alert('Error', response.responseText);
                var store = Ext.create('Ext.data.ArrayStore', {
                    fields: Ext.decode(obj.fields),
                    data: myData
                });
                Ext.create('Ext.window.Window', {
                    title: 'Control de boletas (' + desc_prov + ', ' + mes + ')',
                    height: 400,
                    layout: 'fit',
                    iconCls: 'preview',
                    modal: true,
                    width: 1000,
                    dockedItems: [{
                            xtype: 'toolbar',
                            items: ['->']
                        }],
                    items: {// Let's put an empty grid in just to illustrate fit layout
                        xtype: 'grid',
                        store: store,
                        stateful: true,
                        stateId: 'stateGrid',
                        columns: Ext.decode(obj.columns)
                                //title: 'Array Grid',
                        ,
                        selModel: {
                            allowDeselect: true
                        },
                        viewConfig: {
                            stripeRows: true
                        }
                    }
                }).show();
            }
        });
    }
});



