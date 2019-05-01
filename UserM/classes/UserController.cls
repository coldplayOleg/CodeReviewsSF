public class UserController {

    @AuraEnabled
    public static List<String> getAllProfiles(String license) {
        List<UserLicense> licenses = [SELECT Id, Name FROM UserLicense WHERE Name =:license LIMIT 100];
        List<String> profilesName = new List<String>();
        if (!licenses.isEmpty()) {
            List<Profile> profiles = [SELECT Name FROM Profile WHERE UserLicenseId =:licenses.get(0).Id LIMIT 1000];
            for (Profile profile : profiles){
            	profilesName.add(profile.Name);
            }
        }
        return profilesName;
    }
    
    @AuraEnabled
    public static List<String> getAllLicense() {
        List<UserLicense> licenses = [SELECT Name FROM UserLicense WHERE TotalLicenses > 0 LIMIT 1000];
        List<String> licensesName = new List<String>();
        for (UserLicense license : licenses){
            licensesName.add(license.Name);
        }
        return licensesName;
    }
    
    @AuraEnabled
    public static Boolean saveUser(User user, String profile, String license) {
        Boolean result = false;
        List<UserLicense> userlicense = [SELECT Id FROM UserLicense WHERE Name =:license LIMIT 1];
        List<Profile> userProfile = [SELECT Id FROM Profile WHERE Name =:profile LIMIT 1];
        user.IsActive = false;
        user.ProfileId = userProfile.get(0).Id;
        user.Alias = user.LastName;
        user.DefaultGroupNotificationFrequency = 'N';
        user.EmailEncodingKey = 'UTF-8';
        user.TimeZoneSidKey = 'GMT';
        user.LocaleSidKey = 'en_US';
        user.LanguageLocaleKey = 'en_US';
		System.debug('User on server side: ' + user);
        try {
    		insert user;
            result = true;
		} catch(DmlException e) {
    		System.debug('The following exception has occurred when insert user: ' + e.getMessage());
		} 
        return result;
    }
    
    @AuraEnabled
    public static List<User> getSearchUsers(String searchName) {
        List<User> users =[SELECT Alias,FirstName,LastName,Name,Username 
                           FROM User WHERE Alias LIKE :('%' + searchName + '%') OR
                           FirstName LIKE :('%' + searchName + '%') OR LastName LIKE :('%' + searchName + '%')
                           OR Name LIKE :('%' + searchName + '%') OR Username LIKE :('%' + searchName + '%') LIMIT 45000];
        return users;
    }
    
    @AuraEnabled
    public static User getCurrentUser(String username) {
        List<User> user = [SELECT Email,IsActive,Name,Username,FirstName FROM User WHERE Username =:username LIMIT 1];
        return user.get(0);
    }
    
    @AuraEnabled
    public static User updateOneUser(User user) {
		System.debug(' updateOneUser on server side: ' + user);
        try {
    		update user;
		} catch(DmlException e) {
    		System.debug('The following exception has occurred when update user: ' + e.getMessage());
            return new User();
		}
        return user;
    }
    
    @AuraEnabled
    public static List<LoginHistory> loginHistory(User userH) {
        List<LoginHistory> loginHistoryList = [SELECT Browser,LoginTime,Platform,Status,UserId,SourceIp 
                                   FROM LoginHistory WHERE UserId = :userH.Id 
                                   ORDER BY LoginTime DESC NULLS LAST LIMIT 10];
        return loginHistoryList;
    }
    
}