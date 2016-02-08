Ext.define('FV.view.Organismo.Form', {
    extend: 'Ext.form.Panel',
    alias: 'widget.organismoForm',
    frame: true,
    title: 'Nuevo Organismo',
    margin: '0 0 0 10',
    padding: 10,
    defaults: {
        width: 240,
        labelWidth: 90
    },
    defaultType: 'textfield',
    initComponent: function() {
        var subordinacionStore = Ext.create('FV.store.sSubordinacion', {autoLoad: true})
        this.items = [
            {
                name: 'id',
                xtype: 'hidden'
            },{
                name: 'nombre',
                fieldLabel: 'Organismo'
            }, {
                xtype: 'combobox',
                fieldLabel: 'Subordinación',
                name: 'subordinacion_id',
                queryMode: 'local',
                store: subordinacionStore,
                displayField: 'nombre',
                editable: false,
                valueField: 'id'
            }, {
                xtype: 'checkboxfield',
                fieldLabel: 'CAP',
                name: 'is_cap',
                inputValue: true
            }, {
                xtype: 'checkboxfield',
                fieldLabel: 'Nominalizado',
                name: 'is_nominalizado',
                inputValue: true
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


