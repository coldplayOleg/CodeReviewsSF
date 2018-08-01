public class PaymentTriggerHandler {
    
    public void updatePatient(List<Payment__c> payments, String s) {
        if (!payments.isEmpty()) {
            
            Map<Id,Id> visitsIdpaymentsId = new Map<Id,Id>();
            for (Payment__c paymentV : payments){
                visitsIdpaymentsId.put(paymentV.Visit__c, paymentV.Id);
            }
            List<Visit__c> visits = VisitRepository.findAllVisitById(visitsIdpaymentsId.keySet());         
            Visit__c visit = new Visit__c();
            
            Map<Id,Id> patientsIdVisitsId = new Map<Id,Id>();
            for (Visit__c visitP : visits){
                patientsIdVisitsId.put(visitP.Patient__c, visitP.Id);
            }
            List<Patient__c> patients = PatientRepository.findAllPatientsById(patientsIdVisitsId.keySet());         
            Patient__c patient = new Patient__c();
            
            List<Patient__c> updatePatients = new List<Patient__c>();
            for (Payment__c payment : payments) {
                for (Visit__c visitC : visits) {
                    if(visitC.Id.equals(payment.Visit__c)){
                        visit = visitC;
                    }
                }
                
                for (Patient__c patientC : patients) {
                    if(patientC.Id.equals(visit.Patient__c)){
                        patient = patientC;
                    }
                }
                switch on s {
                    when 'i' {
                        patient.Amount_payments__c += (Integer)payment.Amount__c;
                    }
                    when 'u' {
                        patient.Amount_payments__c = (Integer)payment.Amount__c;
                    }
                    when 'd' {
                        patient.Amount_payments__c -= (Integer)payment.Amount__c;
                    }
                }
                updatePatients.add(patient);
            }
            update updatePatients;
			
        }
    }
    
}