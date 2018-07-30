public class PaymentTriggerHandler {
    
    public void updatePatient(List<Payment__c> payments) {
        if (!payments.isEmpty()) {
			List<Patient__c> patients = new List<Patient__c>();
            for (Payment__c payment : payments) {
                Visit__c visit = VisitRepository.findOneVisitById(payment.Visit__c);
            	Patient__c patient = PatientRepository.findOnePatientById(visit.Patient__c);
            	patient.Amount_payments__c += (Integer)payment.Amount__c;
                patients.add(patient);
            }
            update patients;
        }
    }
    
}