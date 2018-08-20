@RestResource(urlMapping='/Patients/*')
global class PatientManager {
	
    @HttpGet
    global static List<String> getAllPatients() {
        
       	List<String> patientsList = new List<String>();
        List<Patient__c> patients = new List<Patient__c>();
        RestRequest req = RestContext.request;
        String patientId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        
        if(patientId.length() > 0){
            patients = [SELECT Id, Name, Last_Name__c, Birthday__c  FROM Patient__c WHERE Id=:patientId];
        } else {
            patients = [SELECT Id, Name, Last_Name__c, Birthday__c  FROM Patient__c];
        }
        
        if(patients.size() == 0){
            patientsList.add('Nothing was found.');
        	return patientsList;
        }
        
        patientsList.add(patients.size()+' patient(s)');
        for(Patient__c patient : patients){
            patientsList.add('Id: '+patient.Id+', Name: '+patient.Name +', Birthday: '+patient.Birthday__c+', LastName: '+patient.Last_Name__c);
        }
        return patientsList;
    }
    
    @HttpPost
    global static List<String> createPatient() {
        
        List<String> infoPatient = new List<String>();
        RestRequest req = RestContext.request;
        String newPatientURL = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        List<String> NewPatient = newPatientURL.split(':', 3);
        
        if(NewPatient.size() == 3){
        	Patient__c patient = new Patient__c();
            try {
                patient = new Patient__c(Name = NewPatient.get(0), Birthday__c = Date.valueOf(NewPatient.get(1)), Last_Name__c = NewPatient.get(2));
                insert patient;  
            } catch(Exception e){
                infoPatient.add('Fail create, you have entered invalid date: '+newPatientURL+', sample-> Name:YYYY-MM-dd:LastName');
                return infoPatient;
            }
            
			infoPatient.add('Created successfully!');
            infoPatient.add('Id: '+patient.Id+', Name: '+patient.Name +', Birthday: '+patient.Birthday__c+', LastName: '+patient.Last_Name__c);
            return infoPatient;
            
        } else {
            infoPatient.add('Fail! Lost parameter, you have entered: '+newPatientURL+', sample-> Name:YYYY-MM-dd:LastName');
            return infoPatient;
        }
    }
    
    @HttpPATCH
    global static List<String> updatePatient() {
        
        List<String> infoPatient = new List<String>();
        RestRequest req = RestContext.request;
        String newPatientURL = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        List<String> NewPatient = newPatientURL.split(':', 4);
        
        if(NewPatient.size() != 4){
        	infoPatient.add('Fail! Lost parameter, you have entered: '+newPatientURL+', sample-> Id:Name:YYYY-MM-dd:LastName');
            return infoPatient;
        }
        
        List<Patient__c> patients = [SELECT Id, Name, Last_Name__c, Birthday__c  FROM Patient__c WHERE Id=:NewPatient.get(0) LIMIT 1];
         
        if(patients.size() > 0){
            try{
            	Date.valueOf(NewPatient.get(2));
            }catch(Exception e){
                infoPatient.add('Fail! Invalid date, you have entered: '+newPatientURL+', sample-> Id:Name:YYYY-MM-dd:LastName');
                return infoPatient;
            }
            
            Patient__c patient = patients.get(0);
            patient.Name = NewPatient.get(1);
            patient.Birthday__c = Date.valueOf(NewPatient.get(2));
            patient.Last_Name__c = NewPatient.get(3);
            
            try{
            	update patient;
            } catch(Exception e){
                infoPatient.add('Fail updadte. Invalid date, you have entered: '+newPatientURL+', sample-> Id:Name:YYYY-MM-dd:LastName');
                return infoPatient;
            }
            
            infoPatient.add('Update successful!');
            infoPatient.add('Id: '+patient.Id+', Name: '+patient.Name +', Birthday: '+patient.Birthday__c+', LastName: '+patient.Last_Name__c);
            return infoPatient;
        } else {
           infoPatient.add('Patient not found.');
           return infoPatient;
        }
    }
    
}