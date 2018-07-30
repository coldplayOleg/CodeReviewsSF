trigger Payment on Payment__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    
	if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
         PatientUpdate pu = new PatientUpdate();
         pu.updatePatient(Trigger.New);
    }
    
}
