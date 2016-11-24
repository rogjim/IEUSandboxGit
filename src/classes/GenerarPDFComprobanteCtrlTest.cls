@isTest public class GenerarPDFComprobanteCtrlTest {
    
    
    @isTest     
    public static void sendMail(){
        try{
            Test.startTest();
            RecordType rt =[select id,Name from RecordType where sObjectType='Account'  limit 1];
            
            Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
            upsert configuracionNegocio;
            Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
            nextFolio = nextFolio + 1;
            
            Catalogo__c cat = new Catalogo__c(Name='Online',
                                              TipoCatalogo__c='Modalidad');
            insert cat;
            
            Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                               TipoCatalogo__c='Nivel');
            insert catn;
            
            Programa__c pr =new Programa__c(Name='demo');
            insert pr;
            
            Instituto__c inst = new Instituto__c( Name='INSTITUTO DE ESTUDIOS UNIVERSITARIOS, S. C.',
                                                 PrefijoOXXO__c='61' 
                                                );
            insert inst;
            
            Plantel__c plan = new Plantel__c (Calle__c='demo',
                                              RazonSocial__c='demo',
                                              Instituto__c=inst.Id
                                             );
            insert  plan;
            
            OfertaEducativa__c oe= new OfertaEducativa__c(
                Programa__c=pr.id,
                Modalidad__c=cat.Id,
                Nivel__c=catn.Id,
                Plantel__c=plan.id);
            insert oe;
            
            Lead lead = new  Lead(LastName='demo',
                                  Nivel__c=catn.id,
                                  OfertaEducativa__c=oe.Id
                                 );
            lead.Folio__c = String.valueOf(nextFolio);
            lead.Email='dsanchez@ctconsulting.com.mx';
            insert lead;
            
            FichaPago__c fp = new FichaPago__c(Importe__c=1800,
                                               Descuento__c=4,
                                               FolioLead__c= nextFolio,                                               
                                               MontoPagado__c =4545,
                                               TotaPagar__c =1800,
                                               Lead__c=lead.Id,
                                               RecibimosDe__c='Dan',
                                               Plantel__c=plan.Id 
                                              );
            fp.Hasta__c =Date.today();
            insert fp;
            Test.setCurrentPageReference(new pageReference('Page.mypage'));
            System.currentPageReference().getParameters().put('id', fp.Id);        
            GenerarPDFComprobanteCtrl.sendMailComprobante('1234', 'Pago', 'ggarcia@ctconsulting.com.mx', '1234', '1', String.valueOf(fp.id));
            Test.stopTest();
        }
        catch(Exception ex){}
        
        
    }
}