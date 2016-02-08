Ext.define('FV.view.BD.FormProducto', {
    extend: 'Ext.window.Window',
    alias: 'widget.bdFormProducto',
    width: 500,
    height: 450,
    resizable: false,
    modal: true,
    closable: false,
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
                        xtype: 'numberfield',
                        name: 'indice_comensal',
                        fieldLabel: 'INDICE COMENSAL/FISICO',
                        //anchor: '96%',
                        allowBlank: false,
                        id: 'indice_comensalId',
                        decimalPrecision: 4,
                        minValue: 0,
                        value: 0
                    },
                    {
                        xtype: 'fieldset',
                        title: 'ASIGNAR PRODUCTOS AL DESTINO',
                        anchor: '100%',
                        height: 380,
                        items: Ext.create('FV.view.BD.GridName')

                    }
                ]
            }
        ];
        this.buttons = [{
                text: 'Aceptar',
                action: 'accept'
            },
            {
                text: 'Cerrar',
                scope: this,
                handler: this.close
            }];
        this.callParent();
    }

});





