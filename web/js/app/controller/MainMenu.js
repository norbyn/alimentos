//"use strict";
Ext.define('FV.controller.MainMenu', {
    extend: 'Ext.app.Controller',
    models: ["Menu"],
    stores: ["MainMenu"],
    views: ["Inventario.ContextMenu"],
    refs: [
        {ref: 'mainMenu', selector: 'mainmenu'},
        {ref: 'viewer', selector: 'viewer'}
    ],
    //requires: [],

    // At this point things haven't rendered yet since init gets called on controllers before the launch function
    // is executed on the Application
    init: function() {
        this.control({
            'mainmenu': {
                selectionchange: this.loadView
                        //itemcontextmenu: this.showContextMenu
            }
        });
    },
    onLaunch: function() {
        //this.getMainMenu().store = this.getMainMenuStore();
    },
    /**
     * Loads the given view into the viewer
     */
    loadView: function(selModel, selected) {
        var record = selected[0];

        //console.log(this.getViewer().getComponent("main-tab"));
        if (record && record.get('leaf')) {//leaf=true no tiene children
            var tab = this.getViewer().getComponent("main-tab");
            tab.setTitle(record.get('text'));
            var contPanel = tab.getComponent("content-panel"),
                    itemId = record.get("id") + "-panel",
                    item = contPanel.getComponent(itemId) || false;
            if (item) {
                contPanel.getLayout().setActiveItem(item);
            } else {
                var tempView = Ext.create("FV.view." + record.get('view'));
                contPanel.add(tempView);
                contPanel.getLayout().setActiveItem(tempView);
            }
        }
    },
    /**
     * Shows the add feed dialog window
     */
    addFeed: function() {
        this.getFeedWindow().show();
    },
    /**
     * Removes the given feed from the Feeds store
     * @param {FV.model.Feed} feed The feed to remove
     */
    removeFeed: function() {
        this.getFeedsStore().remove(this.getFeedData().getSelectionModel().getSelection()[0]);
    },
    /**
     * @private
     * Creates a new feed in the store based on a given url. First validates that the feed is well formed
     * using FV.lib.FeedValidator.
     * @param {String} name The name of the Feed to create
     * @param {String} url The url of the Feed to create
     */
    createFeed: function() {
        var win = this.getFeedWindow(),
                form = this.getFeedForm(),
                combo = this.getFeedCombo(),
                store = this.getFeedsStore(),
                feed = this.getFeedModel().create({
            name: combo.getDisplayValue(),
            url: combo.getValue()
        });

        form.setLoading({
            msg: 'Validating feed...'
        });

        FV.lib.FeedValidator.validate(feed, {
            success: function() {
                store.add(feed);
                form.setLoading(false);
                win.hide();
            },
            failure: function() {
                form.setLoading(false);
                form.down('[name=feed]').markInvalid('The URL specified is not a valid RSS2 feed.');
            }
        });
    },
    /* showContextMenu: function(view, rec, item, idx, e) {
     e.preventDefault();
     
     var menu = Ext.widget('inventario_contextmenu');
     
     // pass the contextmenu the record so we don't have to worry about a selection change	
     menu.setRecord(rec);
     
     // select the record that was context-clicked
     view.getSelectionModel().select(rec, false, true); // keepExisting=false, suppressEvent=true
     
     menu.showAt(e.getXY());
     }*/
});
