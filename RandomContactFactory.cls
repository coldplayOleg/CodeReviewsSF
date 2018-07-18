public class RandomContactFactory {
    
    public static List<Contact> generateRandomContacts(Integer num, String str, String accName) {
        if(num == null || num <= 0)
            num = 1;
        if(str == null || str == '')
            str = 'TestName';
        if(accName == null)
            accName = 'test';
        
        //Account acc = [SELECT Id, Name FROM Account WHERE Name=:accName LIMIT 1];
        List<Contact> contacts = new List<Contact>();
        
        for(Integer i = 0; i < num; i++) {
            if (Math.mod(i,2) == 0) {
                Contact c = new Contact(FirstName = str+'F'+i, LastName = str+'L'+i, AccountId = '0011r00001q4GTa');
                contacts.add(c);
            } else {
                Contact c = new Contact(FirstName = str+'F'+i, LastName = str+'L'+i, AccountId ='0011r00001q3IQ4');
                contacts.add(c);
            }
        }
        return contacts;
    }
}