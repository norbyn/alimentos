Ext.define('FV.model.mBD', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'id', type: 'int'},
        {name: 'producto_id', type: 'int'},
        {name: 'Producto', type: 'object'},
        {name: 'producto_nombre', type: 'string'},
        {name: 'norma_id', type: 'int'},
        {name: 'ajuste', type: 'float'},
        {name: 'BalanceAlim', type: 'object'},
        {name: 'balance_alim_id', type: 'int'}
    ]
});


