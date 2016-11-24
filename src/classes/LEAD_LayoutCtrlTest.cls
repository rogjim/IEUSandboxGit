@isTest  public class LEAD_LayoutCtrlTest {
  
    
    @testsetup    
    public static void LEAD_LayoutCtrl(){
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        date inicio = date.newInstance(2020, 1, 30);
        date fin = date.newInstance(2020, 2, 30);
 
         Lead lead = new  Lead(LastName='demo'
                              //,Plantel__c=plan.id
                             // ,Periodo__c=per.Id
                             // ,Nivel__c=catn.Id
                             // ,BecaConvenioAsignacion__c=beca.Id  
                              ,AplicaPromocionCero__c=true
                              ,Inscripcion__c=333
                              ,Antologia__c=0
                              ,Colegiatura__c=5000
                              ,PorcentajeBeca__c=20
                              ,ExamenAdmision__c=300
                              ,Propedeutico__c=200
                              ,Uniforme__c=300
                            //  ,Modalidad__c= cat.Id
                              ,TipoBeca__c=   'Convenio'
                             // ,OfertaEducativa__c=oe.id
                             // ,Programa__c=pr.id
                             );
        lead.Folio__c = String.valueOf(nextFolio);
      // lead.Pais__c = [SELECT Id, Name FROM Ubicacion__c WHERE Name = 'MEXICO'].Id;
        insert lead;
   
        ApexPages.StandardController sc = new ApexPages.standardController(lead);
        LEAD_LayoutCtrl controller = new LEAD_LayoutCtrl(sc);

        
       
    
    }   
    
 
}