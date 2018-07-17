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
        String contactName = '';
        List<String> contactsList = new List<String>();
        Id userId = UserInfo.getUserId();
        User currentUser =[SELECT Email FROM User WHERE Id=:userId];
        String addresUser = String.valueOf(currentUser.Email);

        for(Contact contact : contacts){
            ID acctID = contact.AccountId;
            Account account = [SELECT Name FROM Account WHERE Id=:acctID];
            if(account.Name.equals(searchText)){
                contactName = contact.FirstName +' '+ contact.LastName;
                contactsList.add(contactName);
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
