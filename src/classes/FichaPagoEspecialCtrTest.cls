@isTest 
public class FichaPagoEspecialCtrTest {
    @IsTest   public static void saveToken(){
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
        
          Programa__c pr =new Programa__c(Name='demo');
        insert pr; 
        
        FichaPago__c fp = new FichaPago__c(Importe__c=33330,
                                           Descuento__c=4,
                                           FolioLead__c= nextFolio,
                                           Hasta__c =Date.today(),
                                           MontoPagado__c =4545,
                                           TotaPagar__c =4444,
                                            RecibimosDe__c ='demo',
                                        //   Lead__c=lead.Id
                                            Plantel__c=plan.Id,
                                           ProgramasRelacionados__c=pr.Id
                                          );
        upsert fp;
        
        ApexPages.StandardController controller = new ApexPages.StandardController(lead);
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
        System.currentPageReference().getParameters().put('id', lead.id);
        FichaPagoEspecialCtrl obj = new FichaPagoEspecialCtrl(controller);
        obj.ficha=fp;
        obj.saveToken();
    }
        @IsTest   public static void exit(){
             Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        //upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        Lead lead = new  Lead(LastName='demo',
                              Folio__c = String.valueOf(nextFolio)
                             );
        insert lead;
     
        ApexPages.StandardController controller = new ApexPages.StandardController(lead);
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
        System.currentPageReference().getParameters().put('id', lead.id);
        FichaPagoEspecialCtrl obj = new FichaPagoEspecialCtrl(controller);
       
        obj.exit();
    }
}