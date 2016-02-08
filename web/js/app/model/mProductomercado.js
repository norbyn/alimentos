Ext.define('FV.model.mProductomercado', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'id', type: 'int'},
        {name: 'producto_id', type: 'int'},
        {name: 'Producto', type: 'object'},
        {name: 'mercado_id', type: 'int'},
        {name: 'Mercado', type: 'object'},
        {name: 'cant', type: 'float'},
        {name: 'fecha', type: 'date', dateFormat: 'Y-m-d'}
    ]
});