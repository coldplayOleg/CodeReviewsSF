@isTest
public class ContactBatchTest {
	
    @isTest
    static void test() {
        Account a1 = new Account(Name='t2testR');
        insert a1;
        Contact c1 = new Contact(LastName='Contact1', AccountId = a1.Id );
        insert c1;
        Account a2 = new Account(Name='newAccount');
        insert a2;
        Contact c2 = new Contact(LastName='Contact2', AccountId = a2.Id );
        insert c2;
	    Test.setCreatedDate(c1.Id, DateTime.now().addHours(-3));

	    Test.startTest();
        ContactBatch cb = new ContactBatch('test','Subject1', 'Body email: ', -1);
        Database.executeBatch(cb);
	    Test.stopTest();
        
        List<Contact> cl = [SELECT Id FROM Contact LIMIT 2];
        System.assertEquals(1, cl.size());
    }
}