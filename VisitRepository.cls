public class VisitRepository {
    
	public static Visit__c findOneVisitById(Id visitId) {
        List<Visit__c> visit = [SELECT Id, Patient__c FROM Visit__c WHERE Id = :visitId LIMIT 1];
        if (visit != null) {
            return visit.get(0);
        }
        return new Visit__c();
    }
    
}