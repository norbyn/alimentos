/*
 * This solve a 4.0.7 bug
 */
/*Ext.override(Ext.LoadMask, {
 onHide: function() {
 this.callParent();
 }
 });*/
Ext.Loader.setConfig({
    enabled: true
});
Ext.application({
    name: 'FV',
    appFolder: BASEURL + 'web/js/auditor',
    // All the paths for custom classes
    paths: {
        'Ext': BASEURL + 'web/js/extjs'
    },
    // Define all the controllers that should initialize at boot up of your application
    controllers: [
        'cRegistros'
    ],
    autoCreateViewport: true
});

