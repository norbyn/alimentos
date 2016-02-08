Ext.define('FV.model.Municipio', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'id', type: 'int'},
        {name: 'nombre', type: 'string'},
        {name: 'provincia_id', type: 'int'}
    ]
});