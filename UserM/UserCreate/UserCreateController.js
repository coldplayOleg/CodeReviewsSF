({
    doInit: function(component, event, helper) {
        helper.getAllLicenseH(component);
    },
    
    clickCreate: function(component, event, helper) {
        helper.saveUserH(component); 
    },
    
    handleChangeLic: function (component, event, helper) {
        helper.getAllProfilesH(component);
    },
    
    
     handleChangeProf: function (component, event) {
        component.set("v.newProfile", component.get("v.newProfile"));
    }
    
    

})