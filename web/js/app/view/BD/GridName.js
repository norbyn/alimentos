var cellEditing4 = Ext.create('Ext.grid.plugin.CellEditing', {
    clicksToEdit: 1
});
Ext.define('FV.view.BD.GridName', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.bdGridName',
    loadMask: true,
    height: 350,
    store: 'sBD',
    plugins: [cellEditing4],
    selModel: {
        allowDeselect: true
    },
    defaults: {
        flex: 1,
        sortable: true
    },
    dockedItems: [{
            xtype: 'toolbar',
            items: [{
                    action: 'insertProduct',
                    text: 'Nuevo',
                    itemId: 'insertProduct',
                    tooltip: 'Nuevo Producto',
                    iconCls: 'add'
                }, {
                    action: 'deleteRow',
                    text: 'Eliminar',
                    itemId: 'delete',
                    tooltip: 'Eliminar',
                    iconCls: 'remove',
                    disabled: true
                }]
        }],
    listeners: {
        'selectionchange': function(view, records) {
            this.down('#delete').setDisabled(!records.length);//Se Habilita el Boton Delete
        }
    },
    viewConfig: {
        emptyText: 'No hay resultados',
        deferEmptyText: false,
        loadMask: {msg: "Cargando"}
    },
    initComponent: function() {
        this.columns = [
            new Ext.grid.RowNumberer(),
            {
                header: 'ID',
                dataIndex: 'id',
                width: 40,
                hidden: true
            },
            {
                text: 'Producto',
                dataIndex: 'Producto',
                width: 170,
                renderer: this.renderObjectColumn
            },
            /*{
                text: 'Cantidad',
                dataIndex: 'cantidad',
                width: 75,
                decimalPrecision: 4,
                field: {xtype: 'numberfield', decimalPrecision: 4, allowBlank: false, minValue: 0}
            }*/
             {
                text: 'Norma',
                dataIndex: 'Producto',
                width: 75,
                renderer: this.norma
                //decimalPrecision: 4,
                //field: {xtype: 'numberfield', decimalPrecision: 4, allowBlank: false, minValue: 0}
            },
			{
                text: 'Ajustes (+-)',
                dataIndex: 'ajuste',
                width: 75,
                decimalPrecision: 4,
                field: {xtype: 'numberfield', decimalPrecision: 4, allowBlank: false, minValue: 0}
            }
        ];
        this.callParent();
    },
    renderObjectColumn: function(obj) {
        if (obj)
            return obj.nombre;
    },
     norma: function(obj) {
        if (obj)
            return obj.norma;
    }
});







