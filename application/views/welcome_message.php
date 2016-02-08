<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <title>ALIPLAN</title>
        <link type="image/x-icon" href="<?php echo base_url() ?>web/images/favicon.png" rel="shortcut icon">
        <link rel="stylesheet" type="text/css" href="<?php echo base_url() ?>web/js/extjs/ext-theme-gray-all.css">
        <link rel="stylesheet" type="text/css" href="<?php echo base_url() ?>web/css/style.css">
        <link rel="stylesheet" type="text/css" href="<?php echo base_url() ?>web/css/chat.css">
        <script type="text/javascript" src="<?php echo base_url() ?>web/js/extjs/ext-all-debug.js"></script>
        <script type="text/javascript" src="<?php echo base_url() ?>web/js/extjs/messageFlash.js"></script>
        <script type="text/javascript">
            var BASEURL = "<?php echo base_url() ?>",
                    SITEURL = "<?php echo site_url() ?>",
                    USERNAME = "<?= $this->session->userdata('username') ?>",
                    ROLE = ("<?= $this->session->userdata('role') ?>") === "Admin" ? false : true;
            var CHAT_CLOSED = true;
            var SOCKET_IO = "<?php echo SOCKET_IO_URL ?>";
            // Ext.onReady(Ext.example.init, Ext.example);
        </script>
        <script type="text/javascript" src="<?php echo base_url() ?>web/js/chat/jquery-1.10.2.js"></script>
        <script type="text/javascript" src="<?php echo base_url() ?>web/js/chat/socket.io-client/socket.io.js"></script>
        <script type="text/javascript" src="<?php echo base_url() ?>web/js/chat/chat-socket.js"></script>
        <script type="text/javascript" src="<?php echo base_url() ?>web/js/chat/chat-view.js"></script>
        <script type="text/javascript" src="<?php echo base_url() ?>web/js/app.js"></script>
    </head>
    <body>
        <!--div id="nickname"><?= $this->session->userdata('username') ?></div-->

        <div class="chat-panel panel panel-default" id='myChat'>
            <div class="panel-heading">
                <img src="<?php //echo base_url() ?>web/images/icons/fam/user_comment.png"/>
                <p class="chat-title">Chat</p> 
            </div>
            <div panel-container>
                <div class="panel-tree" id="nicknames">

                </div>
                <div class="panel-body">
                    <ul class="chat" id="chat_viewer">
                    </ul>
                </div>
            </div>
            <div class="panel-footer">
                <div class="input-group">
                    <input id="btn-input" type="text" class="form-control input-sm" placeholder="Escribe el mensaje..." />
                    <span class="input-group-btn">
                        <button class="button btn btn-warning btn-sm" id="btn-chat">
                            Enviar
                        </button>
                    </span>
                </div>
            </div>
        </div>
    </body>
</html>