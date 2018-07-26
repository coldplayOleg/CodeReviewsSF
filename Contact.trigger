trigger Contact on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	
    if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
        ContactTriggerHandler contactTH = new ContactTriggerHandler();
        contactTH.contactWithAccountId('test', 'subject', 'body: ', Trigger.New);
    }
      
}