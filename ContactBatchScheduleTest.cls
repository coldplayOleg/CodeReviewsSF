@isTest
public class ContactBatchScheduleTest {
	
    @isTest
    static void test() {
    	
        Account a1 = new Account(Name='test');
        insert a1;
        Contact c1 = new Contact(LastName='Contact1', AccountId = a1.Id );
        insert c1;
        Account a2 = new Account(Name='newAccount');
        insert a2;
        Contact c2 = new Contact(LastName='Contact2', AccountId = a2.Id );
        insert c2;
        
	    Test.setCreatedDate(c1.Id, DateTime.now().addHours(-3));
		
	    Test.startTest();
        List<AsyncApexJob> job = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors FROM AsyncApexJob];
        System.assertEquals(false, job.size() > 0);
        ContactBatch cb = new ContactBatch('test','Subject', 'Body email ', -1);
        ContactBatchSchedule cbs = new ContactBatchSchedule(100, cb);
        String sch = '0  0 15 26 7 ? 2018';
        System.schedule('job1', sch, cbs);
        Test.stopTest();
        job = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors FROM AsyncApexJob];
        System.assertEquals(true, job.size() > 0);
        
        
    }
    
}