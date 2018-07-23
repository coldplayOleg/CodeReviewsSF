global class ContactBatch implements Database.Batchable<sObject>, Database.Stateful{
	/*
	  Create batch(1,4) which will delete all contacts:
	- if related account name has insensitive word 'test' or 'Test' or 'TESt' etc (boolean) (contains)
	- were changed within last 24h (boolean) if (LastModifiedDate == today() - 1)
		SELECT Id, LastModifiedDate FROM Contact LIMIT 50000
	 */
    global Integer recordsProcessed = 0;
    private String searchAccountName = '';
    private String address = GlobalVariablesRepository.email();
    private String bodyEmail = 'Successfully deleted '+recordsProcessed+' contacts.';
    private String subject = '';
    EmailManager email = new EmailManager();
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Name, LastModifiedDate FROM Contact LIMIT 200');
    }
    
    global void execute(Database.BatchableContext bc, List<Contact> contacts){
        // process each batch of records
        //List<Contact> contAll = ContactRepository.findAllContact();
        Set<Id> accountsId = new Set<Id>();
        for(Contact contact : contacts){
            accountsId.add(contact.AccountId);    
        }
        List<Account> accountsList = AccountRepository.findAllAccountsById(accountsId);
        Account searchAccount = new Account();
        for (Integer i = 0; i < accountsList.size(); i++){
            if (String.valueOf(accountsList.get(i).Name).containsIgnoreCase(searchAccountName)){
                searchAccount = accountsList.get(i);
            }
        }
        List<Contact> contactsWithId = ContactRepository.findAllContactWhereAccountId(searchAccount.Id);
        List<Contact> contactsToDelete = new List<Contact>();
        for (Contact contact : contactsWithId){
            if(contact.LastModifiedDate.addHours(24) <= Datetime.now()) {
                contactsToDelete.add(contact);
                recordsProcessed++;
            }
        }
        
        try {
        	delete contactsToDelete;
        } catch (DMLException e){
            bodyEmail = 'Delete batch failed, the following errors occurred when delete contacts: '+ e.getMessage()+'.'+ 
                +' List of contact: ';
            for (Contact contact : contactsToDelete){
                bodyEmail += contact.Name;
            }
            email.sendMail(address, subject, bodyEmail); 
        }
    }
    
    global void finish(Database.BatchableContext bc){
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        if (job.NumberOfErrors > 0) {
            bodyEmail += ' Errors when deleting contacts: '+job.NumberOfErrors;
        }
        // call some utility to send email
        //email.sendMail(address, subject, bodyEmail);
        System.debug('Send email: '+address+', with subject: '+subject+', '+bodyEmail);
    }
    
    public void setSearchAccountName(String searchAccountName) {
        this.searchAccountName = searchAccountName;
    }
    
    public String getSearchAccountName() {
        return this.searchAccountName;
    }
    
    public void setSubject(String subject) {
        this.searchAccountName = searchAccountName;
    }
    
    public String getSubject() {
        return this.subject;
    }
    
    public void setBodyEmail(String bodyEmail) {
        this.bodyEmail = bodyEmail;
    }
    
    public String getBodyEmail() {
        return this.bodyEmail;
    }
    public String getAddress() {
        return this.address;
    }
}