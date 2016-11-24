@isTest  public class CalculadoraInfoCtrlTest {
    
    @IsTest   public static void CalculadoraInfoCtrl(){
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        //upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        Lead lead = new  Lead(LastName='demo'
                             );
        lead.Folio__c = String.valueOf(nextFolio); 
        insert lead;
        
        ApexPages.StandardController controller = new ApexPages.StandardController(lead);
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
        System.currentPageReference().getParameters().put('id', lead.id);
        
        CalculadoraInfoCtrl obj = new CalculadoraInfoCtrl();
        
    }
    
    
    
   /* @IsTest   public static void getMontos()  {
        
        date inicio = date.newInstance(2020, 1, 30);
        date fin = date.newInstance(2020, 2, 30);
        
        Periodo__c per = new Periodo__c(Name='agosto 2020',
                                        FechaInicio__c=inicio,
                                        FechaInicioReal__c=inicio,
                                        FechaFin__c =fin,
                                        FechaFinReal__c =fin,
                                        Activo__c='Activo'
                                       );
        insert per;
        
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo'
                                         );
        insert  plan;
        
        Catalogo__c cat = new Catalogo__c(Name='Online',
                                          TipoCatalogo__c='Modalidad');
        insert cat;
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                           TipoCatalogo__c='Nivel');
        insert catn;
        
        Catalogo__c catal = new Catalogo__c(Name='Inscripción',
                                            TipoCatalogo__c='Concepto Pagos');
        insert catal;
        
        Programa__c pr =new Programa__c(Name='demo');
        insert pr;
        
        OfertaEducativa__c oe= new OfertaEducativa__c(Programa__c=pr.id,
                                                      Modalidad__c=cat.Id,
                                                      Nivel__c=catn.Id,
                                                      Plantel__c=plan.id,
                                                      Periodo__c=per.Id
                                                     );
        insert oe;
        
        OfertaConceptoPagos__c ofec = new OfertaConceptoPagos__c( Monto__c=33, 
                                                                 OfertaEducativa__c =oe.Id,
                                                                 ConceptoPago__c=catal.Id 
                                                                );
        insert ofec; 
        
        CalculadoraInfoCtrl.getMontos(oe.Id); 
        
    } */
    
}