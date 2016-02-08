Ext.define('FV.store.MainMenu', {
    extend: 'Ext.data.TreeStore',
    model: "FV.model.Menu",
    //autoLoad: true,
    proxy: {
        type: 'memory',
        data: {
            text: ".",
            expanded: true,
            children: [
                {text: "Nomencladores", iconCls: 'folder', leaf: false, expanded: false, children: [
                        {text: "Provincia", iconCls: 'category', leaf: true, id: "provincia", view: "Provincia.Viewer"},
                        {text: "Subordinaciones", iconCls: 'category', leaf: true, id: "nomSub", view: "Subordinacion.View"},
                        {text: "Relaciones", iconCls: 'category', leaf: true, id: "treepanel", view: "RelationshipTree.TreePanel"},
                        {text: "Organismos", iconCls: 'category', leaf: true, id: "organismo", view: "Organismo.View"},
                        {text: "Entidades", iconCls: 'category', leaf: true, id: "nomEnt", view: "Entidad.View"},
                        {text: "Proveedores", iconCls: 'category', leaf: true, id: "nomProve", view: "Proveedor.View"},
                        {text: "Productos", iconCls: 'category', leaf: true, id: "nomProd", view: "Producto.View"},
                        {text: "UM", iconCls: 'category', leaf: true, id: "nomUm", view: "Um.View"},
                        {text: "Destinos", iconCls: 'category', leaf: true, id: "nomCom", view: "Tcomedor.View"},
                        {text: "Destinos y entidades", iconCls: 'category', leaf: true, id: "comedor", view: "Comedor.Grid"},
                        {text: "Actividad", iconCls: 'category', leaf: true, id: "actividad", view: "Actividad.View"},
                        {text: "Fuentes", iconCls: 'category', leaf: true, id: "nomFtes", view: "Fuente.View"},
                        {text: "Mercados", iconCls: 'category', leaf: true, id: "nomMercado", view: "Mercado.View"}
                        //{text: "Fuentes y productos", iconCls: 'category', leaf: true, id: "fte", view: "Productofuente.View"}
                    ]},
                {text: "Balance de alimentos", leaf: false, expanded: true, children: [
                        {text: "Portada", iconCls: 'archives', leaf: true, id: "fte", view: "Productofuente.View"},
                        {text: "Nivel de Actividad", iconCls: 'archives', leaf: true, id: "nivelAct", view: "NivelAct.Grid"},
                        //{text: "Base de Datos", iconCls: 'archives', leaf: true, id: "bd", view: "BD.Grid"},
                        //{text: "Mensual (*)", iconCls: 'archives', leaf: true, id: "mensual", view: "BD.Grid"},
                        {text: "Inventario", iconCls: 'archives', leaf: true, id: "inv", view: "Inventario.Grid"},
                        {text: "Eventos y Ajustes", iconCls: 'archives', leaf: true, id: "evt", view: "Eventos.Grid"},
                        {text: "Organismo Nominalizado", iconCls: 'archives', leaf: true, id: "org_nom", view: "Organismonominalizado.Grid"},
                        {text: "Consumo Intermedio", iconCls: 'archives', leaf: true, id: "cons_inter", view: "ConsumoIntermedio.Grid"},
                        {text: "Mercados", iconCls: 'archives', leaf: true, id: "merc", view: "Productomercado.View"}
                        //{text: "Balance de Repostería", leaf: false, expanded: true, children: []}
                    ]},
                {text: "Cumplimiento de los balances", leaf: false, expanded: true, children: [
                        {text: "Actividades", iconCls: 'archives', leaf: true, id: "actividades", view: "ActividadProducto.Grid"}
                    ]},
                {text: "Control de reservas", leaf: false, expanded: true, children: [
                        {text: "Boletas", iconCls: 'archives', leaf: true, id: "boleta", view: "Boleta.Grid"},
                        {text: "Disponibilidad", iconCls: 'archives', leaf: true, id: "disponibilidad", view: "Disponibilidad.Grid"}
                    ]}
                /*,
                 {text: "Reportes", leaf: false, expanded: true, id: "rptLink", view: "", children: [
                 {text: "Modelo 01: Análisis de cifras directivas", leaf: false, expanded: false, id: "", view: "", children: [
                 {text: "Portada", leaf: true, id: "", view: ""},
                 {text: "Nivel de actividad", leaf: true, id: "", view: ""},
                 {text: "Base de datos", leaf: true, id: "", view: ""},
                 {text: "Mensual ", leaf: true, id: "", view: ""},
                 {text: "Cifras anuales", leaf: true, id: "", view: ""},
                 {text: "Inventarios", leaf: true, id: "inventarios", view: "Reportes.Inventarios.Grid"},
                 {text: "Eventos y ajustes", leaf: true, id: "", view: ""},
                 {text: "Nominalizados y otros", leaf: true, id: "", view: ""},
                 {text: "Consumos", leaf: true, id: "consumo", view: "Reportes.Consumo.View"}
                 ]},
                 {text: "Modelo 05: Control de reservas", leaf: false, expanded: false, id: "", view: "", children: [
                 {text: "MINCIN", leaf: true, id: "", view: ""},
                 {text: "CÁRNICO", leaf: true, id: "", view: ""},
                 {text: "AVÍCOLA", leaf: true, id: "", view: ""},
                 {text: "PESCA ", leaf: true, id: "", view: ""},
                 {text: "EMBER", leaf: true, id: "", view: ""},
                 {text: "LÁCTEO", leaf: true, id: "", view: ""},
                 {text: "CONSERVAS", leaf: true, id: "", view: ""},
                 {text: "CONFITERA", leaf: true, id: "", view: ""},
                 {text: "EMPRESA ALIMENTARIA", leaf: true, id: "", view: ""},
                 {text: "Boletas", leaf: true, id: "", view: ""},
                 ]}
                 ]}*/
            ]
        }
    },
    root: {
        text: 'Administrar',
        id: 'src',
        expanded: true
    }
});