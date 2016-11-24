@IsTest  public class DescuentosByOpportunityCtrlTest {

    @IsTest   public static void DescuentosByOpportunityCtrlTest(){
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        //upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        Lead lead = new  Lead(LastName='demo',
                              Folio__c = String.valueOf(nextFolio)
                             );
        insert lead;
        
        Ubicacion__c ub = new Ubicacion__c(Name='MEXICO'
                                           ,IdUbicacion__c='157'
                                           ,TipoUbicacion__c='País'
                                          );
        insert ub;
		
		RecordType rt = [SELECT id,Name FROM RecordType WHERE DeveloperName = 'PersonAccount'];
		        
        Account account = new Account(
        	LastName = 'TEST',
        	RecordTypeId = rt.Id,
        	Pais__c = ub.Id,
        	PersonEmail = 'mail@mail.com'
        );
        insert account;
        
         Opportunity opp = new Opportunity(Name='demo2',
                                        CloseDate= Date.today(),
                                        AccountId = account.Id,
                                        stageNAme='Closed'
                                       );
       /* insert opp;
        
        ApexPages.StandardController controller = new ApexPages.StandardController(opp);
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
        DescuentosByOpportunityCtrl obj = new DescuentosByOpportunityCtrl(controller);
        
        obj.getDescuentos();
        obj.getBecas();*/
    }
}