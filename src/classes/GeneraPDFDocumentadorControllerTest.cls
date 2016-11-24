@isTest public class GeneraPDFDocumentadorControllerTest {
    @IsTest   public static void test(){
        PageReference testPage = new PageReference('/apex/GeneraPDFDocumentador');
        testPage.getParameters().put('tipoArchivo','Clase Apex');
        Test.setCurrentPage(testPage);
        testPage.getUrl();        
        GeneraPDFDocumentadorController obj = new GeneraPDFDocumentadorController();
        obj.ListaDocumentador();
    }
}