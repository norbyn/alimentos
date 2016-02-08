Ext.define('FV.view.Tcomedor.Form', {
    extend: 'Ext.form.Panel',
    alias: 'widget.tcomedorForm',
    frame: true,
    title: 'Nuevo Destino',
    margin: '0 0 0 10',
    padding: 10,
    defaults: {
        width: 240,
        labelWidth: 90
    },
    defaultType: 'textfield',
    initComponent: function() {
        var me = this;
        this.items = [
            {
                name: 'id',
                xtype: 'hidden'
            }, {
                name: 'nombre',
                fieldLabel: 'Destino'
            },
            {
                xtype: 'checkboxfield',
                fieldLabel: 'Evento',
                name: 'is_evento',
                inputValue: true,
                listeners: {
                    'change': function(scope, obj) {
                        me.down('#periodoId').setDisabled(scope.getValue());
                    }
                }
            },
            {
                xtype: 'numberfield',
                name: 'periodo',
                fieldLabel: 'Periodo',
                itemId: 'periodoId',
                decimalPrecision: 4,
                value: 12,
                minValue: 0
            },
            {
                xtype: 'button',
                text: 'Aceptar',
                width: 100,
                margin: '0 25 0 15',
                action: 'add'

            },
            {
                xtype: 'button',
                text: 'Cancelar',
                width: 100,
                action: 'cancel'

            }
        ];
        this.callParent();
    }
});








