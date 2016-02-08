Ext.define('FV.view.Boleta.FormName', {
    extend: 'Ext.window.Window',
    alias: 'widget.boletaFormName',
    title: 'Nuevo producto',
    width: 350,
    height: 100,
    resizable: false,
    modal: true,
    layout: 'fit',
    autoShow: true,
    initComponent: function() {
        var productoStore = Ext.create('FV.store.sProducto', {autoLoad: false});
        productoStore.proxy.url = SITEURL + "/producto/findbyproveedorboleta";
        this.items = [
            {
                xtype: 'form',
                padding: 5,
                frame: true, items: [
                    {
                        xtype: 'combobox',
                        forceSelection: true,
                        fieldLabel: 'Producto',
                        editable: false,
                        queryMode: 'local',
                        anchor: '96%',
                        id: 'boleta_producto_id',
                        name: 'boleta_producto_id',
                        store: productoStore,
                        displayField: 'nombre',
                        valueField: 'id'
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








