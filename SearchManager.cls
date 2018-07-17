public class SearchManager {
    String searchText;
    String subject;
    String body;
    List<Contact> contacts;
	
    public SearchManager(String searchText, String subject, String body, object[] newTrigger) {
        this.searchText = searchText;
        this.subject = subject;
        this.body = body;
      	this.contacts = (List<Contact>) newTrigger;
    }
    
    public Boolean searchContact(){
        List<String> contactsList = new List<String>();
        Id userId = UserInfo.getUserId();
        User currentUser =[SELECT Email FROM User WHERE Id=:userId];
        String addresUser = String.valueOf(currentUser.Email);
        Contact firstContact = contacts.get(0);
		ID acctID = firstContact.AccountId;
        Account account = [SELECT Name FROM Account WHERE Id=:acctID LIMIT 1];
        
        for(Contact contact : contacts){
            if(account.Name.equals(searchText)){
                contactsList.add(contact.FirstName +' '+ contact.LastName);
             }
        }
        if (contactsList.size() > 0) {
            body += String.join(contactsList,',');
            EmailManager.sendMail(addresUser, subject, body);
            //System.debug(addresUser +' - '+subject+' - '+body);
            return true;
        }
        return false;
   }
}
