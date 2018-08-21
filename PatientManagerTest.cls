@isTest
public class PatientManagerTest {
	
    @isTest 
    static void getAllPatients_1all() {
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
    static void getAllPatients_2one() {
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
    static void getAllPatients_3fail() {
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
    static void createPatient_1_ok() {
        Test.startTest();
        RestRequest req = new RestRequest(); 
       	RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Patients/';  //Request URL
        req.httpMethod = 'POST'; //HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        String patientsFromPM = PatientManager.createPatient('testname3', '1997-07-14', 'LNTest3');
        //System.debug('patientsFromPM '+patientsFromPM);
        List<Patient__c> patients = [SELECT Id, Name, Last_Name__c, Birthday__c  FROM Patient__c WHERE Name='testname3'];
        //System.debug('patients '+patients);
        System.assertEquals(1, patients.size());
        Test.stopTest();
    }
    
    @isTest 
    static void createPatient_2_invDate() {
        Test.startTest();
        RestRequest req = new RestRequest(); 
       	RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Patients/';  //Request URL
        req.httpMethod = 'POST'; //HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        String patientsFromPM = PatientManager.createPatient('testname3', '197-07-14', 'LNTest3');
        //System.debug('patientsFromPM '+patientsFromPM);
        List<Patient__c> patients = [SELECT Id, Name, Last_Name__c, Birthday__c  FROM Patient__c WHERE Name='testname3'];
        //System.debug('patients '+patients);
        System.assertEquals(0, patients.size());
        Test.stopTest();
    }
    
    @isTest 
    static void createPatient_3_paramF() {
        Test.startTest();
        RestRequest req = new RestRequest(); 
       	RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Patients/';  //Request URL
        req.httpMethod = 'POST'; //HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        String patientsFromPM = PatientManager.createPatient('', '1997-07-14', 'LNTest3');
        //System.debug('patientsFromPM '+patientsFromPM);
        List<Patient__c> patients = [SELECT Id, Name, Last_Name__c, Birthday__c  FROM Patient__c WHERE Name='testname3'];
        //System.debug('patients '+patients);
        System.assertEquals(0, patients.size());
        Test.stopTest();
    }
    @isTest 
    static void createPatient_4_dateF() {
        Test.startTest();
        RestRequest req = new RestRequest(); 
       	RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Patients/';  //Request URL
        req.httpMethod = 'POST'; //HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        String patientsFromPM = PatientManager.createPatient('testname3', '1997-14-14', 'LNTest3');
        //System.debug('patientsFromPM '+patientsFromPM);
        List<Patient__c> patients = [SELECT Id, Name, Last_Name__c, Birthday__c  FROM Patient__c WHERE Name='testname3'];
        //System.debug('patients '+patients);
        System.assertEquals(0, patients.size());
        Test.stopTest();
    }
    
    @isTest 
    static void updatePatient_1_ok() {
        List<Patient__c> patientsFact = TestDataFactory.createPatients(7);
        Test.startTest();
        RestRequest req = new RestRequest(); 
       	RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Patients/';  //Request URL
        req.httpMethod = 'POST'; //HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        System.debug('patientsFact.get(3) '+patientsFact.get(3));
        String patientsFromPM = PatientManager.updatePatient(''+patientsFact.get(3).Id,'testname3', '1997-05-14', 'LNTest3');
        //System.debug('patientsFromPM '+patientsFromPM);
        List<Patient__c> patients = [SELECT Id, Name, Last_Name__c, Birthday__c  FROM Patient__c WHERE Name='testname3'];
        //System.debug('patients '+patients);
        System.assertEquals(1, patients.size());
        Test.stopTest();
    }
    
    @isTest 
    static void updatePatient_2_invDate() {
        List<Patient__c> patientsFact = TestDataFactory.createPatients(7);
        Test.startTest();
        RestRequest req = new RestRequest(); 
       	RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Patients/';  //Request URL
        req.httpMethod = 'POST'; //HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        //System.debug('patientsFact.get(3) '+patientsFact.get(3));
        String patientsFromPM = PatientManager.updatePatient(''+patientsFact.get(3).Id,'testname3', '197-05-14', '');
        //System.debug('patientsFromPM '+patientsFromPM);
        List<Patient__c> patients = [SELECT Id, Name, Last_Name__c, Birthday__c  FROM Patient__c WHERE Name='testname3'];
        //System.debug('patients '+patients);
        System.assertEquals(0, patients.size());
        Test.stopTest();
    }
    
    @isTest 
    static void updatePatient_3failId() {
        List<Patient__c> patientsFact = TestDataFactory.createPatients(7);
        Test.startTest();
        RestRequest req = new RestRequest(); 
       	RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Patients/';  //Request URL
        req.httpMethod = 'POST'; //HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        //System.debug('patientsFact.get(3) '+patientsFact.get(3));
        String patientsFromPM = PatientManager.updatePatient('0234sdfsdf23423','testname3', '1997-05-14', '');
        //System.debug('patientsFromPM '+patientsFromPM);
        List<Patient__c> patients = [SELECT Id, Name, Last_Name__c, Birthday__c  FROM Patient__c WHERE Name='testname3'];
        //System.debug('patients '+patients);
        System.assertEquals(0, patients.size());
        Test.stopTest();
    }
    
    @isTest 
    static void updatePatient_4failDate() {
        List<Patient__c> patientsFact = TestDataFactory.createPatients(7);
        Test.startTest();
        RestRequest req = new RestRequest(); 
       	RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Patients/';  //Request URL
        req.httpMethod = 'POST'; //HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        //System.debug('patientsFact.get(3) '+patientsFact.get(3));
        String patientsFromPM = PatientManager.updatePatient(''+patientsFact.get(3).Id,'testname3', '19705-14', '');
        //System.debug('patientsFromPM '+patientsFromPM);
        List<Patient__c> patients = [SELECT Id, Name, Last_Name__c, Birthday__c  FROM Patient__c WHERE Name='testname3'];
        //System.debug('patients '+patients);
        System.assertEquals(0, patients.size());
        Test.stopTest();
    }
    
    @isTest 
    static void updatePatient_5failId() {
        List<Patient__c> patientsFact = TestDataFactory.createPatients(7);
        Test.startTest();
        RestRequest req = new RestRequest(); 
       	RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Patients/';  //Request URL
        req.httpMethod = 'POST'; //HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        //System.debug('patientsFact.get(3) '+patientsFact.get(3));
        String patientsFromPM = PatientManager.updatePatient('','testname3', '19705-14', '');
        //System.debug('patientsFromPM '+patientsFromPM);
        List<Patient__c> patients = [SELECT Id, Name, Last_Name__c, Birthday__c  FROM Patient__c WHERE Name='testname3'];
        //System.debug('patients '+patients);
        System.assertEquals(0, patients.size());
        Test.stopTest();
    }
}