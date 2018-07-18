@isTest
public class SearchManagerTest {
	@isTest 
    static void testSearchManagerTrue() {
            
        List<Account> accounts = new List<Account>();
        for(Integer i = 0; i < 4; i++) {
            if (i == 2) {
                Account acc = new Account(Name = 'test');
                accounts.add(acc);
            } else {
                Account acc = new Account(Name = 'test'+i);
                accounts.add(acc);
            }
        }
    	insert accounts;
    
    	Account searchAccount = [SELECT Id FROM Account WHERE Name='test' LIMIT 1];
    	Account accountTest = [SELECT Id FROM Account WHERE Name='test1' LIMIT 1];
        
        List<Contact> contacts = new List<Contact>();
        String strF = 'NameF';
        String strL = 'NameL';
        for(Integer i = 1; i <= 150; i++) {
            if (Math.mod(i,2) == 0) {
                Contact c = new Contact(FirstName = strF+i, LastName = strL+i, AccountId = searchAccount.Id);
                contacts.add(c);
            } else {
                Contact c = new Contact(FirstName = strF+i, LastName = strL+i, AccountId = accountTest.Id);
                contacts.add(c);
            }
        }
        insert contacts;
        
        List<Contact> contactsResult = [SELECT Id FROM Contact WHERE AccountId = :searchAccount.Id];
        System.assertEquals(75, contactsResult.size());

    }
}
