Ext.define('FV.model.mEntidad', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'id', type: 'int'},
        {name: 'organismo_id', type: 'int'},
        {name: 'Organismo', type: 'object'},
        {name: 'nombre', type: 'string'},
        {name: 'reeup', type: 'string'}
    ]
});





