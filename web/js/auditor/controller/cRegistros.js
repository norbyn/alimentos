//"use strict";
Ext.define('FV.controller.cRegistros', {
    extend: 'Ext.app.Controller',
    models: ["mRegistro"],
    stores: ["sRegistros"],
    views: ["Registros.Grid"],
    refs: [
        {ref: 'logGrid', selector: 'logGrid'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'logGrid': {
                beforerender: this.loadStore,
                render: this.createToolTip
            }
        });
    },
    loadStore: function(grid) {
        grid.getStore().load();
    },
    createToolTip: function(grid) {
        grid.getView().on('render', function(view) {
            view.tip = Ext.create('Ext.tip.ToolTip', {
                // The overall target element.
                target: view.el,
                // Each grid row causes its own seperate show and hide.
                delegate: view.itemSelector,
                // Moving within the row should not hide the tip.
                trackMouse: true,
                // Render immediately so that tip.body can be referenced prior to the first show.
                renderTo: Ext.getBody(),
                listeners: {
                    // Change content dynamically depending on which element triggered the show.
                    beforeshow: function updateTipBody(tip) {
                        var datetime = view.getRecord(tip.triggerElement).get('attempt_time');
                        var username = view.getRecord(tip.triggerElement).get('username');
                        var ip_address = view.getRecord(tip.triggerElement).get('ip_address');
                        var success = view.getRecord(tip.triggerElement).get('success');
                        var note = view.getRecord(tip.triggerElement).get('note');
                        tip.update('<img src="' + BASEURL + 'web/images/icons/fam/' + success + '_24.png" align="left">' + '<b style="float: right; font-size: 13px; padding-top: 4px;"> ' + note + '</b>');
                    }
                }
            });
        });
    }
});
