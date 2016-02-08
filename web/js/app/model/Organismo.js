Ext.define('FV.model.Organismo', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'id', type: 'int'},
        {name: 'subordinacion_id', type: 'int'},
        {name: 'Subordinacion', type: 'object'},
        {name: 'nombre', type: 'string'},
        {name: 'is_cap', type: 'bool'},
        {name: 'is_nominalizado', type: 'bool'}
    ]
});


