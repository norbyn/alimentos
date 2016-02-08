Ext.define('FV.view.Mercado.Form', {
    extend: 'Ext.form.Panel',
    alias: 'widget.mercadoForm',
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
        this.items = [
            {
                name: 'id',
                xtype: 'hidden'
            }, {
                name: 'nombre',
                fieldLabel: 'Nombre'
            }, {
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








