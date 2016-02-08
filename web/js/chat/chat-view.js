jQuery(document).ready(function($) {

});
function getDate() {
    var fechaHora = new Date();
    var horas = fechaHora.getHours();
    var minutos = fechaHora.getMinutes();
    //var segundos = fechaHora.getSeconds();
    var am = ' AM';
    var pm = ' PM';
    var m = '';

    if (horas > 12) {
        horas = horas - 12;
        m = pm;
    }
    else {
        m = am;
    }
    if (horas < 10) {
        horas = '0' + horas;
    }
    if (minutos < 10) {
        minutos = '0' + minutos;
    }
    //if(segundos < 10) { segundos = '0' + segundos; }


    return horas + ':' + minutos + m;
}