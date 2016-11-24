@isTest  public class Batch_IEU_ERPMasterTest {
    
   @isTest  public static void Batch_IEU_ERPMasterTest() {
   		Negocio__c negocio = new Negocio__c(
        );
        //insert negocio;
        
    	Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                           TipoCatalogo__c='Nivel');
        insert catn;
        Instituto__c instituto = new Instituto__c(Name = 'institutoTest', PrefijoOXXO__c = '1');
        insert instituto;
        
        Plantel__c plantel = new Plantel__c(Name ='plantelTest',Instituto__c = instituto.Id,RazonSocial__c ='razonSocialTest');
        insert plantel;
        
        Test.startTest();
        
        List<Lead> leadList = new List<Lead>();
        List<Contact> contactList = new List<Contact>();
        for (Integer i = 0; i < 10; i++) {
            leadList.add(
             	 new Lead(
                             Email='dsanchez@ctconsulting.com.mx',
                             Nivel__c=catn.Id,
                             plantel__c = plantel.Id,
                             LastName = 'lastName' + i
                            )
             );
            
            contactList.add(new Contact(
                FirstName = 'Boards ' + i,
                LastName = 'Test Contact'
            ));
        }
       /* List<sObject> objects = new List<sObject>();
        objects.addAll((List<sObject>)(leadList));
        objects.addAll((List<sObject>)(contactList));
        insert objects;*/
        insert leadList;
        
       IEU_ERPMaster obj = new IEU_ERPMaster();
     //   obj.ArrayOfCandidatoInfo;
     //   obj.ArrayOfCandidatoInfo
      //  Batch_IEU_ERPMaster.addCandidatoInfo( obj.ArrayOfCandidatoInfo);
        
        
        
       // Database.executeBatch(Batch_IEU_ERPMaster.addCandidatoInfo(objects));
        
        Test.stopTest();
        
        
    }
    
}