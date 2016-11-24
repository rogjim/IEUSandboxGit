@isTest public class ProcessBuilderLeadConvertTest {
@isTest   public static void leadConvert(){
    
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults( );
        //upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
    	
    	Ubicacion__c ub = new Ubicacion__c(Name='MEXICO',
                                           IdUbicacion__c='157',
                                           TipoUbicacion__c='País'
                                          );
                                          
        Lead lead = new  Lead(LastName='demo',
                              Folio__c = String.valueOf(nextFolio),
                              Pais__c = ub.Id,
                              Email = 'mail@mail.com'
                             );
        insert lead;
    
    List<Id> leads = new List<Id>();
    leads.add(lead.Id);
    //ProcessBuilderLeadConvert.leadConvert(leads);
}
}