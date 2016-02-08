Ext.define('FV.model.mNivelActMes', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'id', type: 'int'},
        {name: 'balance_id', type: 'int'},
        {name: 'real_mes', type: 'float'},
        {name: 'BalanceAlim', type: 'object'},
        {name: 'created_at', type: 'date', dateFormat: 'Y-m-d'}
    ]
});


