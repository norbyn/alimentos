Ext.define('FV.model.mEventos', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'id', type: 'int'},
        {name: 'entidad_id', type: 'int'},
        {name: 'Entidad', type: 'object'},
        {name: 'entidad_nombre', type: 'string'},
        {name: 'producto_id', type: 'int'},
        {name: 'Producto', type: 'object'},
        {name: 'producto_nombre', type: 'string'},
        {name: 'concepto', type: 'string'},
        {name: 'cant', type: 'float'},
        {name: 'ajuste', type: 'int'},
        {name: 'fecha', type: 'date', dateFormat: 'Y-m-d'}
    ]
});