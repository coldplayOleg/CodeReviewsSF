public class EmailManager {
    
    public Boolean sendMail(String address, String subject, String body) {
        Boolean sendResult = false;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {address};
        mail.setToAddresses(toAddresses);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        try {
            Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            for (Messaging.SendEmailResult res : results) {
                if (res.isSuccess()) {
                    sendResult = true;
                } else {
                    System.debug('The following errors occurred when send mail: ' + res.getErrors());
                }
        	}
        } catch (EmailException e){
        	System.debug('Exception send email: '+e.getMessage());
        }
        return sendResult;
    }
}