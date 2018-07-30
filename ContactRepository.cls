public class ContactRepository {
    
    public static List<Contact> findAllContactWhereAccount(Account searchAccount) {
        List<Contact> contacts = [SELECT Id FROM Contact WHERE AccountId = :searchAccount.Id LIMIT 50000];
        if (contacts.size() > 0) {
            return contacts;
        }
        return new List<Contact>();
    }
    
    public static List<Contact> findAllContactWhereAccountId(Id accountId) {
        List<Contact> contacts = [SELECT Id , Name, AccountId FROM Contact WHERE AccountId = :accountId LIMIT 50000];
        if (contacts.size() > 0) {
            return contacts;
        }
        return new List<Contact>();
    }
	
    public static List<Contact> findAllContact() {
        List<Contact> contacts = [SELECT Id, FirstName, LastName, AccountId FROM Contact LIMIT 50000];
        if (contacts.size() > 0) {
            return contacts;
        }
        return new List<Contact>();
	}
    
    
}