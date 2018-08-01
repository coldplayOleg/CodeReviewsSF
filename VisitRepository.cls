public class VisitRepository {
    
	public static List<Visit__c> findAllVisitById(Set<Id> visitsId) {
        List<Visit__c> visit = [SELECT Id, Patient__c FROM Visit__c WHERE Id IN :(visitsId) LIMIT 30000];
        if (visit != null) {
            return visit;
        }
        return new List<Visit__c>();
    }
    
}