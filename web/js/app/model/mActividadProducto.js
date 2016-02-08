Ext.define('FV.model.mActividadProducto', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'id', type: 'int'},
        {name: 'producto_id', type: 'int'},
        {name: 'producto_nombre', type: 'string'},
        {name: 'Producto', type: 'object'},
        {name: 'actividad_id', type: 'int'},
        {name: 'Actividad', type: 'object'},
        {name: 'plan', type: 'float'},
        {name: 'actual', type: 'float'},
        {name: 'porciento', type: 'float'},
        {name: 'fecha', type: 'date', dateFormat: 'Y-m-d'}
    ]
});


