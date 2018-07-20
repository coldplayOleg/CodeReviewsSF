@isTest
public class ContactRepositoryTest {
	
    @isTest 
    static void findAllContactWhereAccount_1() {
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
        
        List<Contact> contL = ContactRepository.findAllContactWhereAccount(accounts.get(3));
        System.assertEquals(75, contL.size());
    }
	
	@isTest 
    static void findAllContactWhereAccount_2() {
        List<Account> accounts = TestDataFactory.createAccounts(10);
        Id accId3 = accounts.get(3).Id;
        List<Contact> contL = ContactRepository.findAllContactWhereAccount(accounts.get(3));
        System.assertEquals(0, contL.size());
    }
	    
    @isTest 
    static void findAllContact_1() {
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
        
        List<Contact> contAll = ContactRepository.findAllContact();
        System.assertEquals(150, contAll.size());
    }
    
    @isTest 
    static void findAllContact_2() {
        List<Contact> contAll = ContactRepository.findAllContact();
        System.assertEquals(0, contAll.size());
    }
    
}