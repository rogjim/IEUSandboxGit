@IsTest (seeAllData = true)
public class BarCodeMovilCtrlTest {
   
    
    @IsTest
    public static void refactorDate(){
        
        BarCodeMovilCtrl.refactorDate(Date.today());
    }
    @IsTest
    public static void getFichasFromString(){
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        //upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 100000;
        
        Instituto__c inst= new Instituto__c(Name='INSTITUTO DE ESTUDIOS UNIVERSITARIOS, S. C.'
                                            ,PrefijoOXXO__c='61'
                                           );
        insert inst;
        Plantel__c plan = new Plantel__c (Calle__c='dem3o',
                                          RazonSocial__c='de3mo',
                                          Instituto__c=inst.id
                                         );
        insert plan;
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                           TipoCatalogo__c='Nivel');
        insert catn;
        
        Lead lead = new Lead(LastName='demFDFDos',
                             Email='dsanDchez@ctconsulting.com.mx',
                             Nivel__c=catn.Id
                             ,Plantel__c=plan.Id
                            );
        insert lead;
        
        FichaPago__c fp = new FichaPago__c(Importe__c=3330,
                                           Descuento__c=4,
                                           FolioLead__c= nextFolio,
                                           Hasta__c =Date.today(),
                                           MontoPagado__c =4545,
                                           TotaPagar__c =44424,
                                           RecibimosDe__c ='JEJdemoS'  ,
                                           // Oportunidad__c=opp.Id,
                                           Lead__c=lead.Id
                                           ,  Plantel__c=plan.Id
                                          );
        insert fp;
        
        String ids=fp.Id;
        BarCodeMovilCtrl.getFichasFromString(ids);
    }
    
    @IsTest   public static void getProgramasRelacionados(){
        
        Programa__c pr =new Programa__c(Name='demo');
        insert pr;
        String ids=pr.Id;
        BarCodeMovilCtrl.getProgramasRelacionados(ids);
    }
    
    @IsTest   public static void GetResourceURL(){
        
        List<StaticResource> resourceList= [SELECT Name FROM StaticResource limit 1];
        String resourceName=String.valueOf(resourceList.get(0));           
        BarCodeMovilCtrl.GetResourceURL(resourceName);
    }
    
    @IsTest   public static void encodeASCII(){
        
        String cadena='demo';
        BarCodeMovilCtrl.encodeASCII(cadena);
    }    
    
    @IsTest   public static void BarCodeMovilCtrl(){
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        //upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 11000121;
        
        Instituto__c inst= new Instituto__c(Name='INSTITUTO DE DERSITARIOS, S. C.'
                                            ,PrefijoOXXO__c='61'
                                           );
        insert inst;
        Plantel__c plan = new Plantel__c (Calle__c='d1emo',
                                          RazonSocial__c='de2mo',
                                          Instituto__c=inst.id
                                         );
        insert plan;
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                           TipoCatalogo__c='Nivel');
        insert catn;
        
        Ubicacion__c ub = new Ubicacion__c(Name='MEXICO'
                                           ,IdUbicacion__c='157'
                                           ,TipoUbicacion__c='País'
                                          );
        insert ub;
        
        Lead lead = new Lead(LastName='dem2o',
                             Email='dsan221chez@ctconsulting.com.mx',
                             Nivel__c=catn.Id
                             ,Plantel__c=plan.Id,
                             Pais__c = ub.Id
                            );
        insert lead;
        
        Programa__c pr =new Programa__c(Name='demo');
        insert pr;
        
        FichaPago__c fp = new FichaPago__c(Importe__c=123,
                                           Descuento__c=4,
                                           FolioLead__c= nextFolio,
                                           Hasta__c =Date.today()+100,
                                           MontoPagado__c =4545,
                                           TotaPagar__c =4444,
                                           RecibimosDe__c ='demo'  ,
                                           Lead__c=lead.Id
                                           ,  Plantel__c=plan.Id,
                                           ProgramasRelacionados__c=pr.Id
                                          );
        
        insert fp; 
         
        ApexPages.StandardController controller = new ApexPages.StandardController(fp);
        Test.setCurrentPageReference(new pageReference('Page.mypage')); 
        System.currentPageReference().getparameters().put('ids' , fp.id); 
        BarCodeMovilCtrl crtl = new BarCodeMovilCtrl(); 
    }   
}