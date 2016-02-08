Ext.define('FV.view.Provincia.Form', {
    extend: 'Ext.window.Window',
    alias: 'widget.provinciaWindow',
    //title: 'Nuevo municipio',
    width: 250,
    height: 200,
    resizable: false,
    modal: true,
    closeAction: 'hide',
    layout: 'fit',
    initComponent: function() {
        this.items = [
            {
                xtype: 'form',
                padding: 10,
                frame: true,
                defaultType: 'textfield',
                fieldDefaults: {
                    labelAlign: 'top',
                    msgTarget: 'side'
                },
                items: [
                    {
                        name: 'id',
                        xtype: 'hidden'
                    },
                    {
                        xtype: 'textfield',
                        name: 'nombre',
                        fieldLabel: 'Municipio',
                        anchor: '96%',
                        allowBlank: false
                    }
                ]
            }
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





