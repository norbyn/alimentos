Ext.define('FV.view.Boleta.FormProducto', {
    extend: 'Ext.window.Window',
    alias: 'widget.boletasFormProducto',
    width: 500,
    height: 450,
    resizable: false,
    modal: true,
    closeAction: 'hide',
    layout: 'fit',
    initComponent: function() {
        this.items = [
            {
                xtype: 'form',
                padding: 5,
                frame: true,
                fieldDefaults: {
                    labelAlign: 'top',
                    msgTarget: 'side'
                },
                items: [
                    {
                        xtype: 'fieldset',
                        title: 'ASIGNAR PRODUCTOS A LA BOLETA',
                        anchor: '100%',
                        height: 380,
                        items: Ext.create('FV.view.Boleta.GridName')

                    }
                ]
            }
        ];
        this.buttons = [{
                text: 'Cerrar',
                scope: this,
                handler: this.close
            }];
        this.callParent();
    }

});





