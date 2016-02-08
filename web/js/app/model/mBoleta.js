Ext.define('FV.model.mBoleta', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'id', type: 'int'},
        {name: 'entidad_id', type: 'int'},
        {name: 'Entidad', type: 'object'},
        {name: 'entidad_nombre', type: 'string'},
        {name: 'fecha', type: 'date', dateFormat: 'Y-m-d'},
        {name: 'consec', type: 'int'},
        {name: 'proveedor_id', type: 'int'},
        {name: 'Proveedor', type: 'object'},
        {name: 'proveedor_nombre', type: 'string'}
    ]
});


