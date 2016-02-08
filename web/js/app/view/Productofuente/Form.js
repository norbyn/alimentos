Ext.define('FV.view.Productofuente.Form', {
    extend: 'Ext.form.Panel',
    alias: 'widget.productofuenteForm',
    frame: true,
    title: 'Nuevo',
    margin: '0 0 0 10',
    padding: 10,
    defaults: {
        width: 240,
        labelWidth: 90
    },
    defaultType: 'textfield',
    initComponent: function() {
        var proveedorStore = Ext.create('FV.store.sProveedor', {autoLoad: true});
        var productoStore = Ext.create('FV.store.sProducto', {autoLoad: false});
        productoStore.proxy.url = SITEURL + "/producto/findbyproveedor";
        var fuenteStore = Ext.create('FV.store.sFuente', {autoLoad: true});
        this.items = [
            {
                name: 'id',
                xtype: 'hidden'
            }, {
                xtype: 'combobox',
                fieldLabel: 'Proveedor',
                id: 'fuente_proveedor_id',
                name: 'fuente_proveedor_id',
                queryMode: 'local',
                store: proveedorStore,
                displayField: 'nombre',
                editable: false,
                valueField: 'id'
            }, {
                xtype: 'combobox',
                fieldLabel: 'Producto',
                id: 'producto_id',
                name: 'producto_id',
                queryMode: 'local',
                store: productoStore,
                displayField: 'nombre',
                editable: false,
                valueField: 'id'
            }, {
                xtype: 'combobox',
                fieldLabel: 'Fuente',
                id: 'fuentes_id',
                name: 'fuentes_id',
                queryMode: 'local',
                store: fuenteStore,
                displayField: 'nombre',
                editable: false,
                valueField: 'id'
            },
            {
                name: 'cant',
                fieldLabel: 'Cantidad'
            },
            {
                xtype: 'datefield',
                name: 'fecha',
                fieldLabel: 'Fecha',
                format: 'Y-m-d',
                value: new Date()
            },
            {
                xtype: 'button',
                text: 'Aceptar',
                width: 80,
                margin: '0 25 0 15',
                action: 'add'

            }, {
                xtype: 'button',
                text: 'Cancelar',
                width: 80,
                action: 'cancel'

            }
        ];
        this.callParent();
    }
});








