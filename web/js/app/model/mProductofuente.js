Ext.define('FV.model.mProductofuente', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'id', type: 'int'},
        {name: 'producto_id', type: 'int'},
        {name: 'Producto', type: 'object'},
        {name: 'fuentes_id', type: 'int'},
        {name: 'Fuente', type: 'object'},
        {name: 'cant', type: 'float'},
        {name: 'fecha', type: 'date', dateFormat: 'Y-m-d'}
    ]
});