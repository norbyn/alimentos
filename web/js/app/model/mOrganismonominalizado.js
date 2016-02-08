Ext.define('FV.model.mOrganismonominalizado', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'id', type: 'int'},
        {name: 'entidad_id', type: 'int'},
        {name: 'Entidad', type: 'object'},
        {name: 'producto_id', type: 'int'},
        {name: 'Producto', type: 'object'},
        {name: 'producto_nombre', type: 'string'},
        {name: 'proveedor', type: 'string'},
        {name: 'entidad_nombre', type: 'string'},
        {name: 'ctd', type: 'float'},
        {name: 'fecha', type: 'date', dateFormat: 'Y-m-d'}
    ]
});