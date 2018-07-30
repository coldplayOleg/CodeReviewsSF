public class PatientUpdate {
    
    public void updatePatient(List<Payment__c> payments) {
        if (!payments.isEmpty()) {
            Payment__c payment = payments.get(0);
            Visit__c visit = VisitRepository.findOneVisitById(payment.Visit__c);
            Patient__c patient = PatientRepository.findOnePatientById(visit.Patient__c);
            patient.Amount_payments__c += (Integer)payment.Amount__c;
            update patient;
        }
    }
    
}
