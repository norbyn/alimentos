Ext.example.msg("Bienvenido", USERNAME)
Ext.define('FV.view.Toolbar', {
    extend: 'Ext.toolbar.Toolbar',
    alias: 'Toolbar',
    renderTo: document.body,
    width: 'border',
    items: [
        // begin using the right-justified button container
        '->', // same as { xtype: 'tbfill' }
        {
            text: 'Chat',
            iconCls: 'chaticon',
            handler: function() {
               
                    var chat = $('#myChat');
                    if(CHAT_CLOSED){
                        chat.addClass('visible');
                        CHAT_CLOSED = false;
                    }
                     
                    else{
                         chat.removeClass('visible');
                         CHAT_CLOSED = true;
                    }

                    var nick = $('#nicknames div span.user');
                    var channel = "";
                     nick.unbind();
                     nick.click(function () {
                        channel = this.innerHTML;
                        console.log(channel);
                        nick.removeClass('user_selected');
                        nick.addClass('user');
                        var others = $('#nicknames div span:contains("'+channel+'")');
                        others.removeClass('user');
                        others.addClass('user_selected');
                    });

                     var message = $('#btn-input');
                     var send = $('#btn-chat');
                     send.click(function(){
                       if(message.val() != "" && channel != ""){
                        socket.emit('user message',{channel:channel,
                           message:message.val()});
                        
                        var chat_viewer = $('#chat_viewer'); 
                        var date = getDate();
                        
                        //scroll bottom
                        var height = $('#chat_viewer').height();
                         $(".panel-body").animate({
                             scrollTop: height + "px"
                          });
                        
                        chat_viewer.append('<li class="right"><span class="chat-img pull-right"><img src="' 
                           + BASEURL + 'web/images/yo.png'+ '"alt="User Avatar" class="img-circle"/></span><div class="chat-body"><div class="header"><small class=" text-muted">'
                           +'<i class="fa fa-clock-o fa-fw"></i>'+ date +'</small><strong class="pull-right primary-font">'
                           +'YO'+'</strong></div><p>'+message.val()+'</p></div></li>');
                        message.val('').focus();
                       }
                       return false;
                     });  
               
                
            }
        },
        {
            text: 'Panel de control',
            iconCls: 'config',
            hidden: ROLE,
            menu: [
                {
                    text: 'Usuarios del sistema',
                    iconCls: 'settings',
                    handler: function() {
                        var redirect = BASEURL + 'index.php/appunto-auth/ui/admin';
                        window.location = redirect;
                    }
                },
                {
                    text: 'Registros de seguridad',
                    iconCls: 'alert',
                    handler: function() {
                        var redirect = BASEURL + 'index.php/auditor';
                        window.location = redirect;
                    }
                }
            ]

        }, '-',
        /*
         // add a vertical separator bar between toolbar items
         '-', // same as {xtype: 'tbseparator'} to create Ext.toolbar.Separator
         'text 1', // same as {xtype: 'tbtext', text: 'text1'} to create Ext.toolbar.TextItem
         {xtype: 'tbseparator'},
         'text 2',
         {xtype: 'tbspacer', width: 50}, // add a 50px space*/
        {
            text: USERNAME,
            iconCls: 'logged',
            menu: [{
                    text: 'Cerrar Sesión',
                    iconCls: 'closesession',
                    handler: function() {
                        Ext.Ajax.request({
                            url: BASEURL + '/index.php/appunto-auth/user/logout',
                            params: {
                            },
                            success: function(o) {
                                var redirect = BASEURL + 'index.php/appunto-auth/user/login';
                                window.location = redirect;
                            },
                            failure: function() {
                            }
                        });
                    }
                }]
        }
    ]
});
