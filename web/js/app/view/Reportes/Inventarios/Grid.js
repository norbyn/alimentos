Ext.define('FV.view.Reportes.Inventarios.Grid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.reporte_inventariosView',
    itemId: 'inventarios-panel',
    id: 'inventarios-panel',
    height: window.innerHeight,
    layout: 'fit',
    iconCls: 'reporte',
    modal: true,
    stateful: true,
    stateId: 'stateGrid',
    columns: [],
    title: 'Array Grid',
    features: [{
            id: 'group',
            ftype: 'groupingsummary',
            groupHeaderTpl: '{name}',
            enableGroupingMenu: false
        }],
    selModel: {
        allowDeselect: true
    },
    viewConfig: {
        stripeRows: true
    }
});






