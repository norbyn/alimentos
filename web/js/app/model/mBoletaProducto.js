Ext.define('FV.model.mBoletaProducto', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'id', type: 'int'},
        {name: 'producto_id', type: 'int'},
        {name: 'Producto', type: 'object'},
        {name: 'producto_nombre', type: 'string'},
        {name: 'cantidad', type: 'float'},
        {name: 'Boleta', type: 'object'},
        {name: 'boleta_id', type: 'int'}
    ]
});


