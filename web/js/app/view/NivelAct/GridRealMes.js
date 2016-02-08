var cellEditing4 = Ext.create('Ext.grid.plugin.CellEditing', {
    clicksToEdit: 1
});
Ext.define('FV.view.NivelAct.GridRealMes', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.gridRealMes',
    loadMask: true,
    height: 350,
    store: 'sNivelActMes',
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
                    action: 'insert',
                    text: 'Nuevo',
                    itemId: 'insert',
                    iconCls: 'add'
                }, {
                    action: 'deleteRow',
                    text: 'Eliminar',
                    itemId: 'delete',
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
                header: 'Balance',
                dataIndex: 'balance_id',
                width: 40,
                hidden: true
            },
            {
                text: 'Nivel de Act Real',
                dataIndex: 'real_mes',
                flex: 2,
                decimalPrecision: 4,
                field: {xtype: 'numberfield', decimalPrecision: 4, allowBlank: false, minValue: 0}
            },
             {
                text: 'Fecha',
                dataIndex: 'created_at',
                flex: 2,
                xtype: 'datecolumn',
                format: 'd/m/Y',
                field: {xtype: 'datefield',format: 'd/m/Y'},
                hidden: false
            }
        ];
        this.callParent();
    }
});







