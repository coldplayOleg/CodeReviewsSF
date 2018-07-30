public class PatientRepository {
    
	public static Patient__c findOnePatientById(Id parientId) {
        Patient__c patient = [SELECT Id, Amount_payments__c FROM Patient__c WHERE Id = :parientId LIMIT 1];
        if (patient != null) {
            return patient;
        }
        return new Patient__c();
    }
    
}
