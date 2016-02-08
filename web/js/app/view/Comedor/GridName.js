var cellEditing = Ext.create('Ext.grid.plugin.CellEditing', {
    clicksToEdit: 1
});
var TC = new Ext.data.SimpleStore({
    fields: ['id', 'tc'],
    data: [['1', 'E/M'], ['2', 'E/G']]
});
Ext.define('FV.view.Comedor.GridName', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.comedoresGridName',
    loadMask: true,
    plugins: [cellEditing],
    selModel: {
        allowDeselect: true
    },
    defaults: {
        flex: 1,
        sortable: true
    },
    viewConfig: {
        emptyText: 'No hay resultados',
        deferEmptyText: false,
        loadMask: {msg: "Cargando"}
    },
    dockedItems: [{
            xtype: 'toolbar',
            items: [{
                    action: 'showFormName',
                    text: 'Nuevo',
                    tooltip: 'Nueva Comedor',
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
                header: 'ID',
                dataIndex: 'id',
                width: 40,
                hidden: true
            },
            {
                text: 'Comedor',
                dataIndex: 'TipoComedor',
                width: 170,
                renderer: this.renderObjectColumn
            },
            {
                text: 'REEUP',
                dataIndex: 'reup',
                width: 75,
                field: {xtype: 'textfield'}
            }
            ,
            {
                text: 'TC',
                dataIndex: 'tc',
                flex: 1,
                field: {
                    xtype: 'combobox',
                    forceSelection: true,
                    editable: false,
                    queryMode: 'local',
                    anchor: '96%',
                    id: 'tc_id',
                    name: 'tc_id',
                    store: TC,
                    displayField: 'tc',
                    valueField: 'tc'
                }
            }
        ];
        this.callParent();
    },
    renderObjectColumn: function(obj) {
        if (obj)
            return obj.nombre;
    }
});






