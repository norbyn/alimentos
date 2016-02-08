Ext.define('FV.model.Menu', {
    extend: 'Ext.data.Model',
    
    /*proxy: {
        type: 'memory'
    },*/
    
    fields: [
        {name: 'id',  type: 'string'},
        {name: 'text',  type: 'string'},
        {name: 'view', type: 'string'}
    ]
});
