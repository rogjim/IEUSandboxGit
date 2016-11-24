@isTest  
public class CTA_LayoutCtrlTest {
    @IsTest   public static void getEstados(){
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = Schema.SObjectType.Account.getRecordTypeInfosByName();
        
        RecordType rt =[select id,Name from RecordType where SobjectType='Account' limit 1]; 
        Account acc = new Account(Name ='demo');
        acc.RecordTypeId = AccountRecordTypeInfo.get(rt.Name).getRecordTypeId();
        insert acc;
        
        ApexPages.StandardController controller = new ApexPages.StandardController(acc);
        Test.setCurrentPageReference(new pageReference('Page.mypage')); 
        CTA_LayoutCtrl obj = new CTA_LayoutCtrl(controller);
        obj.getEstados();
    }
    
    @IsTest   public static void getMunicipios(){
        RecordType rt =[select id,Name from RecordType where sObjectType='Account'  limit 1];
        Account acc = new Account(Name ='demo',
                                  RecordTypeId=rt.Id
                                 );
        insert acc;
        
        ApexPages.StandardController controller = new ApexPages.StandardController(acc);
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
        // System.currentPageReference().getParameters().put('id', acc.Id);
        CTA_LayoutCtrl obj = new CTA_LayoutCtrl(controller);
        obj.getMunicipios();
    }
    
    @IsTest   public static void save(){
        RecordType rt =[select id,Name from RecordType where sObjectType='Account'  limit 1];
        Account acc = new Account(Name ='demo',
                                  RecordTypeId=rt.Id
                                 );
        insert acc;
        Contact con = new Contact(LastName='DEMO' );
        con.AccountId=acc.Id;
        insert con;        
        ApexPages.StandardController controller = new ApexPages.StandardController(acc);
        Test.setCurrentPageReference(new pageReference('Page.mypage'));
        System.currentPageReference().getParameters().put('id', acc.Id);
        CTA_LayoutCtrl obj = new CTA_LayoutCtrl(controller);
        obj.save();
    }
}