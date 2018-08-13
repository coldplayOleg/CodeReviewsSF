({ 
	doInit : function(component, event, helper) {
        component.set('v.columns', [
                {label: 'Browser', fieldName: 'Browser', type: 'text'},
                {label: 'Login Time', fieldName: 'LoginTime', type: 'date'},
                {label: 'Platform', fieldName: 'Platform', type: 'text'},
                {label: 'Status', fieldName: 'Status', type: 'text'},
                {label: 'IP', fieldName: 'SourceIp', type: 'text'}
        ]);
    },
    
    handleEvent : function(component, event, helper) {
        component.set("v.userLoginHistory", event.getParam("eventList"));
        if(event.getParam("eventList") !== null){
             component.set("v.isRender", true);
        } else {
        	component.set("v.isRender", false);
        }
    }
    
})