@IsTest(seeAllData=true)
public class BarCodeLeadCtrlTest {
    /*
    @testSetup
    public static void testDataFactory(){
        Document documento = new Document(name = 'Nuevo Logo IEU');
    }*/
    @IsTest
    public static void sendMail(){
        
        Date Hasta=date.today();
        String nota1='';
        String nota2='';
        String concepto='concepto';
        String leadmail='dsanchez@ctconsulting.com.mx';
        String mailOwner = 'demos@ctconsulting.com.mx';
        String recibimosde='demo';
        String folioR='folio';
        String pagoR='pago'; 
        String refHSBC='HSBC';
        String refOXXO='Oxxo';
        String encabezado='encabezado';
        String HastaString=  string.valueOfGmt(Hasta);
        String numServicio = '1234';
        
        Test.setCurrentPageReference(new PageReference('Page.myPage'));
        
        System.currentPageReference().getparameters().put('hasta' , HastaString);
        System.currentPageReference().getparameters().put('pago' , pagoR);
        System.currentPageReference().getparameters().put('Nota1' , nota1);
        System.currentPageReference().getparameters().put('Nota2' , nota2);
        System.currentPageReference().getparameters().put('folio' , folioR);
        System.currentPageReference().getparameters().put('HSBC' , refHSBC);
        System.currentPageReference().getparameters().put('Oxxo' , refOXXO);
        System.currentPageReference().getparameters().put('Concepto' , concepto);
        System.currentPageReference().getparameters().put('encabezado' , encabezado);
        System.currentPageReference().getparameters().put('numServicio' , numServicio);
        System.currentPageReference().getparameters().put('pago', pagoR);
        
        //apexpages.currentpage().getparameters().put('pago', pagoR);
        BarCodeLeadCtrl controller  = new BarCodeLeadCtrl() ;
        
        BarCodeLeadCtrl.sendMail(hasta, nota1, nota2, concepto, leadmail, recibimosde, folioR, pagoR, refHSBC, refOXXO, encabezado, numServicio, mailOwner) ;
    }
    
}