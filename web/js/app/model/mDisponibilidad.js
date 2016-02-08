Ext.define('FV.model.mDisponibilidad', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'id', type: 'int'},
        {name: 'saldo', type: 'float'},
        {name: 'Producto', type: 'object'},
        {name: 'um', type: 'string'},
        {name: 'producto_nombre', type: 'string'},
        {name: 'producto_id', type: 'string'},
        {name: 'proveedor_nombre', type: 'string'},
        {name: 'fecha', type: 'date', dateFormat: 'Y-m-d'}
    ]
});


