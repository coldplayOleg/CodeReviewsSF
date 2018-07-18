@isTest
public class SearchManagerTest {
	@isTest 
    static void testSearchManagerTrue() {
        List<Contact> contacts = RandomContactFactory.generateRandomContacts(7,'Name','test');
        SearchManager searchManager = new SearchManager('test', 'Subject', 'Body email: ', contacts);
        System.assertEquals(true,searchManager.searchContact());
    }
}