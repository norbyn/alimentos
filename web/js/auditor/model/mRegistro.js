Ext.define('FV.model.mRegistro', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'id', type: 'int'},
        {name: 'attempt_time', type: 'date', dateFormat: 'Y-m-d H:i:s'},
        {name: 'username', type: 'string'},
        {name: 'ip_address', type: 'string'},
        {name: 'success', type: 'boolean'},
        {name: 'user_agent', type: 'string'},
        {name: 'note', type: 'string'}
    ]
});