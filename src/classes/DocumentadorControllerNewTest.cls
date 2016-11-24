@isTest public class DocumentadorControllerNewTest {

    
    
    @IsTest   public static void test(){
        
        PageReference testPage = new PageReference('/apex/GeneraPDFDocumentador');
        testPage.getParameters().put('tipoArchivo','Clase Apex');
        Test.setCurrentPage(testPage);
        testPage.getUrl();    
        
        date inicio = date.today();
        date fin = date.today()+60;
        
        DocumentadorController obj = new DocumentadorController();
        obj.filtroTipo='demo';
        obj.counter=40;
        obj.PAGE_SIZE=25;
        obj.total_size=25;
        obj.actualizarDocumentador();
        obj.filterType();
        obj.GeneraPDF();
        obj.ActualizaObservaciones();
        obj.getItems();
    }
    
    @IsTest   public static void test2(){
        DocumentadorController obj = new DocumentadorController();
        obj.filtroTipo='Clase Apex';
        obj.counter=40;
        obj.PAGE_SIZE=25;
        obj.total_size=25;
        obj.Previous();
        obj.filterType();
    }
    
    @IsTest   public static void test3(){
        DocumentadorController obj = new DocumentadorController();
        obj.filtroTipo='Trigger';
        obj.counter=40;
        obj.PAGE_SIZE=25;
        obj.total_size=25;
        obj.Next();
        obj.filterType();
    }
    @IsTest   public static void test4(){
        DocumentadorController obj = new DocumentadorController();
        obj.filtroTipo='Recurso Estático';
        obj.counter=40;
        obj.PAGE_SIZE=25;
        obj.total_size=25;
        obj.End();
        obj.filterType();
    }
    
    @IsTest   public static void test5(){
        DocumentadorController obj = new DocumentadorController();
        obj.filtroTipo='Visualforce Page';
        
        obj.filterType();
        obj.counter=40;
        obj.PAGE_SIZE=25;
        obj.total_size=25;
        obj.getTotalPages();
        obj.getDisablePrevious();
    }
    
    @IsTest   public static void test6(){
        DocumentadorController obj = new DocumentadorController();
        obj.filtroTipo='Componente';
        obj.counter=40;
        obj.PAGE_SIZE=25;
        obj.total_size=25;
        obj.getDisableNext();
        obj.filterType();
    }
    
    @IsTest   public static void test7(){
        
        date inicio = date.today();
        date fin = date.today();
        
        List<ApexClass> clas ;
        clas=   [Select id from ApexClass limit 1];
        
        Documentador__c doc = new Documentador__c(Name='demo'
                                                  , Tipo__c='Clase Apex'
                                                  , FechaInicio__c=inicio
                                                  , FechaModif__c=fin
                                                  , IdComponente__c=clas.get(0).id
                                                  ,Observacion__c ='prueba'
                                                 );
        insert doc;
        
        List<ApexTrigger> tri ;
        tri=   [Select id from ApexTrigger limit 1];
        
        Documentador__c doc2 = new Documentador__c(Name='Trigger'
                                                   , Tipo__c='Trigger'
                                                   , FechaInicio__c=inicio
                                                   , FechaModif__c=fin
                                                   , IdComponente__c=tri.get(0).id
                                                   ,Observacion__c ='prueba'
                                                  );
        insert doc2;
        
        DocumentadorController obj = new DocumentadorController();
        obj.actualizarDocumentador();
    }
    
}