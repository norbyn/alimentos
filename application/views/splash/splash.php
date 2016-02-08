<!--
To change this template, choose Tools | Templates
and open the template in the editor.
-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta http-equiv="pragma" content="no-cache" />
        <style type="text/css">
            body{
                background-color : #F1F8FF;
            }
        </style>
        <script type="text/javascript">
            function redirect(location) {
                window.location = location;
            }
            window.setTimeout((("<?= $this->session->userdata('role') ?>") === "Auditor" ? "redirect('<?php echo site_url('auditor'); ?>')" : "redirect('<?php echo site_url('welcome'); ?>')"), <?php echo TIEMPO_SPLASH ?>);
        </script>
    </head>

    <body>
        <table style="width: 100%; height: 100%; text-align: center; vertical-align: middle;">
            <tr>
                <td style="width: 100%; height: 100%; text-align: center; vertical-align: middle;">
                    <img src="<?php echo base_url() ?>web/images/loading.gif"/>
                    <div style="color:#0099CC;font-size:17px;">Cargando Aliplan...</div>
                </td>
            </tr>
        </table>
        <div >
        </div>
    </body>

</html>
