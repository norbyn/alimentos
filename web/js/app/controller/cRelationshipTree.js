Ext.define('FV.controller.cRelationshipTree', {
    extend: 'Ext.app.Controller',
    //models: ["Organismo"],
    //stores: ["Organismos"],
    views: ["RelationshipTree.TreePanel"],
    refs: [
        {ref: 'treepanel', selector: 'treepanel'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'treepanel': {
               // beforerender: this.loadView,
               // selectionchange: this.loadOrganismo
            }
        });
    },
    loadView: function(grid) {
        grid.getStore().load();
    }
   
});



