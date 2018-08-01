public class PatientRepository {
    
	public static List<Patient__c> findAllPatientsById(Set<Id> parientIds) {
        List<Patient__c> patients = [SELECT Id, Amount_payments__c FROM Patient__c WHERE Id IN :(parientIds) LIMIT 30000];
        if (patients != null && !patients.isEmpty()) {
            return patients;
        }
        return new List<Patient__c>();
    }
    
    public static List<Patient__c> findAllPatients() {
        List<Patient__c> patients = [SELECT Id, Amount_payments__c FROM Patient__c LIMIT 10000];
        if (patients != null && !patients.isEmpty()) {
            return patients;
        }
        return new List<Patient__c>();
    }
    
}