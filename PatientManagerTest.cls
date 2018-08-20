@isTest
public class PatientManagerTest {
	
    @isTest 
    static void getAllPatients_1() {
        List<Patient__c> patients = TestDataFactory.createPatients(7);
        Test.startTest();
        RestRequest req = new RestRequest(); 
       	RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Patients/';  //Request URL
        req.httpMethod = 'GET'; //HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        List<String> patientsFromPM = PatientManager.getAllPatients();
        System.assertEquals(patients.size()+1, patientsFromPM.size());
        Test.stopTest();
    }
    
    @isTest 
    static void getAllPatients_2() {
        List<Patient__c> patients = TestDataFactory.createPatients(7);
        //System.debug('patients '+patients);
        Test.startTest();
        RestRequest req = new RestRequest(); 
       	RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Patients/'+patients.get(3).Id;  //Request URL
        req.httpMethod = 'GET'; //HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        List<String> patientsFromPM = PatientManager.getAllPatients();
        //System.debug('patientsFromPM '+patientsFromPM);
        System.assertEquals(2, patientsFromPM.size());
        Test.stopTest();
    }
    @isTest 
    static void getAllPatients_3() {
        List<Patient__c> patients = TestDataFactory.createPatients(7);
        Test.startTest();
        RestRequest req = new RestRequest(); 
       	RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Patients/03212asdasdasxz';  //Request URL
        req.httpMethod = 'GET'; //HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        List<String> patientsFromPM = PatientManager.getAllPatients();
        System.assertEquals(1, patientsFromPM.size());
        Test.stopTest();
    }
    
    @isTest 
    static void createPatient_1() {
        Test.startTest();
        RestRequest req = new RestRequest(); 
       	RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Patients/testN1:1995-02-18:LN2';  //Request URL
        req.httpMethod = 'POST'; //HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        List<String> patientsFromPM = PatientManager.createPatient();
        //System.debug('patientsFromPM '+patientsFromPM);
        List<Patient__c> patients = [SELECT Id, Name, Last_Name__c, Birthday__c  FROM Patient__c];
        //System.debug('patients '+patients);
        System.assertEquals(1, patients.size());
        Test.stopTest();
    }
    
    @isTest 
    static void createPatient_2() {
        Test.startTest();
        RestRequest req = new RestRequest(); 
       	RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Patients/testN1:1995-02-18LN2';  //Request URL
        req.httpMethod = 'POST'; //HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        List<String> patientsFromPM = PatientManager.createPatient();
        //System.debug('patientsFromPM '+patientsFromPM);
        List<Patient__c> patients = [SELECT Id, Name, Last_Name__c, Birthday__c  FROM Patient__c];
       // System.debug('patients '+patients);
        System.assertEquals(0, patients.size());
        Test.stopTest();
    }
    
    @isTest 
    static void createPatient_3() {
        Test.startTest();
        RestRequest req = new RestRequest(); 
       	RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Patients/testN1:195-02-18:LN2';  //Request URL
        req.httpMethod = 'POST'; //HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        List<String> patientsFromPM = PatientManager.createPatient();
        //System.debug('patientsFromPM '+patientsFromPM);
        List<Patient__c> patients = [SELECT Id, Name, Last_Name__c, Birthday__c  FROM Patient__c];
        //System.debug('patients '+patients);
        System.assertEquals(0, patients.size());
        Test.stopTest();
    }
    
    @isTest 
    static void updatePatient_1() {
        List<Patient__c> patients = TestDataFactory.createPatients(1);
        Test.startTest();
        RestRequest req = new RestRequest(); 
       	RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Patients/'+patients.get(0).Id+':test1:1995-05-27:Ln1';  //Request URL
        req.httpMethod = 'PATCH'; //HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        List<String> patientsFromPM = PatientManager.updatePatient();
        System.debug('patientsFromPM ok '+patientsFromPM);
        List<Patient__c> patient = [SELECT Id, Name, Last_Name__c, Birthday__c  FROM Patient__c WHERE Name = 'test1' ];
        //System.debug('patient '+patient);
        System.assertEquals(1, patient.size());
        Test.stopTest();
    }
    
    @isTest 
    static void updatePatient_2() {
        List<Patient__c> patients = TestDataFactory.createPatients(1);
        Test.startTest();
        RestRequest req = new RestRequest(); 
       	RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Patients/'+patients.get(0).Id+':test1:1995-0-27:Ln1';  //Request URL
        req.httpMethod = 'PATCH'; //HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        List<String> patientsFromPM = PatientManager.updatePatient();
        System.debug('2 patientsFromPM fail date '+patientsFromPM);
        List<Patient__c> patient = [SELECT Id, Name, Last_Name__c, Birthday__c  FROM Patient__c WHERE Name = 'test1' ];
        //System.debug('patient '+patient);
        System.assertEquals(0, patient.size());
        Test.stopTest();
    }
    
    @isTest 
    static void updatePatient_3() {
        List<Patient__c> patients = TestDataFactory.createPatients(1);
        Test.startTest();
        RestRequest req = new RestRequest(); 
       	RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Patients/'+patients.get(0).Id+':test1:1995-05-27';  //Request URL
        req.httpMethod = 'PATCH'; //HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        List<String> patientsFromPM = PatientManager.updatePatient();
        System.debug('patientsFromPM fail param'+patientsFromPM);
        List<Patient__c> patient = [SELECT Id, Name, Last_Name__c, Birthday__c  FROM Patient__c WHERE Name = 'test1' ];
        //System.debug('patient '+patient);
        System.assertEquals(0, patient.size());
        Test.stopTest();
    }
    
    @isTest 
    static void updatePatient_4() {
        List<Patient__c> patients = TestDataFactory.createPatients(1);
        Test.startTest();
        RestRequest req = new RestRequest(); 
       	RestResponse res = new RestResponse();
        req.requestURI = '/serces/apexrest/Patients/03212asdasdasxz:test1:1995-05-27:Ln1';  //Request URL
        req.httpMethod = 'PATCH'; //HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        List<String> patientsFromPM = PatientManager.updatePatient();
        System.debug('patientsFromPM fail id '+patientsFromPM);
        List<Patient__c> patient = [SELECT Id, Name, Last_Name__c, Birthday__c  FROM Patient__c WHERE Name = 'test1' ];
        //System.debug('patient '+patient);
        System.assertEquals(0, patient.size());
        Test.stopTest();
    }
    
}