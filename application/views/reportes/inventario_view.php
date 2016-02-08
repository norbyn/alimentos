<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="iso-8859-1">
        <meta name="description" content="Ejemplo de HTML5">
        <meta name="keywords" content="HTML5, CSS3, JavaScript">
        <title><?php echo $titulo ?></title>
        <link rel="stylesheet" type="text/css" href="<?php echo base_url() ?>web/js/extjs/ext-all.css">
        <link rel="stylesheet" type="text/css" href="<?php echo base_url() ?>web/css/reportes.css">
        <script type="text/javascript" src="<?php echo base_url() ?>web/js/extjs/ext-all-debug.js"></script>
        <script type="text/javascript">
            var BASEURL = "<?php echo base_url() ?>",
                    SITEURL = "<?php echo site_url() ?>";
        </script>
        <script type="text/javascript" src="<?php echo base_url() ?>web/js/extjs/transform-dom.js"></script>
    </head>
    <body>
        <table cellspacing="0" id="the-table">
            <thead>
                <tr>
                    <th>REEUP</th>
                    <th> ENTIDAD/COMEDOR</th>
                    <?php
                    foreach ($headers as $value) {
                        echo '<th>' . $value['nombre_producto'] . '</th>';
                    }
                    ?>
                </tr>
            </thead>
            <tbody>
                <?php
                foreach ($empresas as $value) {
                    echo '<tr> '
                    . '<td>' . $value['reeup'] . '</td>'
                    . '<td>' . $value['nombre_entidad'] . '</td>';
                    foreach ($headers as $v) {
                        echo '<td>' . $datos[$value['nombre_entidad']][$v['nombre_producto']] . '</td>';
                    }
                    echo '</tr>';
                }
                ?>
            </tbody>
        </table>
    </body>
</html>