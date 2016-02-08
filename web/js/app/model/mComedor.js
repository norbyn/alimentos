Ext.define('FV.model.mComedor', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'id', type: 'int'},
        {name: 'entidad_id', type: 'int'},
        {name: 'Entidad', type: 'object'},
        {name: 'nombre_comedor_id', type: 'int'},
        {name: 'TipoComedor', type: 'object'},
        {name: 'reup', type: 'string'},
        {name: 'nombre', type: 'string'},
        {name: 'tc', type: 'string'},
        {name: 'entidad_nombre', type: 'string'},
        {name: 'is_evento', type: 'boolean'}
        
    ]
});



