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
                    text: 'Ventana principal',
                    iconCls: 'back',
                    handler: function() {
                        var redirect = BASEURL + 'index.php/welcome';
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
