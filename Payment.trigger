trigger Payment on Payment__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    
	if (Trigger.isAfter) {
        
		PaymentTriggerHandler pth = new PaymentTriggerHandler();
		if (Trigger.isInsert || Trigger.isUpdate) {
			pth.updatePatient(Trigger.New, true);
		}
		if (Trigger.isDelete) {
			pth.updatePatient(Trigger.Old, false);
		}
         
    }

}
