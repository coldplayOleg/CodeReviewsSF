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
        if (contacts.size() > 0){
            num = contacts.size();
        	delete contacts;
            System.debug('ContactBatch execute');
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
    
}