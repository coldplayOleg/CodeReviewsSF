({
	getAllLicenseH : function(component) {
		var action = component.get("c.getAllLicense");
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
                component.set("v.listLicenses", response.getReturnValue());
                if(component.get("v.newLicense") == ""){
                    component.set("v.newLicense", response.getReturnValue()[0]);
                }  
            }
        });
        $A.enqueueAction(action);
	},
    
    saveUserH : function(component) {
		var newLicense = component.get("v.newLicense");
        var newProfile = component.get("v.newProfile");
        var newUser = component.get("v.newUser");
        
		var allValid = component.find('userform').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);

        if (allValid && newUser.Username !== '' && newUser.Email !== '' && newUser.LastName !== '' && newLicense !== '' && newProfile !== '') {
            console.log('All form entries look valid. Ready to submit!');
            component.set("v.isCreating", true);
            var action = component.get("c.saveUser");
            action.setParams({
                "user": newUser,
                "profile" : newProfile,
                "license" : newLicense
            }); 
            action.setCallback(this, function(response) {
                if (response.getState() === "SUCCESS") {
                    if (response.getReturnValue()) {
                        component.set("v.isCreating", false);
                        this.showToast();
                        console.log('save user success');
                    }
                }
            });
            $A.enqueueAction(action);
        }
	},
    
    getAllProfilesH: function (component) {
        var newLicense = component.get("v.newLicense");
        var action = component.get("c.getAllProfiles");
        action.setParams({
            "license": newLicense
        }); 
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
                component.set("v.listProfiles", response.getReturnValue());
                component.set("v.newProfile", response.getReturnValue()[0]);
                if(response.getReturnValue()[0] == undefined){
                    component.set("v.newProfile","");
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    showToast: function(component, event, helper) { 
        var showToast = $A.get("e.force:showToast"); 
        showToast.setParams({ 
            'title' : 'Success!', 
            'message' : 'The user created successfully.',
            'type' : 'success'
        }); 
        showToast.fire(); 
    } 
    
})
