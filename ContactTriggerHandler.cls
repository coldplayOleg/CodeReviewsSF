public class ContactTriggerHandler {
    
    String email = UserRepository.getCurrentUserEmail();
    
    public Boolean sendMail(String address, String subject, String body) {
        Boolean sendResult = false;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {address};
        mail.setToAddresses(toAddresses);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        try {
            Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            for (Messaging.SendEmailResult res : results) {
                if (res.isSuccess()) {
                    sendResult = true;
                } else {
                    System.debug('The following errors occurred when send mail: ' + res.getErrors());
                }
        	}
        } catch (EmailException e){
        	System.debug('ERROR "sendMail": '+e.getMessage());
        }
        return sendResult;
    }
    
    public Boolean contactWithAccountId(String searchText, String subject, String body, List<Contact> contacts){
        List<String> contactsList = new List<String>();
        List<Account> accounts = AccountRepository.findAllAccounts();
        Account searchAccount = new Account();
        
        if (accounts.size() > 0 ) {
            for(Account account : accounts){
                if(account.Name.containsIgnoreCase(searchText)){
                    searchAccount = account;
                 }
        	}
        }
        
        if (searchAccount.Id != null) {
            for(Contact contact : contacts){
                if(contact.AccountId.equals(searchAccount.Id)){
                    contactsList.add(contact.FirstName +' '+ contact.LastName);
                 }
        	}
        }
        
        if (contactsList.size() > 0) {
            body += String.join(contactsList,', ');
            sendMail(email, subject, body);
            //System.debug(email +' - '+subject+' - '+body);
            return true;
        }
        return false;
	}
    
}