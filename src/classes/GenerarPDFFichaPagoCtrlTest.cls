@isTest  public class GenerarPDFFichaPagoCtrlTest {
    
    @isTest   public static void sendMail(){
        
        RecordType rt =[select id,Name from RecordType where sObjectType='FichaPago__c'  and Name = 'Ficha de Nivel' limit 1];
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        //upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        
        Instituto__c inst= new Instituto__c(Name='INSTITUTO DE ESTUDIOS UNIVERSITARIOS, S. C.'
                                            ,PrefijoOXXO__c='61'
                                           );
        insert inst;
        
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo',
                                          Instituto__c=inst.id
                                         );
        insert plan;
        
        Catalogo__c cat = new Catalogo__c(Name='Cursos y Diplomados',
                                          TipoCatalogo__c='Nivel'
                                         );
        insert cat;
        
        Lead lead = new  Lead(LastName='demo',
                              Nivel__c=cat.id
                             );
        
        lead.Folio__c = String.valueOf(nextFolio);
        lead.Email='dsanchez@ctconsulting.com.mx';
        insert lead;
        
        Programa__c pr =new Programa__c(Name='demo');
        insert pr;
        
        FichaPago__c fp = new FichaPago__c(Importe__c=33330,
                                           Descuento__c=4,
                                           FolioLead__c= nextFolio,
                                           MontoPagado__c =4545,
                                           TotaPagar__c =4444,
                                           Lead__c=lead.Id,
                                           RecibimosDe__c='de',
                                           Plantel__c=plan.Id,
                                           ProgramasRelacionados__c=pr.Id
                                           ,RecordTypeId=rt.Id
                                          );
        fp.Hasta__c =Date.today();
        insert fp;
        
        ApexPages.StandardController controller = new ApexPages.StandardController(fp);
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
        System.currentPageReference().getParameters().put('id', fp.Id);
        GenerarPDFFichaPagoCtrl obj = new GenerarPDFFichaPagoCtrl(controller);
        obj.sendMail();
        
    }
    
    @isTest    public static void sendMail2(){
        
        RecordType rt =[select id,Name from RecordType where sObjectType='FichaPago__c'  and Name = 'Ficha de Nivel' limit 1];
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        //upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        
        Instituto__c inst= new Instituto__c(Name='INSTITUTO DE ESTUDIOS UNIVERSITARIOS, S. C.'
                                            ,PrefijoOXXO__c='61'
                                           );
        insert inst;
        
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo',
                                          Instituto__c=inst.id
                                         );
        insert plan;
        
        Catalogo__c cat = new Catalogo__c(Name='Cursos y Diplomados',
                                          TipoCatalogo__c='Nivel'
                                         );
        
        insert cat;
        
        Lead lead = new  Lead(LastName='demo',
                              Nivel__c=cat.id
                             );
        lead.Folio__c = String.valueOf(nextFolio);
        lead.Email='dsanchez@ctconsulting.com.mx';
        insert lead;
        
        Programa__c pr =new Programa__c(Name='demo');
        insert pr;
        
        FichaPago__c fp = new FichaPago__c(Importe__c=33330,
                                           Descuento__c=4,
                                           FolioLead__c= nextFolio,
                                           MontoPagado__c =4545,
                                           TotaPagar__c =4444,
                                           Lead__c=lead.Id,
                                           RecibimosDe__c='de',
                                           Plantel__c=plan.Id,
                                           ProgramasRelacionados__c=pr.Id
                                           ,RecordTypeId=rt.Id
                                          );
        fp.Hasta__c =Date.today();
        insert fp;
        
        ApexPages.StandardController controller = new ApexPages.StandardController(fp);
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
        System.currentPageReference().getParameters().put('id', fp.Id);
        GenerarPDFFichaPagoCtrl obj = new GenerarPDFFichaPagoCtrl(controller);
        obj.sendMail();
    }
}