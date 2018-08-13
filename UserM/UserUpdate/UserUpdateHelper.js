({
    
    transferLoginHistory : function(component, response) {
        var cmpEvent = $A.get("e.c:UserLoginHistoryEvent");
        if(response != null){
            cmpEvent.setParams({ "eventList" : response.getReturnValue()});
        } else {
            cmpEvent.setParams({ "eventList" : null});
        }
        cmpEvent.fire();
    },
    
    showToast: function(type, msg) { 
        var showToast = $A.get("e.force:showToast"); 
        showToast.setParams({ 
            'title' : '', 
            'message' : msg,
            'type' : type
        }); 
        showToast.fire(); 
    },
    
	getSearchUsersH : function(component) {
		component.set("v.currentUser", null);
        var searchUser = component.get("v.searchUser");
        if(searchUser.length == 0){
        	this.transferLoginHistory(component, null);
        }
        if(searchUser.length > 2){
            component.set("v.isSearching", true);
            var action = component.get("c.getSearchUsers");
            action.setParams({
                "searchName": searchUser
            }); 
            action.setCallback(this, function(response) {
                if (response.getState() === "SUCCESS") {
                    component.set("v.listUsers", response.getReturnValue());
                    component.set("v.isSearching", false);
                    this.transferLoginHistory(component, null);
                } 
            });
            $A.enqueueAction(action);
        } else {
            component.set("v.listUsers", null);
        }
	},
    
    getCurrentUserH : function(component, event) {
		var btnClicked = event.getSource();
        var username = btnClicked.get("v.value");
        var action = component.get("c.getCurrentUser");
        action.setParams({
                "username": username
        }); 
		action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
                component.set("v.listUsers", null);
                component.set("v.currentUser", response.getReturnValue());
                this.transferLoginHistory(component, null);
           	} 
       	});
       	$A.enqueueAction(action);
	},
    
    getLoginHistory : function(component) {
		var userH = component.get("v.currentUser");
        var action = component.get("c.loginHistory");
        action.setParams({
            "userH": userH
        }); 
        action.setCallback(this, function(response) {
            if(response.getState() === "SUCCESS"){
                if(response.getReturnValue().length > 5){
                    this.transferLoginHistory(component, response);
                } else {
                    this.showToast('info','Login history is empty.');
                    this.transferLoginHistory(component, null);
                }  
            }
        });
        $A.enqueueAction(action);
	},
    
    activateUser : function(component, event) {
		component.set("v.isNotUpdating", false);
        var label = event.getSource().get("v.label")
        var currentUser = component.get("v.currentUser");
        if(label == "Deactivate"){
            currentUser.IsActive = false;
        } else {
            currentUser.IsActive = true;
        }
        var action = component.get("c.updateOneUser");
        action.setParams({
            "user": currentUser,
        }); 
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
            	component.set("v.currentUser", response.getReturnValue());
                component.set("v.isNotUpdating", true);
                this.showToast('success','The user updated successfully.');
            }
        });
        $A.enqueueAction(action);
	},
    
    updateOneUserH : function(component) {
        component.set("v.isNotUpdating", false);
        var currentUser = component.get("v.currentUser");
        var action = component.get("c.updateOneUser");
        action.setParams({
            "user": currentUser,
        }); 
        action.setCallback(this, function(response) {

            if (response.getState() === "SUCCESS" && response.getReturnValue() !== null){
                    component.set("v.isNotUpdating", true);
                    component.set("v.currentUser", response.getReturnValue());
					this.showToast('success','The user updated successfully.');
            }
        });
        $A.enqueueAction(action);
	}
})