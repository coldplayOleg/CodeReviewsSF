@isTest
public class ContactTriggerHandlerTest {
    
    @isTest 
    static void sendMail_1() {
        ContactTriggerHandler contactTH = new ContactTriggerHandler();
        System.assertEquals(true, contactTH.sendMail('test@mail.com','subject','body'));
    }
    
    @isTest 
    static void sendMail_2() {
        ContactTriggerHandler contactTH = new ContactTriggerHandler();
        System.assertEquals(false, contactTH.sendMail('invalidEmail','subject','body'));
    }
    
    @isTest 
    static void contactWithAccountId() {
        
        List<Account> accounts = TestDataFactory.createAccounts(10);
        List<Contact> contacts = TestDataFactory.createContacts(150);
        Id accId3 = accounts.get(3).Id;
        Id accId7 = accounts.get(7).Id;
        for(Integer i = 0; i < 150; i++) {
            if (Math.mod(i,2) == 0) {
                Contact c = contacts.get(i);
                c.AccountId = accId3;
            } else {
                Contact c = contacts.get(i);
                c.AccountId = accId7;
            }
        }
        update contacts;
        
        ContactTriggerHandler contactTH = new ContactTriggerHandler();
        List<Contact> searchCon = ContactRepository.findAllContactWhereAccount(accounts.get(3));
        contactTH.contactWithAccountId('Account3', 'subject', 'body', contacts);
        
        System.assertEquals(75, searchCon.size());
	}
    
}