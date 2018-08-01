trigger Payment on Payment__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    
	if (Trigger.isAfter) {
        
<<<<<<< HEAD
        PaymentTriggerHandler pth = new PaymentTriggerHandler();
        if (Trigger.isInsert) {
        	pth.updatePatient(Trigger.New, 'i');
        }
        if (Trigger.isUpdate) {
        	pth.updatePatient(Trigger.New, 'u');
        }
        if (Trigger.isDelete) {
        	pth.updatePatient(Trigger.Old, 'd');
    	}
=======
		PaymentTriggerHandler pth = new PaymentTriggerHandler();
		if (Trigger.isInsert || Trigger.isUpdate) {
			pth.updatePatient(Trigger.New, true);
		}
		if (Trigger.isDelete) {
			pth.updatePatient(Trigger.Old, false);
		}
>>>>>>> 3080d5a076d24df2d25cabda31dbc2927895ed13
         
    }

}
