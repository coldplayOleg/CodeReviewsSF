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
    global static String createPatient(String name, String birthday, String lastName) {
        
        try {
            Date.valueOf(birthday);
        } catch(Exception e){
            return 'Fail create, you have entered invalid Birthday';
        }
        if(name != null && name != '' && birthday != null && birthday != '' && lastName != null && lastName != ''){
        	Patient__c patient = new Patient__c();
            try {
                patient = new Patient__c(Name = name, Birthday__c = Date.valueOf(birthday), Last_Name__c = lastName);
                insert patient;  
            } catch(Exception e){
                return 'Fail create';
            }
            return 'Created successfully! Id: '+patient.Id+', Name: '+patient.Name +', Birthday: '+patient.Birthday__c+', LastName: '+patient.Last_Name__c;
        } else {
            return 'Fail! Lost parameter';
        }
    }
    
    @HttpPATCH
    global static String updatePatient(String patientId, String name, String birthday, String lastName) {
                
        if(patientId == null || patientId == ''){
            return 'Fail! Lost Id.';
        }
        
        List<Patient__c> patients = [SELECT Id, Name, Last_Name__c, Birthday__c  FROM Patient__c WHERE Id=:patientId LIMIT 1];
         
        if(patients.size() > 0){
            try{
            	Date.valueOf(birthday);
            }catch(Exception e){
                return 'Fail! Invalid date value.';
            }
            
            Patient__c patient = patients.get(0);
            if(name != ''){
            	patient.Name = name;
            }
            if(birthday != ''){
            	patient.Birthday__c = Date.valueOf(birthday);
            }
            if(lastName != ''){
            	patient.Last_Name__c = lastName;
            }
            
            try{
            	update patient;
            } catch(Exception e){
                return 'Fail update';
            }
            return 'Update successful! Id: '+patient.Id+', Name: '+patient.Name +', Birthday: '+patient.Birthday__c+', LastName: '+patient.Last_Name__c;
        } else {
           return 'Patient not found.';
        }
    }
    
}