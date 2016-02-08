Ext.define('FV.view.Inventario.FormName', {
    extend: 'Ext.window.Window',
    alias: 'widget.inventarioFormName',
    title: 'Nuevo producto',
    width: 350,
    height: 130,
    resizable: false,
    modal: true,
    layout: 'fit',
    autoShow: true,
    initComponent: function() {
        var proveedorStore = Ext.create('FV.store.sProveedor', {autoLoad: true});
        var productoStore = Ext.create('FV.store.sProducto', {autoLoad: false});
        productoStore.proxy.url = SITEURL + "/producto/findbyproveedor";
        this.items = [
            {
                xtype: 'form',
                padding: 5,
                frame: true, items: [
                    {
                        xtype: 'combobox',
                        forceSelection: true,
                        fieldLabel: 'Proveedor',
                        editable: false,
                        queryMode: 'local',
                        anchor: '96%',
                        id: 'proveedor_id',
                        name: 'proveedor_id',
                        store: proveedorStore,
                        displayField: 'nombre',
                        valueField: 'id'
                    },
                    {
                        xtype: 'combobox',
                        forceSelection: true,
                        fieldLabel: 'Producto',
                        editable: false,
                        queryMode: 'local',
                        anchor: '96%',
                        id: 'producto_id',
                        name: 'producto_id',
                        store: productoStore,
                        displayField: 'nombre',
                        valueField: 'id',
                        disabled: true
                    }]}
        ];
        this.buttons = [{
                text: 'Aceptar',
                action: 'create'
            }, {
                text: 'Cancelar',
                scope: this,
                handler: this.close
            }];
        this.callParent();
    }
});








