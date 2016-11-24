@isTest
public class UtilsOfertaTest {
    @IsTest   
    public static void getModalidades(){
        
        List<SelectOption> options = new List<SelectOption>();
        options=UtilsOferta.getModalidades();
    }
    @IsTest   
    public static void getPlanteles(){
        
        List<SelectOption> planteles = new List<SelectOption>();
        
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo'
                                         );
        insert  plan;
        
        Programa__c pr =new Programa__c(Name='INGENIERÍA EN SISTEMAS COMPUTACIONALES');
        insert pr;      
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                           TipoCatalogo__c='Nivel');
        insert catn;
        
        Catalogo__c cat = new Catalogo__c(Name='Online',
                                          TipoCatalogo__c='Modalidad');
        insert cat;
        
        OfertaEducativa__c obj = new OfertaEducativa__c(Conceptos__c   =  'Nuevo',
                                                        Modalidad__c =cat.Id,
                                                        Nivel__c=catn.Id,
                                                        Programa__c=pr.Id,
                                                        Plantel__c=plan.Id 
                                                       );
        insert obj;
        planteles=UtilsOferta.getPlanteles(obj.Modalidad__c);
    }
    @IsTest   public static void getNiveles(){
        
        List<SelectOption> niveles = new List<SelectOption>();
        
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo'
                                         );
        insert  plan;
        
        Programa__c pr =new Programa__c(Name='INGENIERÍA EN SISTEMAS COMPUTACIONALES');
        insert pr;      
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                           TipoCatalogo__c='Nivel');
        insert catn;
        
        Catalogo__c cat = new Catalogo__c(Name='Online',
                                          TipoCatalogo__c='Modalidad');
        insert cat;
        
        OfertaEducativa__c obj = new OfertaEducativa__c(Conceptos__c   =  'Nuevo',
                                                        Modalidad__c =cat.Id,
                                                        Nivel__c=catn.Id,
                                                        Programa__c=pr.Id,
                                                        Plantel__c=plan.Id);
        insert obj;
        niveles=UtilsOferta.getNiveles(obj.Plantel__c, obj.Modalidad__c);
    }
    @IsTest   public static void getProgramas(){
        
        List<SelectOption> programas = new List<SelectOption>();
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo'
                                         );
        insert  plan;
        
        Programa__c pr =new Programa__c(Name='INGENIERÍA EN SISTEMAS COMPUTACIONALES');
        insert pr;      
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                           TipoCatalogo__c='Nivel');
        insert catn;
        
        Catalogo__c cat = new Catalogo__c(Name='Online',
                                          TipoCatalogo__c='Modalidad');
        insert cat;
        
        OfertaEducativa__c obj = new OfertaEducativa__c(Conceptos__c   =  'Nuevo',
                                                        Modalidad__c =cat.Id,
                                                        Nivel__c=catn.Id,
                                                        Programa__c=pr.Id,
                                                        Plantel__c=plan.Id);
        insert obj;
        programas=UtilsOferta.getProgramas(obj.Plantel__c, obj.Modalidad__c,obj.Nivel__c);
    }
    
    @IsTest   public static void getProgramasMoviles(){
        
        List<SelectOption> programas = new List<SelectOption>();
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        Programa__c pr =new Programa__c(Name='INGENIERÍA EN SISTEMAS COMPUTACIONALES');
        insert pr;
        
        Instituto__c inst= new Instituto__c(Name='INSTITUTO DE ESTUDIOS UNIVERSITARIOS, S. C.'
                                            ,PrefijoOXXO__c='61'
                                           );
        insert inst;
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo',
                                          Instituto__c=inst.id
                                         );
        insert plan;
        
        
        
        FichaPago__c fichp = new FichaPago__c(FolioLead__c= nextFolio,
                                              TotaPagar__c =333,
                                              ProgramasRelacionados__c=pr.Id,
                                              Importe__c=33330,
                                              Descuento__c=4, 
                                              MontoPagado__c =4545, 
                                              Plantel__c=plan.Id
                                             );
        fichp.Hasta__c = Date.today();
        insert fichp;
        programas=UtilsOferta.getProgramasMoviles(fichp.Id);
    }
    @IsTest   public static void getModalidadesMoviles(){
        
        List<OfertaEducativa__c> periodos = new List<OfertaEducativa__c>();
        
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo'
                                         );
        insert  plan;
        
        Programa__c pr =new Programa__c(Name='INGENIERÍA EN SISTEMAS COMPUTACIONALES');
        insert pr;      
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                           TipoCatalogo__c='Nivel');
        insert catn;
        
        Catalogo__c cat = new Catalogo__c(Name='Online',
                                          TipoCatalogo__c='Modalidad');
        insert cat;
        
        OfertaEducativa__c obj = new OfertaEducativa__c(Conceptos__c   =  'Nuevo',
                                                        Modalidad__c =cat.Id,
                                                        Nivel__c=catn.Id,
                                                        Programa__c=pr.Id,
                                                        Plantel__c=plan.Id);
        insert obj;
        periodos=UtilsOferta.getModalidadesMoviles(obj.Plantel__c,obj.Periodo__c, obj.Nivel__c, obj.Programa__c);
    }
    @IsTest   public static void getPeriodo(){
        
        List<SelectOption> periodos = new List<SelectOption>();
        
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo'
                                         );
        insert  plan;
        
        Programa__c pr =new Programa__c(Name='INGENIERÍA EN SISTEMAS COMPUTACIONALES');
        insert pr;      
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                           TipoCatalogo__c='Nivel');
        insert catn;
        
        Catalogo__c cat = new Catalogo__c(Name='Online',
                                          TipoCatalogo__c='Modalidad');
        insert cat;
        
        OfertaEducativa__c obj = new OfertaEducativa__c(Conceptos__c   =  'Nuevo',
                                                        Modalidad__c =cat.Id,
                                                        Nivel__c=catn.Id,
                                                        Programa__c=pr.Id,
                                                        Plantel__c=plan.Id);
        insert obj;
        periodos=UtilsOferta.getPeriodo(obj.Plantel__c,obj.Modalidad__c,  obj.Nivel__c, obj.Programa__c);
    }
    
    @IsTest   public static void getPeriodos(){
        
        List<OfertaEducativa__c> periodos = new List<OfertaEducativa__c>();
        
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo'
                                         );
        insert  plan;
        
        Programa__c pr =new Programa__c(Name='INGENIERÍA EN SISTEMAS COMPUTACIONALES');
        insert pr;      
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                           TipoCatalogo__c='Nivel');
        insert catn;
        
        Catalogo__c cat = new Catalogo__c(Name='Online',
                                          TipoCatalogo__c='Modalidad');
        insert cat;
        
        OfertaEducativa__c obj = new OfertaEducativa__c(Conceptos__c   =  'Nuevo',
                                                        Modalidad__c =cat.Id,
                                                        Nivel__c=catn.Id,
                                                        Programa__c=pr.Id,
                                                        Plantel__c=plan.Id);
        insert obj;
        periodos=UtilsOferta.getPeriodos(obj.Plantel__c,obj.Modalidad__c,  obj.Nivel__c, obj.Programa__c);
    }
    @IsTest   public static void getPaises(){
        List<Ubicacion__c> options = new List<Ubicacion__c>();
        options=UtilsOferta.getPaises();
    }
    @IsTest   public static void getEstados(){
        Ubicacion__c obj = new Ubicacion__c(Abreviatura__c ='Nuevo');
        insert obj;
        List<Ubicacion__c> options = new List<Ubicacion__c>();
        options=UtilsOferta.getEstados(obj.IdEstadoPais__c);
    }
    @IsTest   public static void getMunicipios(){ 
        Ubicacion__c obj = new Ubicacion__c(Abreviatura__c ='Nuevo',
                                            IdEstadoPais__c ='7');
        insert obj;
        List<SelectOption> options = new List<SelectOption>();
        options=UtilsOferta.getMunicipios(obj.IdEstadoPais__c);
    }
}