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
    
    //@isTest 
    static void test() {
        List<Account> accounts = TestDataFactory.createAccounts(100);
        List<Contact> contacts = TestDataFactory.createContacts(150);
        Id accId3 = accounts.get(3).Id;
        Id accId7 = accounts.get(7).Id;
        Id accId9 = accounts.get(9).Id;
        Id accId12 = accounts.get(12).Id;
        for(Integer i = 0; i < 150; i++) {
            if (Math.mod(i,2) == 0) {
                Contact c = contacts.get(i);
                c.AccountId = accId3;
            } else if ((i - 10) < 10) {
                Contact c = contacts.get(i);
                c.AccountId = accId7;
            } else {
                Contact c = contacts.get(i);
                c.AccountId = accId12;
            }
        }
        update contacts;
        
        List<Contact> contAll = ContactRepository.findAllContact();
        Set<Id> accountsId = new Set<Id>();
        for(Contact contact : contAll){
            accountsId.add(contact.AccountId);    
        }
        List<Account> accountsList = AccountRepository.findAllAccountsById(accountsId);
        Account searchAccount = new Account();
        for (Integer i = 0; i < accountsList.size(); i++){
            if (String.valueOf(accountsList.get(i).Name).containsIgnoreCase('AcCounT7')){
                searchAccount = accountsList.get(i);
            }
        }
        List<Contact> contactsWithId = ContactRepository.findAllContactWhereAccountId(searchAccount.Id);
        List<Contact> contactsToDelete = new List<Contact>();
        for (Contact contact : contactsWithId){
            if(contact.LastModifiedDate.addHours(24) <= Datetime.now()) {
                contactsToDelete.add(contact);
            }
        }
        delete contactsToDelete;
        System.assertEquals(150, contAll.size());
    }
    
}