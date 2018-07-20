@isTest
public class AccountRepositoryTest {
	
    @isTest 
    static void findOneAccountByNameLike_1() {
        List<Account> accounts = TestDataFactory.createAccounts(10);
        Account acc = AccountRepository.findOneAccountByNameLike('Account3');
        System.assertEquals('Account3', acc.Name);
    }
    
    @isTest 
    static void findOneAccountByNameLike_2() {
        List<Account> accounts = TestDataFactory.createAccounts(10);
        Account acc = AccountRepository.findOneAccountByNameLike('falseTest');
        System.assertEquals(null, acc.Name);
    }
    
    @isTest 
    static void findAllAccounts_1() {
        List<Account> accounts = TestDataFactory.createAccounts(10);
        List<Account> accountsAll = AccountRepository.findAllAccounts();
        System.assertEquals(10, accountsAll.size());
    }
    
    @isTest 
    static void findAllAccounts_2() {
        List<Account> accountsAll = AccountRepository.findAllAccounts();
        System.assertEquals(0, accountsAll.size());
    }
    
}