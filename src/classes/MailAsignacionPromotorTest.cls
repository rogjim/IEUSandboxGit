@isTest public class MailAsignacionPromotorTest {
    
    @IsTest  (SeeAllData=true)
    public static void test(){
        
      /*  Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
         
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        Promotor__c   promotorNumero = [select OrdenNumerico__C from Promotor__c order by OrdenNumerico__C desc limit 1];
     
         Integer   nextOrdenNumerico= Integer.valueOf(promotorNumero.OrdenNumerico__c)+100;
        nextFolio = nextFolio + 1;
        date fin = date.today();
        
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo' 
                                         );
        insert  plan;
      
        User usuario = [ select Id,Username,LastName,Alias,CommunityNickname,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,ProfileId,LanguageLocaleKey,Email from User where Id = :UserInfo.getUserId()  ];
        
        Promotor__c promotor = new Promotor__c( 
            Promotor__c=usuario.Id,
            Plantel__c=plan.id,
            OrdenNumerico__c=nextOrdenNumerico,
            Meta__c=3
        );
        insert promotor;
        
        Lead lead = new  Lead(LastName='demo',
                              VigenciaDescuento__c=fin,
                              FirstName='demo',
                              Promotor__c=promotor.Id
                             );
        lead.Folio__c = String.valueOf(nextFolio);
        lead.Email='dsanchez@ctconsulting.com.mx';
        insert lead;
        
        Id leadId =lead.id;
        String mailLead='dsanchez@ctconsulting.com.mx';
        
        MailAsignacionPromotor obj = new MailAsignacionPromotor();
        try{
            MailAsignacionPromotor.sendMail(leadId, mailLead); 
        }catch(exception e){
            System.debug('Exception: ' + e.getMessage());
        }
        
        try{
            MailAsignacionPromotor.sendMail(leadId); 
        }catch(exception e){
            System.debug('Exception: ' + e.getMessage());
        }   */     
    }    
}