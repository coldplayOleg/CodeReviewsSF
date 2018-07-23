global class ContactBatchSchedule implements Schedulable{
    
    private Integer scope = 150;
    
	global void execute(SchedulableContext sc) {
		ContactBatch cb = new ContactBatch();
        Id batchId = Database.executeBatch(cb, scope);
	}
    
    public void setScope(Integer scope) {
        this.scope = scope;
    }
    
    public Integer getscope() {
        return this.scope;
    }
    
}