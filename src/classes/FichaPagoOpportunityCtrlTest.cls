@isTest   public class FichaPagoOpportunityCtrlTest {
    @IsTest   public static void createPayToken(){
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        //upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        date fin = date.today();
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados'
                                           ,TipoCatalogo__c='Nivel');
        insert catn;
        
        Instituto__c inst= new Instituto__c(Name='INSTITUTO DE ESTUDIOS UNIVERSITARIOS, S. C.'
                                            ,PrefijoOXXO__c='61'
                                           );
        insert inst;
        
        Plantel__c plan = new Plantel__c (Calle__c='demo'
                                          ,RazonSocial__c='demo'
                                          ,Instituto__c=inst.id
                                         );
        insert plan;
        
        Ubicacion__c ub = new Ubicacion__c(Name='MEXICO'
                                           ,IdUbicacion__c='157'
                                           ,TipoUbicacion__c='País'
                                          );
        insert ub;
        
        RecordType myRecordType = [select id from RecordType where SobjectType='Account' AND IsPersonType=True limit 1];
        
        Account acc = new Account(FirstName='test'
                                  ,LastName='Acc'
                                  ,  Type= 'Employer'  
                                  ,PersonEmail='dsanchez@ctconsulting.com.mx'  
                                  ,Recordtypeid=myRecordType.Id 
                                  ,PersonMailingStreet='test@yahoo.com'
                                  ,PersonMailingPostalCode='12345'
                                  ,PersonMailingCity='SFO' 
                                  ,PersonHomePhone='1234567'
                                  ,PersonMobilePhone='12345678'
                                  ,Pais__c = ub.Id
                                 );
        insert acc; 
        
        Profile p =[SELECT ID FROM Profile  limit 1 ]; 
        User usuario = new user(alias='demo1s'
                                ,LastName='Demo1s'
                                ,Username='demo1s@demopods.com'
                                ,Email='dsanchezs@ctconsulting.com.mx'
                                , TimeZoneSidKey='America/Mexico_City'
                                , LocaleSidKey='es_MX'
                                , EmailEncodingKey='ISO-8859-1'
                                , ProfileId=p.Id
                                , LanguageLocaleKey='es'
                               ); 
        insert usuario; 
        
        Opportunity opp=new Opportunity(Name='demo3'
                                        ,CloseDate= Date.today()
                                        ,AccountId=acc.Id  
                                        ,Nivel__c=catn.id
                                        ,Plantel__c=plan.Id
                                        ,Folio__c='1',
                                        StageName = 'Closed'
                                       );
       
        insert opp;  
        
        Lead lead = new  Lead(LastName='demo'
                              ,Folio__c = String.valueOf(nextFolio)
                              ,VigenciaDescuento__c=fin
                              ,FirstName='demo'                              
                              ,ApeMaterno__c='de'
                              ,nivel__c=catn.id
                              ,plantel__c =plan.id
                              ,DisponiblePromocionCero__c=true   
                             );
        lead.Email='dsanchez@ctconsulting.com.mx';
        insert lead;
        
        Programa__c pr =new Programa__c(Name='demo');
        insert pr; 
        
        FichaPago__c fp = new FichaPago__c(Importe__c=33330
                                           ,Descuento__c=4
                                           ,FolioLead__c= nextFolio
                                           ,Hasta__c =Date.today()
                                           ,MontoPagado__c =4545
                                           ,TotaPagar__c =4444
                                           ,RecibimosDe__c ='demo'   
                                           ,Plantel__c=plan.Id
                                           ,Oportunidad__c=opp.Id
                                          );
        insert fp; 
        
        
        ApexPages.StandardController controller = new ApexPages.StandardController(opp); 
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
        System.currentPageReference().getParameters().put('id', opp.id);
        FichaPagoOpportunityCtrl obj = new FichaPagoOpportunityCtrl(controller);
        
        obj.createPayToken();
        
        
    }
    
   /* @IsTest   public static void createPayToken2(){
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        //upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        date fin = date.today();
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados'
                                           ,TipoCatalogo__c='Nivel');
        insert catn;
        
        Instituto__c inst= new Instituto__c(Name='INSTITUTO DE ESTUDIOS UNIVERSITARIOS, S. C.'
                                            ,PrefijoOXXO__c='61'
                                           );
        insert inst;
        
        Plantel__c plan = new Plantel__c (Calle__c='demo'
                                          ,RazonSocial__c='demo'
                                          ,Instituto__c=inst.id
                                         );
        insert plan;
        
        Ubicacion__c ub = new Ubicacion__c(Name='MEXICO'
                                           ,IdUbicacion__c='157'
                                           ,TipoUbicacion__c='País'
                                          );
        insert ub;
        
        RecordType myRecordType = [select id from RecordType where SobjectType='Account' AND IsPersonType=True limit 1];
        
        Account acc = new Account(FirstName='test'
                                  ,LastName='Acc'
                                  ,  Type= 'Employer'  
                                  ,PersonEmail='dsanchez@ctconsulting.com.mx'  
                                  ,Recordtypeid=myRecordType.Id 
                                  ,PersonMailingStreet='test@yahoo.com'
                                  ,PersonMailingPostalCode='12345'
                                  ,PersonMailingCity='SFO' 
                                  , PersonHomePhone='1234567'
                                  ,PersonMobilePhone='12345678',
                                  Pais__c  = ub.Id 
                                 );
        insert acc; 
        
        Profile p =[SELECT ID FROM Profile  limit 1 ]; 
        User usuario = new user(alias='demo1k'
                                ,LastName='Demo1k'
                                ,Username='demo1k@demopods.com'
                                ,Email='dsanchezk@ctconsulting.com.mx'
                                , TimeZoneSidKey='America/Mexico_City'
                                , LocaleSidKey='es_MX'
                                , EmailEncodingKey='ISO-8859-1'
                                , ProfileId=p.Id
                                , LanguageLocaleKey='es'
                               ); 
        insert usuario; 
        
        Opportunity opp=new Opportunity(Name='demo'
                                        ,StageName ='dd'
                                        ,CloseDate= Date.today()
                                        ,AccountId=acc.Id  
                                        ,Nivel__c=catn.id
                                        ,Plantel__c=plan.Id
                                        ,AplicaPromocionCero__c=true
                                        ,Folio__c='214564'
                                       );
        insert opp;  
        
        Lead lead = new  Lead(LastName='demo'
                              ,Folio__c = String.valueOf(nextFolio)
                              ,VigenciaDescuento__c=fin
                              ,FirstName='demo'                              
                              ,ApeMaterno__c='de'
                              ,nivel__c=catn.id
                              ,plantel__c =plan.id
                              ,DisponiblePromocionCero__c=true   
                             );
        lead.Email='dsanchez@ctconsulting.com.mx';
        insert lead;
        
        Programa__c pr =new Programa__c(Name='demo');
        insert pr; 
        
        SolicitudBeca__c sol = new SolicitudBeca__c(Estatus__c = 'Inactivo'
                                                    ,Oportunidad__c=opp.Id 
                                                   );
        insert sol;
        
        FichaPago__c fp = new FichaPago__c(Importe__c=33330
                                           ,Descuento__c=4
                                           ,FolioLead__c= nextFolio
                                           ,Hasta__c =Date.today()
                                           ,MontoPagado__c =4545
                                           ,TotaPagar__c =4444
                                           ,RecibimosDe__c ='demo'   
                                           ,Plantel__c=plan.Id
                                           ,Oportunidad__c=opp.Id
                                          );
        insert fp; 
        
        
        ApexPages.StandardController controller = new ApexPages.StandardController(opp); 
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
        System.currentPageReference().getParameters().put('id', opp.id);
        FichaPagoOpportunityCtrl obj = new FichaPagoOpportunityCtrl(controller);
        
        obj.createPayToken();
        
        
    }*/
}