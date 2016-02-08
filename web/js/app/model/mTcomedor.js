Ext.define('FV.model.mTcomedor', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'id', type: 'int'},
        {name: 'nombre', type: 'string'},
        {name: 'is_evento', type: 'bool'},
        {name: 'periodo', type: 'float'}
    ]
});