public class PatientRepository {
    
	public static Patient__c findOnePatientById(Id parientId) {
        List<Patient__c> patient = [SELECT Id, Amount_payments__c FROM Patient__c WHERE Id = :parientId LIMIT 1];
        if (patient != null && !patient.isEmpty()) {
            return patient.get(0);
        }
        return new Patient__c();
    }
    
}