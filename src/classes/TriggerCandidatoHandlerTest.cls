@IsTest public class TriggerCandidatoHandlerTest {
    @isTest(Seealldata=true)    public static void  TriggerCandidatoHandlerTest(){
        
        Test.startTest();
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        date inicio = date.newInstance(2020, 1, 30);
        date fin = date.newInstance(2020, 2, 30);
        
        Lead lead;
        
        Periodo__c per = new Periodo__c(Name='agosto 2020'
                                        ,FechaInicio__c=inicio
                                        ,FechaInicioReal__c=inicio
                                        ,FechaFin__c =fin
                                        ,FechaFinReal__c =fin
                                        ,Activo__c='Activo'
                                        ,Autorizado__c=true
                                        ,IdPeriodo__c=87878
                                        ,ActivoPresencial__c=true
                                       );
        insert per;
        
        Catalogo__c cat = new Catalogo__c(Name='Online',
                                          TipoCatalogo__c='Modalidad');
        insert cat;
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                           TipoCatalogo__c='Nivel');
        insert catn;
        
        Instituto__c inst= new Instituto__c(Name='INSTITUTO DE ESTUDIOS UNIVERSITARIOS, S. C.'
                                            ,PrefijoOXXO__c='61'
                                           );
        insert inst;
        Plantel__c plan = new Plantel__c (Calle__c='demo'
                                          , RazonSocial__c='demo'
                                          , Instituto__c=inst.id
                                         );
        insert plan;
        
        Programa__c pr =new Programa__c(Name='demo');
        insert pr;
        
        Aula__c aul = new Aula__c(Cupo__c=23
                                  , Name='demo'
                                  ,Plantel__c=plan.Id
                                 );
        insert aul;
        
        BecaConvenioAsignacion__c beca = new BecaConvenioAsignacion__c(Name='demo');
        insert beca;
        
        Ubicacion__c ub = new Ubicacion__c(Name='MEXICO'
                                           ,IdUbicacion__c='157'
                                           ,TipoUbicacion__c='País'
                                          );
        insert ub;
        
        Ubicacion__c ubi = new Ubicacion__c(Name='D. F.'
                                            ,Abreviatura__c='DF2'
                                            ,IdUbicacion__c='9'
                                            ,IdEstadoPais__c=ub.IdUbicacion__c
                                            ,TipoUbicacion__c ='Estado'
                                           ); 
        insert ubi;
        
        Ubicacion__c mun = new Ubicacion__c(Name='San José de Gracia'
                                            ,Cabecera__c='San José de Gracia'
                                            ,Capital__c='0'
                                            ,IdUbicacion__c=ubi.IdUbicacion__c
                                            ,IdEstadoPais__c=ub.IdUbicacion__c
                                            , TipoUbicacion__c ='Municipio'
                                           ); 
        insert mun;
        
        OfertaEducativa__c oe= new OfertaEducativa__c(Programa__c=pr.id
                                                      ,Modalidad__c=cat.Id
                                                      ,Nivel__c=catn.Id
                                                      ,Plantel__c=plan.id
                                                      ,Periodo__c=per.Id
                                                      ,Estatus__c='Activo'
                                                     );
        insert oe;
        
        Grupo__c grupo = new Grupo__c(Name='demo'
                                      , AulaAsignada__c=aul.Id
                                      , Estatus__c='Planeado'
                                      , Activo__c='Activo'
                                      , Inscritos__c=10
                                      , Cupo__c=15
                                     );
        insert grupo;
        
        
        RecordType rt = [SELECT id,Name FROM RecordType WHERE DeveloperName = 'PersonAccount'];
        
        Account account = new Account(
        	LastName = 'TEST',
        	RecordTypeId = rt.Id,
        	Pais__c = ub.Id,
        	PersonEmail = 'mail@mail.com'
        );
        insert account;
        
        Opportunity opp=new Opportunity(Name='demodan'
                                        ,StageName ='dd'
                                        ,CloseDate= Date.today()
                                        ,Folio__c='9983434'
                                        ,Nivel__c=catn.Id
                                        ,Plantel__c=plan.Id
                                        ,AccountId = account.Id
                                       );
        insert opp;
        
        User use =[select Id from User where Id = :UserInfo.getUserId() limit 1];
        
        Promotor__c prom= new Promotor__c (
                                           Plantel__c=plan.Id
                                           , OrdenNumerico__c=989
                                           , Promotor__c=use.Id
                                          );
        insert prom;
        
        lead= new Lead( LastName='demo'
                       ,OwnerId=use.Id
                       , AsignacionAutomatica__c=true
                       ,ApeMaterno__c='demo'
                       ,Modalidad__c=cat.Id
                       ,Email='dsanchez@ctconsulting.com.mx'
                       ,Plantel__c=plan.id
                       ,Nivel__c=catn.Id
                       ,Programa__c =pr.Id
                       ,Folio__c = String.valueOf(nextFolio)
                       ,GrupoAsignado__c=grupo.Id  
                       ,SubOrigenCandidato__c='Vertical IEU'
                       ,ModalidadEjecutiva__c=false
                       ,ModalidadPresencial__c=true
                       ,ModalidadOnline__c=false
                       ,Promotor__c=prom.Id
                       ,TipoBeca__c='Convenio'
                       ,OfertaEducativa__c=oe.Id
                       ,PorcentajeBeca__c=10
                       ,Periodo__c=per.Id
                       ,BecaConvenioAsignacion__c=beca.Id 
                       ,AplicaPromocionCero__c=true
                       ,Pais__c=ub.Id
                       ,Estado__c=ubi.Id
                       ,Municipio__c=mun.Id
                       ,Inscripcion__c=333
                       ,Antologia__c=0
                       ,Colegiatura__c=5000
                       ,ExamenAdmision__c=300
                       ,Propedeutico__c=200
                       ,Uniforme__c=300
                      ); 
        insert lead;
        
        FichaPago__c fp = new FichaPago__c(Importe__c=33330,Descuento__c=4
                                           ,FolioLead__c= nextFolio
                                           ,Hasta__c =Date.today()
                                           ,MontoPagado__c =4545
                                           ,TotaPagar__c =4444
                                           ,RecibimosDe__c ='demo'
                                           ,Lead__c=lead.Id
                                           ,Plantel__c=plan.Id
                                          );
        insert fp; 
        

      
       //   ApexPages.StandardController sc = new ApexPages.standardController();
          TriggerCandidatoHandler obj = new TriggerCandidatoHandler();  

        
     //   obj.beforeInsert();
        Test.stopTest(); 
    } 
}