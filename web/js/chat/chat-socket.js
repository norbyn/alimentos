var socket = io(SOCKET_IO);
socket.on('connect', function() {

    var nickname = USERNAME;
    socket.emit('nickname', nickname);

    socket.on('nicknames', function(data) {
        $('#nicknames').empty().append($('<div>'));
        for (var i = 0; i < data.length; i++) {
            if (data[i] !== nickname) {
                $('#nicknames div').append('<img src="' + BASEURL + 'web/images/icons/fam/user.png' + '"><span  class="user">' + data[i] + '</span><br>');
            }
        }
    });

    var chat_viewer = $('#chat_viewer');
    socket.on('user message' + nickname, function(data) {
        if (CHAT_CLOSED) {
            Ext.example.msg("Mensaje de " + data.nickname, data.message);
        }

        //scroll bottom
        var height = $('#chat_viewer').height();
        $(".panel-body").animate({
            scrollTop: height + "px"
        });

        var date = getDate();
        chat_viewer.append('<li class="left"><span class="chat-img pull-left"><img src="'
                + BASEURL + 'web/images/user.png' + '"alt="User Avatar" class="img-circle"/></span><div class="chat-body"><div class="header"><strong class="primary-font">'
                + data.nickname + '</strong><small class="pull-right text-muted"><i class="fa fa-clock-o fa-fw"></i>' + date + '</small></div><p>'
                + data.message + '</p></div></li>');

    });

});