<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <title>ALIPLAN</title>
        <link type="image/x-icon" href="<?php echo base_url() ?>web/images/favicon.png" rel="shortcut icon">
        <link rel="stylesheet" type="text/css" href="<?php echo base_url() ?>web/js/extjs/ext-theme-gray-all.css">
        <link rel="stylesheet" type="text/css" href="<?php echo base_url() ?>web/css/style.css">
        <script type="text/javascript" src="<?php echo base_url() ?>web/js/extjs/ext-all-debug.js"></script>
        <script type="text/javascript" src="<?php echo base_url() ?>web/js/extjs/messageFlash.js"></script>
        <script type="text/javascript">
            var BASEURL = "<?php echo base_url() ?>",
                    SITEURL = "<?php echo site_url() ?>",
                    USERNAME = "<?= $this->session->userdata('username') ?>",
                    ROLE = ("<?= $this->session->userdata('role') ?>") === "Admin" ? false : true;
            // Ext.onReady(Ext.example.init, Ext.example);
        </script>
        <script type="text/javascript" src="<?php echo base_url() ?>web/js/auditor.js"></script>
    </head>
    <body>
    </body>
</html>
