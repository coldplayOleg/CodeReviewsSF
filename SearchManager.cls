public class SearchManager {
    String searchText;
    String subject;
    String body;
    List<Contact> contacts;
	
    public SearchManager(String searchText, String subject, String body, List<Contact> contacts) {
        this.searchText = searchText;
        this.subject = subject;
        this.body = body;
      	this.contacts = contacts;
    }
    
    public Boolean searchContact(){
        List<String> contactsList = new List<String>();
        User currentUser =[SELECT Email FROM User WHERE Id=:UserInfo.getUserId()];
        String addresUser = String.valueOf(currentUser.Email);
        Account searchAccount = [SELECT Id, Name FROM Account WHERE Name=:searchText LIMIT 1];
		
        for(Contact contact : contacts){
            if(contact.AccountId.equals(searchAccount.Id)){
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
