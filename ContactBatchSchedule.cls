global class ContactBatchSchedule implements Schedulable {
    
    private Integer scope;
    private ContactBatch cb;
    
    public ContactBatchSchedule(Integer scope, ContactBatch cb) {
        this.scope = scope;
        this.cb = cb;
    }
    
	global void execute(SchedulableContext sc) {
        if(ContactRepository.findAllContactWhereAccountName(cb.getAccountName(),cb.getDt()).size() > 0){
        	String idBatch = Database.executeBatch(cb, this.scope);
            if(idBatch.startsWith('000')){
                EmailManager.sendMail(cb.getAddress(),cb.getSubject(), 'Batch failed and contacts were not removed.');
            	//System.debug(cb.getAddress()+'- '+cb.getSubject()+'- '+'Batch failed and contacts were not removed.');
            }
        }
	}
    
}