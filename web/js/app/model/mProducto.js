Ext.define('FV.model.mProducto', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'id', type: 'int'},
        {name: 'um_id', type: 'int'},
        {name: 'Um', type: 'object'},
        {name: 'proveedor_id', type: 'int'},
        {name: 'Proveedor', type: 'object'},
        {name: 'nombre', type: 'string'},
        {name: 'norma', type: 'float'},
        {name: 'proveedor_nombre', type: 'string', convert: proveedor_nom}
    ]
});

function proveedor_nom(v, record) {
    return record.data.Proveedor.nombre;
}
