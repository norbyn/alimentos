Ext.define('FV.view.Provincia.Grid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.provGrid',
    itemId: "nomProv-panel",
    store: "Provincias",
    //requires: [],
    margins: '5 5 5 5',
    cls: 'preview',
    height: 200,
    viewConfig: {
        loadMask: {msg: "Cargando..."}
    },
    listeners: {
        'selectionchange': function(view, records) {
            this.down('#deleteProv').setDisabled(!records.length);//Se Habilita el Boton Delete
            //  this.down('#edit').setDisabled(!records.length);//Se Habilita el Boton Delete
        }
    },
    initComponent: function() {
        var me = this;
        Ext.applyIf(me, {columns: [new Ext.grid.RowNumberer(),
                {header: 'Nro', dataIndex: 'id', hidden: true},
                {header: 'Provincia', dataIndex: 'nombre', flex: 1}],
            dockedItems: [{
                    xtype: 'toolbar',
                    items: [
                        {
                            action: 'add',
                            text: 'Adicionar',
                            iconCls: 'add'
                        },
                        {
                            action: 'edit',
                            text: 'Editar',
                            iconCls: 'edit'
                        },
                        {
                            action: 'remove',
                            itemId: 'deleteProv',
                            text: 'Eliminar',
                            iconCls: 'remove',
                            disabled: true
                        }]
                }
                ,
                {
                    xtype: 'pagingtoolbar', //Barra Paginadora al fondo del Grid
                    dock: 'bottom',
                    displayInfo: true,
                    store: me.store,
                    firstText: 'Primera página',
                    prevText: 'Página anterior',
                    beforePageText: 'Página',
                    afterPageText: 'de {0}',
                    nextText: 'Página siguiente',
                    lastText: 'Última página',
                    refreshText: 'Recargar',
                    displayMsg: 'Mostrando {0} - {1} de {2}',
                    emptyMsg: "No se encontraron registros"
                }
            ]
        });
        me.callParent();
    }
});
