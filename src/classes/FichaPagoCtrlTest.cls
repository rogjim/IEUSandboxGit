@isTest  public class FichaPagoCtrlTest {
    
    @IsTest   public static void test(){
        
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
        
        SolicitudBeca__c sb = new SolicitudBeca__c(lead__c=lead.Id
                                                   ,Estatus__c='Inactivo'  
                                                  ); 
        insert sb; 
        
        Opportunity opp=new Opportunity(Name='oportunidad'
                                        ,StageName ='dd'
                                        ,CloseDate= Date.today()
                                        ,Plantel__c=plan.Id
                                        ,Folio__c='demo989'
                                        ,Nivel__c=catn.Id   
                                       ); 
        // insert opp; 
        
        FichaPago__c fp = new FichaPago__c(Importe__c=33330
                                           ,Descuento__c=4
                                           ,FolioLead__c= nextFolio
                                           ,Hasta__c =Date.today()
                                           ,MontoPagado__c =4545
                                           ,TotaPagar__c =4444
                                           ,RecibimosDe__c ='demo'   
                                           ,Plantel__c=plan.Id
                                          );
        insert fp; 
        
        ApexPages.StandardController controller = new ApexPages.StandardController(lead);
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
        System.currentPageReference().getParameters().put('id', lead.id);
        FichaPagoCtrl obj = new FichaPagoCtrl(controller);
        
        obj.createPayToken();
    }
}