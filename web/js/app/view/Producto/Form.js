Ext.define('FV.view.Producto.Form', {
    extend: 'Ext.form.Panel',
    alias: 'widget.productoForm',
    frame: true,
    title: 'Nuevo Producto',
    margin: '0 0 0 10',
    padding: 10,
    defaults: {
        width: 240,
        labelWidth: 90
    },
    defaultType: 'textfield',
    initComponent: function() {
        var umStore = Ext.create('FV.store.sUm', {autoLoad: true});
        var proveStore = Ext.create('FV.store.sProveedor', {autoLoad: true});
        this.items = [
            {
                name: 'id',
                xtype: 'hidden'
            }, {
                name: 'nombre',
                fieldLabel: 'Producto'
            }, {
                xtype: 'combobox',
                fieldLabel: 'Unidad de Medida',
                id: 'um_id',
                name: 'um_id',
                queryMode: 'local',
                store: umStore,
                displayField: 'nombre',
                editable: false,
                valueField: 'id'
            },
            {
                xtype: 'combobox',
                fieldLabel: 'Proveedor',
                id: 'proveedor_id',
                name: 'proveedor_id',
                queryMode: 'local',
                store: proveStore,
                displayField: 'nombre',
                editable: false,
                valueField: 'id'
            },
            {
                xtype: 'numberfield',
                name: 'norma',
                fieldLabel: 'Norma',
                decimalPrecision: 4
            },
            {
                xtype: 'button',
                text: 'Aceptar',
                width: 100,
                margin: '0 25 0 15',
                action: 'add'

            }, {
                xtype: 'button',
                text: 'Cancelar',
                width: 100,
                action: 'cancel'

            }
        ];
        this.callParent();
    }
});





