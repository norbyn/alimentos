Ext.define('FV.view.ActividadProducto.FormName', {
    extend: 'Ext.window.Window',
    alias: 'widget.actividadesFormName',
    title: 'Nueva actividad',
    width: 350,
    height: 130,
    resizable: false,
    modal: true,
    layout: 'fit',
    autoShow: true,
    initComponent: function() {
        var activityStore = Ext.create('FV.store.sActividad', {autoLoad: true});
        this.items = [
            {
                xtype: 'form',
                padding: 5,
                frame: true, items: [
                    {
                        xtype: 'combobox',
                        forceSelection: true,
                        fieldLabel: 'Actividad',
                        editable: false,
                        queryMode: 'local',
                        anchor: '96%',
                        id: 'actividades_id',
                        name: 'actividades_id',
                        store: activityStore,
                        displayField: 'nombre',
                        valueField: 'id'
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








