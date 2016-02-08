Ext.define('FV.view.MainMenu', {
	extend: 'Ext.tree.Panel',
	alias: 'widget.mainmenu',

	title: 'Menú Principal',
	collapsible: true,
	animCollapse: true,
	margins: '5 0 5 5',
	layout: 'fit',
    initComponent: function() {
        this.store = "MainMenu";
        this.callParent(arguments);
    }
    //store: Ext.create("FV.store.MainMenu")
});

