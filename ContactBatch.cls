global class ContactBatch implements Database.Batchable<sObject>, Database.Stateful {
	
    private String accountName;
    private String bodyEmail;
    private String subject;
    private Datetime dt;
    private Integer num = 0;
    private String address = GlobalVariablesRepository.email();
    
    public ContactBatch(String accountName, String subject, String bodyEmail, Integer days) {
        this.accountName = accountName;
        this.subject = subject;
        this.bodyEmail = bodyEmail;
        this.address = address;
        this.dt = Datetime.now().addDays(days);
        System.debug('ContactBatch create');
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        System.debug('ContactBatch start');
        return Database.getQueryLocator('SELECT Id, Name, LastModifiedDate '+
                                        +'FROM Contact WHERE Account.Name LIKE \'%'+accountName+'%\' AND LastModifiedDate >= :dt');
    }
    
    global void execute(Database.BatchableContext bc, List<Contact> contacts){
<<<<<<< HEAD
        if (contacts.size() > 0){
            num = contacts.size();
        	delete contacts;
            System.debug('ContactBatch execute');
=======
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
            if(contact.LastModifiedDate >= Datetime.now().addHours(-24)) {
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
>>>>>>> 2a6df1af75aa1dbd5d26b4bf1c38e3e7c0751e64
        }
    }
    
    global void finish(Database.BatchableContext bc){
        bodyEmail+= '. '+num+' contacts were removed.';
        //EmailManager.sendMail(address, subject, bodyEmail);
        System.debug(address+', '+subject+', '+bodyEmail);
        System.debug('ContactBatch finish');
    }
    
    public String getAddress(){
        return this.address;
	}
    
    public String getSubject(){
        return this.subject;
	}
    
    public Datetime getDt(){
        return this.dt;
	}
    
    public String getAccountName(){
        return this.accountName;
	}
    
<<<<<<< HEAD
}
=======
    public String getBodyEmail() {
        return this.bodyEmail;
    }
    public String getAddress() {
        return this.address;
    }
}
>>>>>>> 2a6df1af75aa1dbd5d26b4bf1c38e3e7c0751e64
