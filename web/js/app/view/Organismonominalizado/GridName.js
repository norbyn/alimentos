var cellEditing1 = Ext.create('Ext.grid.plugin.CellEditing', {
    clicksToEdit: 1
});
Ext.define('FV.view.Organismonominalizado.GridName', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.nominalizadoGridName',
    loadMask: true,
    plugins: [cellEditing1],
    selModel: {
        allowDeselect: false
    },
    defaults: {
        flex: 1,
        sortable: true
    },
    viewConfig: {
        emptyText: 'No hay resultados para esta fecha',
        deferEmptyText: false,
        loadMask: {msg: "Cargando"}
    },
    dockedItems: [{
            xtype: 'toolbar',
            items: [{
                    action: 'showFormName',
                    text: 'Nuevo',
                    tooltip: 'Nueva Producto',
                    iconCls: 'add'
                }, {
                    action: 'deleteRow',
                    text: 'Eliminar',
                    tooltip: 'Eliminar',
                    iconCls: 'remove',
                    disabled: true
                }]
        }],
    initComponent: function() {
        this.columns = [
            new Ext.grid.RowNumberer(),
            {
                text: 'Producto',
                dataIndex: 'Producto',
                width: 190,
                renderer: this.renderObjectColumn
            },
            {
                text: 'Cantidad',
                dataIndex: 'ctd',
                width: 75,
                field: {xtype: 'numberfield', allowBlank: false, minValue: 0,decimalPrecision: 4}
            }
            ,
            {
                text: 'Fecha',
                dataIndex: 'fecha',
                flex: 2,
                xtype: 'datecolumn',
                format: 'd/m/Y',
                field: {xtype: 'datefield',format: 'd/m/Y'},
                hidden: false
            }
        ];
        this.callParent();
    },
    renderObjectColumn: function(obj) {
        if (obj)
            return obj.nombre;
    }
});






