@IsTest public class LEAD_BecasCtrlTest {
    
    @IsTest   public static void inicializaBeca(){
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
       // upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1; 
        
        Instituto__c inst= new Instituto__c(Name='INSTITUTO DE ESTUDIOS UNIVERSITARIOS, S. C.'
                                            ,PrefijoOXXO__c='61'
                                           );
        insert inst;
        
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo',
                                          Instituto__c=inst.id
                                         );
        insert plan;
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                           TipoCatalogo__c='Nivel');
        insert catn; 
        
        Programa__c pr =new Programa__c(Name='demo');
        insert pr;
        
        Catalogo__c cat = new Catalogo__c(Name='Online',
                                          TipoCatalogo__c='Modalidad');
        insert cat;
        
        
        OfertaEducativa__c oe= new OfertaEducativa__c(Programa__c=pr.id,
                                                      Modalidad__c=cat.Id,
                                                      Nivel__c=catn.Id,
                                                      Plantel__c=plan.id);
        insert oe; 
        
        Lead lead = new Lead(LastName='demo',
                             Folio__c='212', 
                             Nivel__c=catn.Id
                             ,Plantel__c=plan.Id,
                             TipoBeca__c='Comercial',
                             OfertaEducativa__c=oe.Id,
                             PorcentajeBeca__c=10
                            );
        insert lead;
        
        Descuento__c des = new Descuento__c(Name='P0 1/09-30/09',
                                            TipoDescuento__c='Promoción 0' ,
                                            Lead__c=lead.Id 
                                           );
        
        insert des;
        
        LEAD_BecasCtrl obj = new LEAD_BecasCtrl();
        
        obj.setCandidato( lead);
        obj.PorcentajeBecaString='10';
        obj.setBecaAplicada(); 
    }
    
    
      @IsTest   public static void inicializaBeca2(){
        
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        //upsert configuracionNegocio;
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1; 
        
        Instituto__c inst= new Instituto__c(Name='INSTITUTO DE ESTUDIOS UNIVERSITARIOS, S. C.'
                                            ,PrefijoOXXO__c='61'
                                           );
        insert inst;
        
        Plantel__c plan = new Plantel__c (Calle__c='demo',
                                          RazonSocial__c='demo',
                                          Instituto__c=inst.id
                                         );
        insert plan;
        
        Catalogo__c catn = new Catalogo__c(Name='Cursos y Diplomados',
                                           TipoCatalogo__c='Nivel');
        insert catn; 
        
        Programa__c pr =new Programa__c(Name='demo');
        insert pr;
        
        Catalogo__c cat = new Catalogo__c(Name='Online',
                                          TipoCatalogo__c='Modalidad');
        insert cat;
        
        
        OfertaEducativa__c oe= new OfertaEducativa__c(Programa__c=pr.id,
                                                      Modalidad__c=cat.Id,
                                                      Nivel__c=catn.Id,
                                                      Plantel__c=plan.id);
        insert oe; 
        
        Lead lead = new Lead(LastName='demo',
                             Folio__c='212', 
                             Nivel__c=catn.Id
                             ,Plantel__c=plan.Id,
                             TipoBeca__c='Convenio',
                             OfertaEducativa__c=oe.Id,
                             PorcentajeBeca__c=10
                            );
        insert lead;
        
        Descuento__c des = new Descuento__c(Name='P0 1/09-30/09',
                                            TipoDescuento__c='Promoción 0' ,
                                            Lead__c=lead.Id 
                                           );
        
        insert des;
          
          Beca__c beca = new Beca__c(BecaPromocion__c=false,
                                     Beneficiados__c ='Alumnos', 
                                     CantidadInscritos__c =10,
                                     RecordTypeId = Schema.SObjectType.Beca__c.getRecordTypeInfosByName().get('Beca Convenio').getRecordTypeId() 
                                     //TipoBeca__c='Convenio'
                                    );
          
          insert beca;
          
          BecaConvenioAsignacion__c becasig = new BecaConvenioAsignacion__c(  Name='demo',
                                                                       Descuento__c=des.id,
                                                                          BecaConvenio__c=beca.Id 
                                                                       
                                                                      );
        insert becasig;
              
              
              
              
              
          /*    Name, Baja__c, Nivel__c, Plantel__c, Programa__c, BecaConvenio__c, 
                                     BecaConvenio__r.Name, BecaConvenio__r.PorcentajeBeca__c, BecaConvenio__r.Inicial__c, BecaConvenio__r.Final__c, 
                                     BecaConvenio__r.Incrementos__c, BecaConvenio__r.TipoPorcentaje__c,BecaConvenio__r.TipoBeca__c , BecaConvenio__r.NombreConvenio__c  
                                     FROM BecaConvenioAsignacion__c 
                                     WHERE BecaConvenio__r.TipoBeca__c='Convenio' 
          
           */
          
        LEAD_BecasCtrl obj = new LEAD_BecasCtrl();
        
        obj.setCandidato( lead);
        obj.PorcentajeBecaString='10';
        obj.setBecaAplicada(); 
          
          obj.guardaSolicitudPromocion();
    }
    
}