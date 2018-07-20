public class TestDataFactory {
	
    //Account creation
    public static List<Account> createAccounts( Integer numberOfAccounts) {
        List<Account> accounts = new List<Account>();
        for ( Integer i = 0 ; i < numberOfAccounts ; i++ ) {
            Account account = new Account( Name = 'Account' + i);
            accounts.add(account);
        }
        insert accounts;
        return accounts;
    }
    
    //Contact creation
    public static List<Contact> createContacts( Integer numberOfContacts) {
        List<Contact> contacts = new List<Contact>();
        for ( Integer i = 0 ; i < numberOfContacts ; i++ ) {
            Contact contact = new Contact( FirstName = 'Contact' + i, LastName = 'Contact' + i );
            contacts.add(contact);
        }
        insert contacts;
        return contacts;
    }

}