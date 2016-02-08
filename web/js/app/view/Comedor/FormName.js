Ext.define('FV.view.Comedor.FormName', {
    extend: 'Ext.window.Window',
    alias: 'widget.comedorFormName',
    title: 'Adicionar comedor para esta Entidad',
    width: 350,
    height: 100,
    resizable: false,
    modal: true,
    layout: 'fit',
    autoShow: true,
    initComponent: function() {
        var comedorNameStore = Ext.create('FV.store.sTcomedor', {autoLoad: false});
        comedorNameStore.proxy.url = SITEURL + "/tcomedor/notin";
        this.items = [
            {
                xtype: 'form',
                padding: 5,
                frame: true, items: [
                    {
                        xtype: 'combobox',
                        forceSelection: true,
                        fieldLabel: 'Nombre',
                        editable: false,
                        queryMode: 'local',
                        anchor: '96%',
                        id: 'nombre_comedor_id',
                        name: 'nombre_comedor_id',
                        store: comedorNameStore,
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








