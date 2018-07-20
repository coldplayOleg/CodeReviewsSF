public class AccountRepository {
    
	public static Account findOneAccountByNameLike(String searchName) {
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name LIKE :('%' + searchName + '%') LIMIT 1];
        if (accounts.size() > 0) {
            Account oneAccount = accounts.get(0);
            return oneAccount;
        }
        return new Account();
    }
    
    public static List<Account> findAllAccounts() {
        List<Account> accounts = [SELECT Id, Name FROM Account];
        if (accounts.size() > 0) {
            return accounts;
        }
        return new List<Account>();
    }
    
}