({
	handleSearch: function (component, event, helper) {
        helper.getSearchUsersH(component); 
    },
    
    doEdit : function(component, event, helper) {
        helper.getCurrentUserH(component, event);
    },
    
    updateUser : function(component, event, helper) {
       	helper.updateOneUserH(component);
    },
    
    
    activeUpdate : function (component, event, helper) {
        helper.activateUser(component, event);
    },

    userLoginHistory : function (component, event, helper) {
        helper.getLoginHistory(component);
    }
    
})