var Language =
        {
            override:
                    {
                        // Global
                        name: 'Nombre', //used in headers for various entities
                        description: 'Descripción', //used in headers for various entities
                        refresh: 'Refrescar', // reload the data
                        result: 'Resultado',
                        save: 'Salvar',
                        cancel: 'Cancelar',
                        yes: 'Si',
                        no: 'No',
                        ok: 'Ok',
                        loading: 'Cargando...',
                        field_required: 'Este campo es requerido',
                        paging_message: 'Mostrando {0} - {1} de {2}',
                        // Proxy errors
                        server_error_title: 'Error del servidor',
                        server_error_unknown: 'Unknown error: The server did not send any information about the error.',
                        server_error_no_response: 'Unknown error: Server did not send a response.',
                        server_error_decode: 'Error decoding the response sent by the server.',
                        server_error_undefined: 'Undefined Server Error',
                        // Application tabs
                        tab_status: 'Estado',
                        tab_users: 'Usuarios',
                        tab_user_roles: 'Roles',
                        tab_permissions: 'Permisos',
                        tab_paths: 'Rutas',
                        tab_sessions: 'Sesiones',
                        tab_logs: 'Registros del sistema',
                        logout: 'Cerrar Sesión',
                        home: 'Ventana principal',
                        // User list 
                        username: 'Usuario',
                        surname: 'Apellido',
                        email: 'Email',
                        email_format: 'Este campo debe ser un e-mail con el formato "user@example.com"',
                        password: 'Contraseña',
                        password_confirm: 'Confirmar Contraseña',
                        password_change: 'Cambiar Contraseña',
                        password_match: 'Las contraseñas no coinciden',
                        password_format: 'La contraseña debe tener al menos 6 caracteres, no más de 16, y debe incluir al menos una letra mayúscula , una letra minúscula y un número.',
                        user_set_active: 'Activar usuario',
                        active: 'Activar', // Whether or not this user has been activated or deactivated
                        user_add: 'Adicionar usuario',
                        user_edit: 'Editar usuario',
                        user_delete: 'Eliminar usuario',
                        user_delete_confirm: 'Estás seguro de que quieres eliminar este usuario?',
                        user_activate: 'Activar usuario',
                        user_deactivate: 'Desactivar usuario',
                        last_ip: 'Ultima IP',
                        last_login: 'Ultimo Login',
                        created: 'Creado',
                        modified: 'Modificado',
                        never: 'Nunca',
                        user_select: 'Seleccione un usuario',
                        user_select_or: 'Seleccione un Usuario o seleccione <b>Mostrar todos</b> arriba.',
                        user_no_roles: 'No hay roles asignados a este usuario.  Seleccione <b>Mostrar todos</b> para mostrar roles disponibles',
                        user_no_perm: 'No hay permisos asignados a este usuario.  Seleccione <b>Mostrar todos</b> para mostrar permisos disponibles',
                        user_role_list: 'Roles',
                        user_role_list_for: 'Roles para', //will be followed by username
                        user_role_add: 'Adicionar usuario al rol',
                        user_role_remove: 'Eliminar usuario del rol',
                        user_perm_list: 'Permisos para la aplicación',
                        user_perm_list_for: 'Application permissions for', //wilbe followed by username
                        user_perm_add: 'Otorgar permiso de usuario',
                        user_perm_remove: 'Revocar permiso de usuario',
                        user_role_view_all: 'Mostrar todos los roles',
                        user_role_view_selected: 'Mostrar solo roles del usuario seleccionado',
                        user_perm_view_all: 'Mostrar todos los permisos',
                        user_perm_view_selected: 'Mostrar solo permisos del usuario seleccionado',
                        granted_to: 'Otorgado a', // permission is granted to user or to the user's role
                        grant_role: 'Rol',
                        grant_user: 'Usuario',
                        user_perm_granted_role: 'Permiso otorgado a través del rol',
                        user_perm_granted_user: 'Permiso otorgado al usuario',
                        // Role list
                        role_add: 'Adicionar rol',
                        role_edit: 'Editar rol',
                        role_delete: 'Eliminar rol',
                        role_delete_confirm: 'Estás seguro de que quieres eliminar este rol?',
                        role_perm_view_all: 'Mostrar todos los permisos',
                        role_perm_view_selected: 'Mostrar solo permisos del rol seleccionado',
                        role_perm_for: 'Permisos para',
                        role_select: 'Seleccione un Rol o seleccione <b>Mostrar todos</b> arriba.',
                        role_perm_add: 'Adicionar permisos al rol',
                        role_perm_remove: 'Eliminar permisos del rol',
                        // Permission list
                        perm_internal_name: 'Nombre Interno',
                        perm_add: 'Adicionar permisos',
                        perm_edit: 'Editar permisos',
                        perm_delete: 'Eliminar permisos',
                        perm_delete_confirm: 'Estás seguro de que quieres eliminar este permiso?',
                        // Path list
                        path_tab_controllers: 'Controladores',
                        path_tab_paths: 'Rutas',
                        controller_methods: 'métodos',
                        controller_public: 'público',
                        controller_private: 'privado',
                        path_verify: 'Verificando rutas de la aplicación',
                        path_refreshing: 'Actualizar rutas',
                        path_public: 'Público',
                        path_private: 'Privado',
                        path_method: 'Método', // A Codeigniter function inside a controller
                        path_path: 'Ruta',
                        path_access: 'Acceso', // Header for public/private column
                        path_permission: 'Permiso',
                        path_permissions: 'Permisos',
                        path_set_public: 'Hacer publica la ruta',
                        path_set_private: 'Hacer privada la ruta',
                        path_set_permission: 'Asignar Permiso',
                        path_remove_permission: 'Eliminar Permiso',
                        path_delete: 'Eliminar Ruta',
                        path_not_found_1: 'This method was not found in the Controller but a record of it exists in the database.',
                        path_not_found_2: 'You may delete the record of this path.',
                        // Session List
                        session_username: 'Usuario',
                        session_last_activity: 'Ultima Actividad',
                        session_ip_address: 'Dirección IP',
                        session_last_page: 'Ultima página',
                        session_user_agent: 'Navegador', // User-Agent string returned by user's browser
                        session_view_all: 'Mostrar todas las sesiones',
                        session_view_logged_in: 'Mostrar solo sesiones activas',
                        session_delete: 'Eliminar Sesión',
                        session_delete_confirm: 'Estás seguro de que quieres eliminar esta sesión?',
                        session_delete_user: 'usuario', // used in delete confirmation window title eg: "user: Bob Jones"


                        // dummy val so I don't forget to remove trailing comma
                        dummy: ''
                    }
        };
