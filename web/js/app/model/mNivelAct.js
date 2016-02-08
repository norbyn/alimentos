Ext.define('FV.model.mNivelAct', {
    extend: 'Ext.data.Model',
    fields: [
        /*Nivel actividad*/
        {name: 'id', type: 'int'},
        {name: 'comedor_id', type: 'int'},
        {name: 'fisico', type: 'int'},
        {name: 'nivel_act', type: 'int'},
        {name: 'almuerzo_evt', type: 'int'},
        {name: 'merienda_evt', type: 'int'},
        {name: 'comida_evt', type: 'int'},
        {name: 'indice_comensal', type: 'float'},
        {name: 'norma', type: 'float', convert: product},
        {name: 'created_at', type: 'date'},
        {name: 'updated_at', type: 'date'},
        /*Comedor*/
        {name: 'comedor_tc', type: 'string'},
        {name: 'comedor_nombre', type: 'string'},
        /*Entidad*/
        {name: 'entidad_id', type: 'int'},
        {name: 'entidad_nombre', type: 'string'}
    ]
});

function product(v, record) {
    return record.data.nivel_act * record.data.indice_comensal;
}

