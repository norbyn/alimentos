var cell_editing = Ext.create('Ext.grid.plugin.CellEditing', {
    clicksToEdit: 1
});
Ext.define('FV.view.ActividadProducto.GridName', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.actividadesGridName',
    loadMask: true,
    plugins: [cell_editing],
    selModel: {
        allowDeselect: true
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
                    action: 'showActivities',
                    text: 'Adicionar',
                    tooltip: 'Adicionar una actividad al producto',
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
                text: 'Actividad',
                dataIndex: 'Actividad',
                width: 190,
                renderer: this.renderObjectColumn
            },
            {
                text: 'Plan',
                dataIndex: 'plan',
                width: 75,
                field: {xtype: 'numberfield', allowBlank: false, minValue: 0, decimalPrecision: 4}
            },
            {
                text: 'Real',
                dataIndex: 'actual',
                width: 75,
                field: {xtype: 'numberfield', allowBlank: false, minValue: 0, decimalPrecision: 4}
            }
            ,
            {
                text: 'Fecha',
                dataIndex: 'fecha',
                flex: 2,
                xtype: 'datecolumn',
                format: 'd/m/Y',
                field: {xtype: 'datefield', format: 'd/m/Y'},
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






