public class ContactRepository {
    
    public static List<Contact> findAllContactWhereAccount(Account searchAccount) {
        List<Contact> contacts = [SELECT Id FROM Contact WHERE AccountId = :searchAccount.Id];
        if (contacts.size() > 0) {
            return contacts;
        }
        return new List<Contact>();
    }
	
    public static List<Contact> findAllContact() {
        List<Contact> contacts = [SELECT Id, FirstName, LastName, AccountId FROM Contact];
        if (contacts.size() > 0) {
            return contacts;
        }
        return new List<Contact>();
    }
    
    
}