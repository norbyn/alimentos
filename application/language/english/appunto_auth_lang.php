<?php

/**
 *  Text used by login form
 */
$lang['appunto_form_username'] = 'Usuario';
$lang['appunto_form_password'] = 'Clave';
$lang['appunto_form_login_button'] = 'Entrar';
$lang['appunto_form_logout_button'] = 'Logout';
$lang['appunto_form_forgot_password'] = 'Forgot Password?';
$lang['appunto_form_invalid_login'] = 'Error de usuario y/o clave.';
$lang['appunto_form_locked_user'] = 'Usuario bloqueado.';

/**
 *  Text used by reset password form
 */
$lang['appunto_form_forgot_pw_username'] = 'Usuario';
$lang['appunto_form_forgot_pw_button'] = 'Send password reset link';

/**
 *  Messages
 */
$lang['appunto_message_logout'] = 'Has finalizado la sesi&oacute;n satisfactoriamente.';
$lang['appunto_message_default_error'] = 'Error de autenticación.';

/**
 *  Errors used by library's authentication hook
 */
$lang['appunto_not_authorized'] = 'Usted no tiene permiso para acceder a esta url.';
$lang['appunto_login_required'] = 'Entre usuario y clave.';
$lang['appunto_invalid_path'] = 'Usted intenta acceder a una url incorrecta';

/**
 *  Errors used by admin UI controller
 */
$lang['appunto_errors_encountered'] = 'Errors were encountered with your request.  Please correct them and try again.';
$lang['appunto_password_strength_fail'] = 'Password must be at least 6 characters, no more than 16 characters, and must include at least one upper case letter, one lower case letter, and one numeric digit.';
$lang['appunto_permission_in_use_by_user'] = 'This permission is currently assigned to one or more users and cannot be deleted.';
$lang['appunto_permission_in_use_by_role'] = 'This permission is currently assigned to one or more roles and cannot be deleted.';
$lang['appunto_permission_in_use_by_path'] = 'This permission is currently assigned to one or more paths and cannot be deleted.';
$lang['appunto_role_in_use_by_user'] = 'This role is currently assigned to one or more users and cannot be deleted. ';
$lang['appunto_role_in_use_by_permission'] = 'There are currently one or more permissions assigned to this role and it cannot be deleted.';
$lang['appunto_path_found_in_filesystem'] = 'This path cannot be deleted because it was found on your filesystem the last time paths were verified.<br><br>Please refresh paths if you believe you have received this message in error.';
$lang['appunto_no_hook'] = 'No se ha realizado autenticación!';
$lang['appunto_set_true'] = 'Es aconsejable que se habilite este campo';
$lang['appunto_db_sessions'] = 'Manejo de sesiones usando la base de datos';
$lang['appunto_csrf_protection'] = 'Protección CSRF habilitada';
$lang['appunto_encrypted_cookies'] = 'Manejo de sesiones usando cookies encriptadas';
$lang['appunto_private_sans_perm'] = 'Rutas privadas autorizadas sin permisos asignados';
$lang['appunto_private_sans_perm_warn'] = 'Private paths without defined permissions viewable to any logged in user';
$lang['appunto_no_homonymous_controllers'] = 'AppuntoAuth does not support controller classes with the same name in different directories.';
