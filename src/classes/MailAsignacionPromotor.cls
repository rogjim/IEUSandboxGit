global class MailAsignacionPromotor {
    @future(callout=true)
    public static void sendMail(Id leadId, String mailLead){
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        String mailPromotor = [SELECT Promotor__r.Promotor__r.Email FROM Lead WHERE Id =: leadId Limit 1].Promotor__r.Promotor__r.Email;
        String hostName = String.valueOf(URL.getSalesforceBaseUrl().getHost());
        List<String> server = hostName.split('\\.');
        
        
        String urlP ='';
        if ( ValidaEntorno.isSandbox()) { 
            urlP = 'https://sandbox-ieu.cs2.force.com/MailPromotorAsignado?Id=' + leadId;
        } else { 
            //urlP = 'https://c.' + server[0] + '.visual.force.com/apex/MailPromotorAsignado?Id=' + leadId;
            urlP = 'http://ieu.force.com/apex/MailPromotorAsignado?Id=' + lead.Id;
        }
        
        PageReference pdf = new PageReference(urlP);
        
        Blob body = !Test.isRunningTest() ? pdf.getContent() : Blob.ValueOf('dummy text');
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       // mailLead='calvarez@ctconsulting.com.mx';
        mail.setToAddresses(new String[] { mailLead });
        mail.setSubject('Informes IEU'  );                
        mail.setHtmlBody(body.toString());
       // mailPromotor='calvarez@ctconsulting.com.mx';
        mail.setReplyTo(mailPromotor);
        mails.add(mail);  
        
       
        if(!mails.isEmpty())
        {
            Messaging.SendEmail(mails);
        }  
        
    }
    
    @future(callout=true)
    public static void sendMail(String Idleads){
        Idleads = Idleads.replace('{','');
        Idleads = Idleads.replace('}','');
        
        list<String> ids = Idleads.split(',');
        list<Lead> leads = [SELECT id,Name,email,Promotor__r.Promotor__r.Email FROM Lead WHERE Id IN : ids];
         //list<Lead> leads = [SELECT id,Name,email,Owner.Email FROM Lead WHERE Id IN : ids];
        
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        
        String hostName = String.valueOf(URL.getSalesforceBaseUrl().getHost());
        List<String> server = hostName.split('\\.');
        
        for(Lead lead : leads){
            
            String urlP ='';
            
            if ( ValidaEntorno.isSandbox()) { 
                urlP = 'https://sandbox-ieu.cs2.force.com/MailPromotorAsignado?Id=' + lead.Id;
            } else { 
                //urlP = 'https://c.' + server[0] + '.visual.force.com/apex/MailPromotorAsignado?Id=' + lead.Id;
                //http://ieu.force.com/apex/
                urlP = 'http://ieu.force.com/apex/MailPromotorAsignado?Id=' + lead.Id;
            }
            
            PageReference pdf = new PageReference(urlP);
            
            Blob body = !Test.isRunningTest() ? pdf.getContent() : Blob.ValueOf('dummy text');
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            try{
                Negocio__c negocio = Negocio__c.getOrgDefaults();
                OrgWideEmailAddress[] owea = [select Id,DisplayName from OrgWideEmailAddress where DisplayName =: negocio.DisplayName__c];
                if ( owea.size() > 0 ) {
                    mail.setOrgWideEmailAddressId(owea.get(0).Id);
                }
            }catch(Exception e){
                
            }
            
            mail.setToAddresses(new String[] { lead.email });
            System.debug( 'Mail promotor'  );
            mail.setSubject('Informes IEU  '); 
            mail.setHtmlBody(body.toString());
           mail.setReplyTo(lead.Promotor__r.Promotor__r.Email);
         //   mail.setReplyTo(lead.Owner.Email);
            mails.add(mail); 
        } 
        
        if(!mails.isEmpty())
        {
            Messaging.SendEmail(mails);
        } 
    }
    
   
    
    
}