Ext.define('FV.view.Comedor.Grid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.comedoresGrid',
    itemId: 'comedor-panel',
    id: 'comedor-panel',
    store: "sComedor",
    loadMask: true,
    selModel: {
        allowDeselect: true
    },
    height: window.innerHeight - 65,
    defaults: {
        flex: 1,
        sortable: true
    },
    viewConfig: {
        emptyText: 'No hay resultados',
        deferEmptyText: false,
        loadMask: {msg: "Cargando"}
    },
    features: [{
            id: 'group',
            ftype: 'groupingsummary',
            groupHeaderTpl: '{name}',
            enableGroupingMenu: false
        }],
    dockedItems: [{
            xtype: 'toolbar',
            items: [
                {
                    action: 'add',
                    text: 'Asignar',
                    tooltip: 'Asignar Comedores',
                    iconCls: 'add'
                }]
        }],
    initComponent: function() {
        this.columns = [
            new Ext.grid.RowNumberer(),
            {
                header: 'Entidad/Comedor',
                tdCls: 'group',
                dataIndex: 'nombre',
                summaryType: 'count',
                summaryRenderer: function(value) {
                    return ((value === 0 || value > 1) ? '(' + value + ' Comedores)' : '(1 Comedor)');
                },
                flex: 1
            },
            {
                header: 'REEUP',
                dataIndex: 'reup',
                flex: 1
            },
            {
                header: 'T.C.',
                dataIndex: 'tc',
                flex: 1
            }
        ];
        this.callParent();
    },
    renderObjectName: function(obj) {
        return obj.nombre;
    },
    renderObjectTC: function(obj) {
        return obj.tc;
    }
});






