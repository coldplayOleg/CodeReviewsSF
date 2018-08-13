({ 
	doInit : function(component, event, helper) {
        component.set('v.columns', [
                {label: 'Browser', fieldName: 'Browser', type: 'text', sortable: true},
                {label: 'Login Time', fieldName: 'LoginTime', type: 'date', sortable: true},
                {label: 'Platform', fieldName: 'Platform', type: 'text', sortable: true},
                {label: 'Status', fieldName: 'Status', type: 'text', sortable: true},
                {label: 'IP', fieldName: 'SourceIp', type: 'text', sortable: true}
        ]);
    },
    
    handleEvent : function(component, event, helper) {
        component.set("v.userLoginHistory", event.getParam("eventList"));
        if(event.getParam("eventList") !== null){
             component.set("v.isRender", true);
        } else {
        	component.set("v.isRender", false);
        }
    },
    
    updateColumnSorting: function (component, event, helper) {
        var fieldName = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        console.log("fieldName : "+ fieldName+", sortDirection : "+sortDirection);
        component.set("v.sortedBy", event.getParam("fieldName"));
    	component.set("v.sortedDirection", event.getParam("sortDirection"));
        helper.sortData(component, fieldName, sortDirection);
    }
    
})