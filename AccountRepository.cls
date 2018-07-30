public class AccountRepository {
    
	public static Account findOneAccountByNameLike(String searchName) {
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name LIKE :('%' + searchName + '%') LIMIT 1];
        if (accounts.size() > 0) {
            Account oneAccount = accounts.get(0);
            return oneAccount;
        }
        return new Account();
    }
    
    public static List<Account> findAllAccountsById(Set<Id> accountsId) {
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Id IN :accountsId LIMIT 50000];
        if (accounts.size() > 0) {
            return accounts;
        }
        return new List<Account>();
    }
    
    public static List<Account> findAllAccounts() {
        List<Account> accounts = [SELECT Id, Name FROM Account LIMIT 50000];
        if (accounts.size() > 0) {
            return accounts;
        }
        return new List<Account>();
	}
    
}