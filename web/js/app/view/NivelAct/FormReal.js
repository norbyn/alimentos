Ext.define('FV.view.NivelAct.FormReal', {
    extend: 'Ext.window.Window',
    alias: 'widget.formReal',
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
                        title: 'Asignar el Nivel de Actividad Real del Mes',
                        anchor: '100%',
                        height: 380,
                        items: Ext.create('FV.view.NivelAct.GridRealMes')

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





