@IsTest 
public class TriggerBecaHandlerTest {
    @IsTest  
    public static void  TriggerBecaHandler(){
        
        Test.startTest();
        Beca__c bec = new Beca__c(BecaPromocion__c=true,
                                  Beneficiados__c ='EMPLEADOS O PERSONAL ADSCRITO', 
                                  CantidadInscritos__c =10,
                                  TipoBeca__c = 'Comercial'
                                 );
        insert bec;
        
        /*Lead lead = new Lead( ModificadoERP__c=true,
                             Beca__c=bec.Id,
                             LastName = 'Martinez'
                            );
        insert lead;
        
        ConfiguracionObjetoCambio__c ob = new ConfiguracionObjetoCambio__c(
            Name='Beca__c',
            Campo__c='Beca__c'
        );
        insert ob;*/
        
       
        Test.stopTest();
        
    }
}