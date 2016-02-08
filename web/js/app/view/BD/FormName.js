Ext.define('FV.view.BD.FormName', {
    extend: 'Ext.window.Window',
    alias: 'widget.bdFormName',
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
        productoStore.proxy.url = SITEURL + "/producto/findbyproveedorbd";
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
                        id: 'proveed_id',
                        name: 'proveed_id',
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
                        id: 'bd_producto_id',
                        name: 'bd_producto_id',
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
                text: 'Cerrar',
                scope: this,
                handler: this.close
            }];
        this.callParent();
    }
});








