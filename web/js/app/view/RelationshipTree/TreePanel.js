Ext.define('FV.view.RelationshipTree.TreePanel', {
    extend: 'Ext.tree.Panel',
    alias: 'widget.treepanel',
    itemId: 'treepanel-panel',
    id: 'treepanel-panel',
    useArrows: true,
    multiSelect: true,
    singleExpand: true,
    rootVisible: false,
    //store: "sInventario",
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
        emptyText: 'No hay resultados para esta fecha',
        deferEmptyText: false,
        loadMask: {msg: "Cargando"}
    },
    features: [{
            id: 'group',
            ftype: 'groupingsummary',
            groupHeaderTpl: '{name}',
            enableGroupingMenu: false
        }],
    initComponent: function() {
        var me = this;
        Ext.applyIf(me, {columns: [
                {
                //treecolumn xtype tells the Grid which column will show the tree
                xtype: 'treecolumn', 
                text: 'Organismos -> Entidades -> Destinos',
                flex: 2,
                sortable: true,
                dataIndex: 'text'
                }, 
                {
                    header: 'Proveedor',
                    dataIndex: 'proveedor',
                    flex: 1
                },
                {
                    header: 'Cantidad',
                    dataIndex: 'cant',
                    //summaryType: 'sum',
                    flex: 1
                },
                {
                    header: 'Fecha',
                    dataIndex: 'fecha',
                    xtype: 'datecolumn',
                    format: 'd/m/Y',
                    hidden: false
                }

            ],
            dockedItems: [{
                    xtype: 'toolbar',
                    items: [
                        {
                            action: 'show',
                            text: 'Asignar',
                            tooltip: 'Nuevo Inventario',
                            iconCls: 'add'
                        }
                    ]
                }]

        });
        this.callParent();
    }
});






