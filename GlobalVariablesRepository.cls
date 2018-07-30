public class GlobalVariablesRepository {
	
    public static String email() {
        Gloval_Variables__mdt [] glovalVariables = [SELECT Email__c FROM Gloval_Variables__mdt LIMIT 1];
        return String.valueOf(glovalVariables[0].Email__c);
    }
    
}