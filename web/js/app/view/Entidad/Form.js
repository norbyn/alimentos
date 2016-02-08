Ext.define('FV.view.Entidad.Form', {
    extend: 'Ext.form.Panel',
    alias: 'widget.entidadForm',
    frame: true,
    title: 'Nueva Entidad',
    margin: '0 0 0 10',
    padding: 10,
    defaults: {
        width: 240,
        labelWidth: 90
    },
    defaultType: 'textfield',
    initComponent: function() {
        var organismoStore = Ext.create('FV.store.Organismos', {autoLoad: true})
        this.items = [
            {
                name: 'id',
                xtype: 'hidden'
            }, {
                name: 'nombre',
                fieldLabel: 'Entidad'
            }, {
                xtype: 'combobox',
                fieldLabel: 'Organismo',
                name: 'organismo_id',
				id: 'organismo_id',
                queryMode: 'local',
                store: organismoStore,
                displayField: 'nombre',
                editable: false,
                valueField: 'id'
            }, {
                name: 'reeup',
                fieldLabel: 'REEUP'
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



