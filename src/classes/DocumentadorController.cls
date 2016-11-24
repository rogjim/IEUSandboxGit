public class DocumentadorController {
    /*Variables Globales*/
    public String paramValue {
        public get;
        public set {
            paramValue = value;
        }
    }
    public List<Documentador__c> documentador;
    public List<Documentador__c> documentadorAux{get;set;}
    public List<Documentador__c> docAll{get;set;}
    public List<Documentador__c> docAllAux{get;set;}
    public List<Documentador__c> docApexClass{get;set;}
    public List<Documentador__c> docApexTrigger{get;set;}
    public List<Documentador__c> docApexStaticResource{get;set;}
    public List<Documentador__c> docApexPage{get;set;}
    public List<Documentador__c> docApexComponent{get;set;}
    public List<Documentador__c> docApexObject{get;set;}
    public List<Documentador__c> docApexObjectCustom{get;set;}
    public List<Documentador__c> docApexConfPersonalizada{get;set;}
    public List<ApexClass> clases{get;set;}
    public List<ApexTrigger> triggers{get;set;}
    public List<StaticResource> staticresource{get;set;}
    public List<ApexPage> pages{get;set;}
    public List<ApexComponent> components{get;set;}
    public String filtroTipo;
    List<Documentador__c> docus;
    List<Documentador__c> docusEstandar;
    List<Documentador__c> AuxInsertaNuevo  ;  
    List<Documentador__c> AuxInsertaNuevo2  ;  
    List<Documentador__c> AuxActualizar  ;  
    List<Documentador__c> AuxActualizar2  ;  
    List<Documentador__c> ObjetoEstandar  ;  
    List<Documentador__c> ObjetoPersonalizado  ;  
    Documentador__c      docu;
    Documentador__c      docuEstandar;
    Documentador__c      docuPersonalizado;
    Documentador__c      docu2;
    Documentador__c      documentosActualizar;
    Boolean existe=false;
    public   Integer PAGE_SIZE = 50;//Limite de registros por página que se muestran en la visual force
    private    Integer PAGE_SIZEAUX = 0;
    //pagination information
    public integer counter=0;  //keeps track of the offset
    //  private integer list_size=10; //sets the page size or number
    public integer total_size; //used to show user the total size
    public integer inicioidx=0;
    public integer finidx=0;
    List<Id> ids;
    List<Id> idsSR;
    public  Integer contDocus=0;
    public  Integer contDocusEstandar=0;
    Integer contclasses=0;
    Integer conttriggers=0;
    Integer contvp=0;
    Integer contsr=0;
    Integer contcomponent=0;
    Integer contObject=0;
    Integer contObjetoEstandar=0;
    Integer contObjetoPersonalizado=0;
    
    //*
    //*Constructor   
    //*
    
    public DocumentadorController(){
        
        //list<schema.sObjectType> allObjects = Schema.getGlobalDescribe().Values();
        
        documentador = new List<Documentador__c>();
        documentadorAux = new List<Documentador__c>();
        docAll = new List<Documentador__c>();
        docApexClass = new List<Documentador__c>();
        docApexTrigger = new List<Documentador__c>();
        docApexStaticResource =  new List<Documentador__c>();
        docApexPage =  new List<Documentador__c>();
        docApexComponent =  new List<Documentador__c>();
        docApexObject =  new List<Documentador__c>();
        docApexObjectCustom =  new List<Documentador__c>();
        clases = [SELECT Id, Name, CreatedDate, LastModifiedDate FROM ApexClass]; 
        triggers = [SELECT Id, Name, CreatedDate, LastModifiedDate FROM ApexTrigger];
        staticresource = [SELECT Id,  Name, CreatedDate, LastModifiedDate, Description FROM StaticResource];
        pages = [SELECT Id,  Name, CreatedDate, LastModifiedDate, Description FROM ApexPage];
        components = [SELECT Id,  Name, CreatedDate, LastModifiedDate, Description FROM ApexComponent];
        //   confPers = [SELECT Id,  Name, CreatedDate, LastModifiedDate, Description FROM CustomSetting];
        
    }
    
    /*********Getters and Setters**********/
    public List<Documentador__c> getDocumentador(){
        return this.documentador;
    }
    
    public String getFiltroTipo(){
        return this.filtroTipo;
    }
    public void setFiltroTipo(String filtroTipo){
        this.filtroTipo = filtroTipo;
    }   
    
    //*
    //Actualiza los objetos de Documentador, inserta si hay un nuevo elemento o actualiza si hay cambios
    //@return Pagereference null
    //AuxInsertaNuevo--> lista auxiliar donde se guarda todos datos nuevos
    //docus= lista que trae todos los archivos dentro del objeto Documentador__c   
    //docu=objeto de tipo Documentador__c donde se guardan los datos de un nuevo registro para insertarlos a AuxInsertaNuevo
    //*
    
    public PageReference actualizarDocumentador(){
        
        //Actualización de contenido en Documentador sobre Clases 
        AuxInsertaNuevo  = new List<Documentador__c>();      
        AuxActualizar  = new List<Documentador__c>();  
        ids = new List<Id>();
        for (ApexClass cla: clases) {
            ids.add(cla.Id);
        } 
        docus = new List<Documentador__c>();
        docus = [SELECT Id, Name, Tipo__c, FechaInicio__c, FechaModif__c, IdComponente__c,Observacion__c 
                 FROM Documentador__c 
                 WHERE (Documentador__c.IdComponente__c  IN :ids) AND Documentador__c.Tipo__c = 'Clase Apex'];        
        contclasses=0;
        
        docu = new Documentador__c();
        Documentador__c demo = new Documentador__c();
        existe=false;
        for (ApexClass clas: clases) {  
            contDocus=0;
            if(docus.size()>0){
                for (Documentador__c d: docus) { 
                    if(clases.get(contclasses).Id==docus.get(contDocus).IdComponente__c){
                        existe=true;
                        break;
                    }else{ 
                        existe=false; 
                    }
                    contDocus++;
                }                  
                if(existe){
                    //  Actualiza los datos
                    docus.get(contDocus).Name = clases.get(contclasses).Name;
                    docus.get(contDocus).FechaModif__c=clases.get(contclasses).LastModifiedDate.date()+10;   
                    docus.get(contDocus).Tipo__c = 'Clase Apex';
                    docus.get(contDocus).FechaInicio__c = clases.get(contclasses).CreatedDate.date(); 
                    docus.get(contDocus).IdComponente__c = clases.get(contclasses).Id;
                    AuxActualizar.add(docus.get(contDocus));
                    docApexClass.add(docus.get(contDocus)); 
                }else{ 
                    //no existe  debe insertar
                    docu.Id = null;
                    docu.Name = clases.get(contclasses).Name;
                    docu.Tipo__c = 'Clase Apex';                    
                    docu.FechaInicio__c = clases.get(contclasses).CreatedDate.date();
                    docu.FechaModif__c = clases.get(contclasses).LastModifiedDate.date();
                    docu.IdComponente__c = clases.get(contclasses).Id;
                    AuxInsertaNuevo.add(docu);  
                    docApexClass.add(docu);
                    docu = new Documentador__c(); 
                } 
            }else{
                //inserta toda la lista
                docu.Id = null;
                docu.Name = clases.get(contclasses).Name;
                docu.Tipo__c = 'Clase Apex';                    
                docu.FechaInicio__c = clases.get(contclasses).CreatedDate.date();
                docu.FechaModif__c = clases.get(contclasses).LastModifiedDate.date();
                docu.IdComponente__c = clases.get(contclasses).Id; 
                AuxInsertaNuevo.add(docu); 
                docApexClass.add(docu);
                docu = new Documentador__c(); 
            }
            contclasses++;
        } 
        
        if( AuxInsertaNuevo.size()>0 ){
            insert AuxInsertaNuevo;
        } 
        if( AuxActualizar.size()>0 ){
            update AuxActualizar; 
        } 
        
        docAll.clear(); 
        docAll.addAll(  docApexClass); 
        
        //Actualización de contenido en Documentador sobre Trigger       
        AuxInsertaNuevo  = new List<Documentador__c>();      
        AuxActualizar  = new List<Documentador__c>();     
        ids = new List<Id>();        
        for (ApexTrigger tri: triggers) {
            ids.add(tri.Id);
        } 
        
        docus = new List<Documentador__c>(); 
        docus = [SELECT Id, Name, Tipo__c, FechaInicio__c, FechaModif__c, IdComponente__c,
                 Observacion__c 
                 FROM Documentador__c 
                 WHERE (Documentador__c.IdComponente__c  IN :ids)  AND Documentador__c.Tipo__c = 'Trigger'];                    
        conttriggers=0;
        contDocus=0;
        
        documentosActualizar = new Documentador__c();
        docu = new Documentador__c();
        
        for (ApexTrigger c: triggers) { 
            contDocus=0;
            if(docus.size()>0){
                for (Documentador__c d: docus) {
                    if(triggers.get(conttriggers).Id==docus.get(contDocus).IdComponente__c){
                        existe=true;
                        break;
                    }else{
                        existe=false;
                    }
                    contDocus++;
                } 
                if(existe){
                    //  Actualiza los datos
                    docus.get(contDocus).Name = triggers.get(conttriggers).Name;
                    docus.get(contDocus).FechaModif__c=triggers.get(conttriggers).LastModifiedDate.date()+10;   
                    docus.get(contDocus).Tipo__c = 'Trigger';
                    docus.get(contDocus).FechaInicio__c = triggers.get(conttriggers).CreatedDate.date(); 
                    docus.get(contDocus).IdComponente__c = triggers.get(conttriggers).Id; 
                    AuxActualizar.add(docus.get(contDocus));
                    docApexTrigger.add(docus.get(contDocus)); 
                }else{ 
                     //no existe  debe insertar
                    docu.Id = null;
                    docu.Name = triggers.get(conttriggers).Name;
                    docu.Tipo__c = 'Trigger';                    
                    docu.FechaInicio__c = triggers.get(conttriggers).CreatedDate.date();
                    docu.FechaModif__c = triggers.get(conttriggers).LastModifiedDate.date();
                    docu.IdComponente__c = triggers.get(conttriggers).Id;
                    AuxInsertaNuevo.add(docu); 
                    docApexTrigger.add(docu);
                    docu = new Documentador__c();
                } 
            }else{
                 //inserta toda la lista
                docu.Id = null;
                docu.Name = triggers.get(conttriggers).Name;
                docu.Tipo__c = 'Trigger';                    
                docu.FechaInicio__c = triggers.get(conttriggers).CreatedDate.date();
                docu.FechaModif__c = triggers.get(conttriggers).LastModifiedDate.date();
                docu.IdComponente__c = triggers.get(conttriggers).Id; 
                //     docu.Observacion__c = triggers.get(conttriggers).Description;
                AuxInsertaNuevo.add(docu); 
                docApexTrigger.add(docu);
                docu = new Documentador__c(); 
            }
            conttriggers++;
        } 
        
        if( AuxInsertaNuevo.size()>0 ){
            insert AuxInsertaNuevo;
        }
        // System.debug('tamaño lista trigger '); 
        if( AuxActualizar.size()>0 ){
            update AuxActualizar; 
        } 
        
        // System.debug('fin ciclo  trigger');
        
        docAll.addAll(  docApexTrigger);
        
        
        
        
        
        
        
        
        
        //Actualización de contenido en Documentador sobre Visualforce Page       
        AuxInsertaNuevo  = new List<Documentador__c>();      
        AuxActualizar  = new List<Documentador__c>();     
        ids = new List<Id>();   
        for (ApexPage pag: pages) {
            ids.add(pag.Id);
        }  
        
        
        docus = new List<Documentador__c>(); 
        docus = [SELECT Id, Name, Tipo__c, FechaInicio__c, FechaModif__c, IdComponente__c,
                 Observacion__c 
                 FROM Documentador__c 
                 WHERE (Documentador__c.IdComponente__c  IN :ids)  AND Documentador__c.Tipo__c = 'Visualforce Page'];                    
        contvp=0; 
        contDocus=0; 
        docu = new Documentador__c();
        
        for (ApexPage pa: pages) { 
            contDocus=0;
            if(docus.size()>0){
                for (Documentador__c d: docus) {
                    if(pages.get(contvp).Id==docus.get(contDocus).IdComponente__c){
                        existe=true;
                        break;
                    }else{
                        existe=false;
                    }
                    contDocus++;
                } 
                if(existe){
                     //  Actualiza los datos
                    docus.get(contDocus).Name = pages.get(contvp).Name;
                    docus.get(contDocus).FechaModif__c=pages.get(contvp).LastModifiedDate.date()+10;   
                    docus.get(contDocus).Tipo__c = 'Visualforce Page';
                    docus.get(contDocus).FechaInicio__c = pages.get(contvp).CreatedDate.date(); 
                    docus.get(contDocus).IdComponente__c = pages.get(contvp).Id;
                    if(pages.get(contvp).Description !=null && pages.get(contvp).Description !=''){
                        docus.get(contDocus).Observacion__c = pages.get(contvp).Description;
                    } 
                    
                    
                    AuxActualizar.add(docus.get(contDocus));
                    docApexPage.add(docus.get(contDocus)); 
                }else{ 
                     //no existe  debe insertar
                    docu.Id = null;
                    docu.Name = pages.get(contvp).Name;
                    docu.Tipo__c = 'Visualforce Page';                    
                    docu.FechaInicio__c = pages.get(contvp).CreatedDate.date();
                    docu.FechaModif__c = pages.get(contvp).LastModifiedDate.date();
                    docu.IdComponente__c = pages.get(contvp).Id;
                    if(pages.get(contvp).Description !=null && pages.get(contvp).Description !=''){
                        docu.Observacion__c = pages.get(contvp).Description;
                    } 
                    
                    AuxInsertaNuevo.add(docu); 
                    docApexPage.add(docu);
                    docu = new Documentador__c();
                } 
            }else{
  //inserta toda la lista
                docu.Id = null;
                docu.Name = pages.get(contvp).Name;
                docu.Tipo__c = 'Visualforce Page';                    
                docu.FechaInicio__c = pages.get(contvp).CreatedDate.date();
                docu.FechaModif__c = pages.get(contvp).LastModifiedDate.date();
                docu.IdComponente__c = pages.get(contvp).Id; 
                if(pages.get(contvp).Description !=null && pages.get(contvp).Description !=''){
                    docu.Observacion__c = pages.get(contvp).Description;
                } 
                
                AuxInsertaNuevo.add(docu); 
                docApexPage.add(docu);
                docu = new Documentador__c(); 
            }
            contvp++;
        } 
        
        if( AuxInsertaNuevo.size()>0 ){
            insert AuxInsertaNuevo;
        }
        
        if( AuxActualizar.size()>0 ){
            update AuxActualizar; 
        } 
        
        
        docAll.addAll(  docApexPage);
        
        
        
        
        
        
        
        
        //Actualización de contenido en Documentador sobre Recurso Estaticos   
        AuxInsertaNuevo  = new List<Documentador__c>();      
        AuxActualizar  = new List<Documentador__c>();  
        idsSR= new List<Id>();  
        // ids = new List<Id>();   
        for (StaticResource sta: staticresource) {
            //   ids.add(sta.Id);
            idsSR.add(sta.Id);
        }  
        
        docus = new List<Documentador__c>(); 
        docus = [SELECT Id, Name, Tipo__c, FechaInicio__c, FechaModif__c, IdComponente__c,
                 Observacion__c 
                 FROM Documentador__c 
                 WHERE (Documentador__c.IdComponente__c  IN :idsSR)  AND Documentador__c.Tipo__c = 'Recurso Estático'];                    
        contsr=0; 
        contDocus=0; 
        docu = new Documentador__c();
        
        for (StaticResource st: staticresource) { 
            contDocus=0;
            if(docus.size()>0){
                for (Documentador__c d: docus) {
                    if(staticresource.get(contsr).Id==docus.get(contDocus).IdComponente__c){
                        existe=true;
                        break;
                    }else{
                        existe=false;
                    }
                    contDocus++;
                } 
                if(existe){
                  //  Actualiza los datos
                    docus.get(contDocus).Name = staticresource.get(contsr).Name;
                    docus.get(contDocus).FechaModif__c=staticresource.get(contsr).LastModifiedDate.date()+10;   
                    docus.get(contDocus).Tipo__c = 'Recurso Estático';
                    docus.get(contDocus).FechaInicio__c = staticresource.get(contsr).CreatedDate.date(); 
                    docus.get(contDocus).IdComponente__c = staticresource.get(contsr).Id;
                    if(staticresource.get(contsr).Description !=null && staticresource.get(contsr).Description !=''){
                        docus.get(contDocus).Observacion__c = staticresource.get(contsr).Description;
                    } 
                    
                    AuxActualizar.add(docus.get(contDocus)); 
                    docApexStaticResource.add(docus.get(contDocus)); 
                }else{ 
                    //no existe  debe insertar
                    docu.Id = null;
                    docu.Name = staticresource.get(contsr).Name;
                    docu.Tipo__c = 'Recurso Estático';                    
                    docu.FechaInicio__c = staticresource.get(contsr).CreatedDate.date();
                    docu.FechaModif__c = staticresource.get(contsr).LastModifiedDate.date();
                    docu.IdComponente__c = staticresource.get(contsr).Id;
                    if(staticresource.get(contsr).Description !=null && staticresource.get(contsr).Description !=''){
                        docu.Observacion__c = staticresource.get(contsr).Description;
                    } 
                    
                    //  docus.get(contDocus).Observacion__c = staticresource.get(contsr).Description;
                    AuxInsertaNuevo.add(docu); 
                    docApexStaticResource.add(docu);
                    docu = new Documentador__c();
                } 
            }else{
                 //inserta toda la lista
                docu.Id = null;
                docu.Name = staticresource.get(contsr).Name;
                docu.Tipo__c = 'Recurso Estático';                    
                docu.FechaInicio__c = staticresource.get(contsr).CreatedDate.date();
                docu.FechaModif__c = staticresource.get(contsr).LastModifiedDate.date();
                docu.IdComponente__c = staticresource.get(contsr).Id; 
                if(staticresource.get(contsr).Description !=null && staticresource.get(contsr).Description !=''){
                    docu.Observacion__c = staticresource.get(contsr).Description;
                } 
                AuxInsertaNuevo.add(docu); 
                docApexStaticResource.add(docu);
                docu = new Documentador__c(); 
            }
            contsr++;
        } 
        
        if( AuxInsertaNuevo.size()>0 ){
            insert AuxInsertaNuevo;
        }
        
        if( AuxActualizar.size()>0 ){
            update AuxActualizar; 
        } 
        
        
        docAll.addAll(  docApexStaticResource);
        
        
        
        
        //Actualización de contenido en Documentador sobre Componentes
        AuxInsertaNuevo  = new List<Documentador__c>();      
        AuxActualizar  = new List<Documentador__c>();     
        ids = new List<Id>();   
        for (ApexComponent com: components) {
            ids.add(com.Id);
        } 
        
        
        docus = new List<Documentador__c>(); 
        docus = [SELECT Id, Name, Tipo__c, FechaInicio__c, FechaModif__c, IdComponente__c,
                 Observacion__c 
                 FROM Documentador__c 
                 WHERE (Documentador__c.IdComponente__c  IN :ids)  AND Documentador__c.Tipo__c = 'Componente'];                    
        contcomponent=0; 
        contDocus=0; 
        docu = new Documentador__c();
        
        for (ApexComponent co: components) { 
            contDocus=0;
            if(docus.size()>0){
                for (Documentador__c d: docus) {
                    if(components.get(contcomponent).Id==docus.get(contDocus).IdComponente__c){
                        existe=true;
                        break;
                    }else{
                        existe=false;
                    }
                    contDocus++;
                } 
                if(existe){
                     //  Actualiza los datos
                    docus.get(contDocus).Name = components.get(contcomponent).Name;
                    docus.get(contDocus).FechaModif__c=components.get(contcomponent).LastModifiedDate.date()+10;   
                    docus.get(contDocus).Tipo__c = 'Componente';
                    docus.get(contDocus).FechaInicio__c = components.get(contcomponent).CreatedDate.date(); 
                    docus.get(contDocus).IdComponente__c = components.get(contcomponent).Id;
                    if(components.get(contcomponent).Description !=null && components.get(contcomponent).Description !=''){
                        docus.get(contDocus).Observacion__c = components.get(contcomponent).Description; 
                    }
                    
                    AuxActualizar.add(docus.get(contDocus)); 
                    docApexComponent.add(docus.get(contDocus)); 
                }else{ 
                    //no existe  debe insertar
                    docu.Id = null;
                    docu.Name = components.get(contcomponent).Name;
                    docu.Tipo__c = 'Componente';                    
                    docu.FechaInicio__c = components.get(contcomponent).CreatedDate.date();
                    docu.FechaModif__c = components.get(contcomponent).LastModifiedDate.date();
                    docu.IdComponente__c = components.get(contcomponent).Id;
                    if(components.get(contcomponent).Description !=null && components.get(contcomponent).Description !=''){
                        docu.Observacion__c = components.get(contcomponent).Description;
                    }
                    
                    AuxInsertaNuevo.add(docu); 
                    docApexComponent.add(docu);
                    docu = new Documentador__c();
                } 
            }else{
                  //inserta toda la lista
                docu.Id = null;
                docu.Name = components.get(contcomponent).Name;
                docu.Tipo__c = 'Componente';                    
                docu.FechaInicio__c = components.get(contcomponent).CreatedDate.date();
                docu.FechaModif__c = components.get(contcomponent).LastModifiedDate.date();
                docu.IdComponente__c = components.get(contcomponent).Id; 
                if(components.get(contcomponent).Description !=null && components.get(contcomponent).Description !=''){
                    docu.Observacion__c = components.get(contcomponent).Description; 
                } 
                AuxInsertaNuevo.add(docu); 
                docApexComponent.add(docu);
                docu = new Documentador__c(); 
            }
            contcomponent++;
        } 
        
        if( AuxInsertaNuevo.size()>0 ){
            insert AuxInsertaNuevo;
        }
        if( AuxActualizar.size()>0 ){
            update AuxActualizar; 
        } 
        
        docAll.addAll(  docApexComponent);
        
        //Actualización de contenido en Documentador sobre Objetos 
        
        List<String>   listObjetos = new List<String>(); 
        List<String>   listObjetosPersonalizados = new List<String>(); 
        List<String>   listObjetosEstandar = new List<String>(); 
        
        AuxInsertaNuevo  = new List<Documentador__c>();      
        AuxActualizar  = new List<Documentador__c>();   
        
        AuxInsertaNuevo2  = new List<Documentador__c>();      
        AuxActualizar2  = new List<Documentador__c>();   
        
        docuEstandar = new Documentador__c();
        docuPersonalizado = new Documentador__c(); 
        
        ObjetoEstandar = new    List<Documentador__c>()  ;  
        ObjetoPersonalizado = new    List<Documentador__c>() ;  
        
        docus = new List<Documentador__c>(); 
        
        
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        
        List<String> objectList = new List<String>();
        
        objectList.addAll(gd.keyset());
        
        Schema.DescribeSobjectResult[] results = Schema.describeSObjects(objectList );
        
        
 
        Set<String> myIDs = new Set<String>();
        
        String idAux='';
        Integer limite=0;
        for(Schema.DescribeSobjectResult res : results) {
            
            if(res.isCustom()){ 
                docuPersonalizado.Name =res.getLabel();
                //docuPersonalizado.Tipo__c = 'Objeto Personalizado';   
                docuPersonalizado.IdComponente__c = res.getKeyPrefix();   
                docuPersonalizado.Observacion__c='';
                if(res.getKeyPrefix()!=null && res.getKeyPrefix()!=''){
                    ObjetoPersonalizado.add(docuPersonalizado);    
                } 
                docuPersonalizado = new Documentador__c();  
            }else{ 
                docuEstandar.Name =res.getLabel();
               // docuEstandar.Tipo__c = 'Objeto';   
                docuEstandar.IdComponente__c = res.getKeyPrefix();   
                docuEstandar.Observacion__c='';
                if(res.getKeyPrefix()!=null && res.getKeyPrefix()!=''){
                    
                    
                    if(myIDs.contains(res.getLabel())== false){
                        idAux=res.getLabel();
                        
                        if(idAux.length()>=15){
                            idAux=idAux.substring(0,15)+res.getKeyPrefix();  
                            docuEstandar.IdComponente__c =idAux;
                            
                        }else{
                            limite= idAux.length();
                            idAux=idAux.substring(0,limite )+res.getKeyPrefix();  
                            docuEstandar.IdComponente__c =idAux;
                        }
                        
                        
                        
                        
                        
                        ObjetoEstandar.add(docuEstandar); 
                        myIDs.add(res.getLabel());
                    }
                    
                }
                docuEstandar = new Documentador__c();
                idAux='';
                limite=0;
            }  
        }
        
        contObjetoPersonalizado=0; 
        
        contDocus=0; 
        docu = new Documentador__c();
        docus = new List<Documentador__c>(); 
        System.debug('tamaño docus '+ docus.size());
        docus = [SELECT Id, Name, Tipo__c, FechaInicio__c, FechaModif__c, IdComponente__c,
                 Observacion__c 
                 FROM Documentador__c 
                 WHERE  Documentador__c.Tipo__c = 'Objeto Personalizado'];   
        
        System.debug('tamaño docus 2 '+ docus.size());
        for(integer oPersonalizado =0; oPersonalizado < ObjetoPersonalizado.size(); oPersonalizado++ ){
            contDocus=0; 
            if(docus.size()>0){    
                for (Documentador__c d: docus) {
                    if( ObjetoPersonalizado.get(oPersonalizado).IdComponente__c.equals(docus.get(contDocus).IdComponente__c)){
                        existe=true;
                        break;
                    }else{
                        existe=false;
                    }  
                    contDocus++;
                } 
                if(existe){ 
                      //  Actualiza los datos
                    docus.get(contDocus).Name =  ObjetoPersonalizado.get(contObjetoPersonalizado).Name;
                    docus.get(contDocus).Tipo__c = 'Objeto Personalizado';
                    docus.get(contDocus).IdComponente__c =   ObjetoPersonalizado.get(contObjetoPersonalizado).IdComponente__c;
                    
                    if(ObjetoPersonalizado.get(contObjetoPersonalizado).Observacion__c !=null && ObjetoPersonalizado.get(contObjetoPersonalizado).Observacion__c !=''){
                        
                        docus.get(contDocus).Observacion__c =ObjetoPersonalizado.get(contObjetoPersonalizado).Observacion__c;    
                    }
                   
                    AuxActualizar.add(docus.get(contDocus));
                    docApexObjectCustom.add(docus.get(contDocus)); 
                    
               
                    
                    
                }else{ 
                     //no existe  debe insertar
                    docu.Id = null;
                    docu.Name =   ObjetoPersonalizado.get(contObjetoPersonalizado).Name;
                    docu.Tipo__c = 'Objeto Personalizado';        
                    docu.IdComponente__c = ObjetoPersonalizado.get(contObjetoPersonalizado).IdComponente__c;
                    docu.Observacion__c = ObjetoPersonalizado.get(contObjetoPersonalizado).Observacion__c;
                   
                    
                    AuxInsertaNuevo.add(docu); 
                    docApexObjectCustom.add(docu);  
                    docu = new Documentador__c();
                } 
                
            }else{
                //inserta toda la lista
                docu.Id = null;
                docu.Name = ObjetoPersonalizado.get(contObjetoPersonalizado).Name;
                docu.Tipo__c = 'Objeto Personalizado';        
                docu.IdComponente__c = ObjetoPersonalizado.get(contObjetoPersonalizado).IdComponente__c;
                docu.Observacion__c = ObjetoPersonalizado.get(contObjetoPersonalizado).Observacion__c;
                // docu.Observacion__c = 'inserta  con lista vacia ';
                AuxInsertaNuevo.add(docu); 
                docApexObjectCustom.add(docu);   
                docu = new Documentador__c(); 
            }
            contObjetoPersonalizado++;
            
        } 
        
        contDocus=0; 
        docu = new Documentador__c();
        
        docusEstandar = new List<Documentador__c>(); 
        
        
        docusEstandar = [SELECT Id, Name, Tipo__c, FechaInicio__c, FechaModif__c, IdComponente__c,
                         Observacion__c 
                         FROM Documentador__c 
                         WHERE  Documentador__c.Tipo__c = 'Objeto'];  
        contObjetoEstandar=0; 
        
        
        
        
        for(integer oEstandar =0; oEstandar < ObjetoEstandar.size(); oEstandar++ ){
            contDocus=0; 
            if(docusEstandar.size()>0){    
                for (Documentador__c d: docusEstandar) {
                    if( ObjetoEstandar.get(oEstandar).IdComponente__c.equals(docusEstandar.get(contDocus).IdComponente__c)){
                        //  if( ObjetoEstandar.get(oEstandar).Name.equals(docusEstandar.get(contDocus).Name)){ 
                        existe=true;
                        break;
                    }else{
                        existe=false;
                    }  
                    contDocus++;
                } 
                if(existe){
                    //  Actualiza los datos
                    docusEstandar.get(contDocus).Tipo__c = 'Objeto';
                    docusEstandar.get(contDocus).IdComponente__c =   ObjetoEstandar.get(contObjetoEstandar).IdComponente__c;
                  
                    
                    if(ObjetoEstandar.get(contObjetoEstandar).Observacion__c !=null && ObjetoEstandar.get(contObjetoEstandar).Observacion__c !=''){
                        docusEstandar.get(contDocus).Observacion__c =ObjetoEstandar.get(contObjetoEstandar).Observacion__c;
                    }
                    //    docusEstandar.get(contDocus).Observacion__c ='actualiza';
                    AuxActualizar2.add(docusEstandar.get(contDocus));
                    docApexObject.add(docusEstandar.get(contDocus)); 
                    
                }else{ 
                    //no existe  debe insertar
                    docu.Id = null;
                    docu.Name =   ObjetoEstandar.get(contObjetoEstandar).Name;
                    docu.Tipo__c = 'Objeto';        
                    docu.IdComponente__c = ObjetoEstandar.get(contObjetoEstandar).IdComponente__c;
                    docu.Observacion__c = ObjetoEstandar.get(contObjetoEstandar).Observacion__c;
                   
                    AuxInsertaNuevo2.add(docu); 
                    docApexObject.add(docu);  
                    docu = new Documentador__c();
                } 
                
            }else{  
                //inserta toda la lista
                docu.Id = null;
                docu.Name = ObjetoEstandar.get(contObjetoEstandar).Name;
                docu.Tipo__c = 'Objeto';        
                docu.IdComponente__c = ObjetoEstandar.get(contObjetoEstandar).IdComponente__c;
              //  docu.Observacion__c = ObjetoEstandar.get(contObjetoEstandar).Observacion__c;
              docu.Observacion__c = 'No se utiliza para la implementación de este proyecto';
                AuxInsertaNuevo2.add(docu); 
                docApexObject.add(docu);   
                docu = new Documentador__c(); 
            }
            contObjetoEstandar++;
        } 
        
        if( AuxInsertaNuevo.size()>0 ){
            insert AuxInsertaNuevo;
        }
        
        if( AuxActualizar.size()>0 ){
            update AuxActualizar; 
        } 
        
        if( AuxInsertaNuevo2.size()>0 ){
            insert AuxInsertaNuevo2;
        }
        
        if( AuxActualizar2.size()>0 ){
            update AuxActualizar2; 
        } 
        
        docAll.addAll(  docApexObject);
        
        docAll.addAll(  docApexObjectCustom);        
        
        
        //----------------------------------------
        //
        
        docAll.sort(); 
        documentador = docAll; 
        setTotal_size( documentador.size()); 
        total_size =  getTotal_size(); 
        documentadorAux=filtralista(documentador);
        Beginning();
        
        return null;
    }
    
    public List <Documentador__c> filtralista(List<Documentador__c> documentador){
        //calculate range of records for capture
        
        inicioidx=(getPageNumber()-1)*PAGE_SIZE;
        finidx=getPageNumber()*PAGE_SIZE;
        documentadorAux = new List<Documentador__c>();
        if(finidx>documentador.size()){
            finidx=documentador.size();
        }
        for (Integer indice=inicioidx;indice<=documentador.size() ; indice++) {
            PAGE_SIZEAUX=finidx+PAGE_SIZE;
            if( finidx<=PAGE_SIZEAUX)
            {
                if(indice>=inicioidx && inicioidx<finidx  ){   
                    documentadorAux.add(documentador.get(indice));      
                    inicioidx++;
                }     
            }else{
                break;
            }
        } 
        return   documentadorAux;
    }
    
    /*
* Filtro por tipo de componente, se realiza un render sobre el Visualforce Page
*@return Pagereference null
*/
    public PageReference filterType(){
        if(filtroTipo.equals('Clase Apex')){
            docApexClass.sort();
            documentador = docApexClass;
            setTotal_size( documentador.size());
            total_size =   getTotal_size();
            Beginning();
            documentadorAux=filtralista(documentador); 
            
        } 
        else if(filtroTipo.equals('Trigger')){
            docApexTrigger.sort();
            documentador = docApexTrigger;
            setTotal_size( documentador.size());
            total_size =      getTotal_size();
            Beginning();
            documentadorAux=filtralista(documentador);  
        } 
        else if(filtroTipo.equals('Recurso Estático')){
            docApexStaticResource.sort();
            documentador = docApexStaticResource;
            setTotal_size( documentador.size());
            total_size =      getTotal_size();
            Beginning();
            documentadorAux=filtralista(documentador);  
        }  
        else if(filtroTipo.equals('Visualforce Page')){
            docApexPage.sort(); 
            documentador = docApexPage;
            setTotal_size( documentador.size());
            total_size =      getTotal_size();
            Beginning();
            documentadorAux=filtralista(documentador);  
        }
        else if(filtroTipo.equals('Componente')){
            docApexComponent.sort(); 
            documentador = docApexComponent;
            setTotal_size( documentador.size());
            total_size =      getTotal_size();
            Beginning();
            documentadorAux=filtralista(documentador);  
        }
        else if(filtroTipo.equals('Objeto')){
            
            docApexObject.sort(); 
            documentador = docApexObject;
            setTotal_size( documentador.size());
            total_size =      getTotal_size();
            Beginning();
            documentadorAux=filtralista(documentador);  
        }
        
        else if(filtroTipo.equals('Objeto Personalizado')){
            
            docApexObjectCustom.sort(); 
            documentador = docApexObjectCustom;
            setTotal_size( documentador.size());
            total_size =      getTotal_size();
            Beginning();
            documentadorAux=filtralista(documentador);  
        } else{
            System.debug('lista todos los archivos');
            docAll.sort();
            documentador = docAll;
            setTotal_size( documentador.size());
            total_size =        getTotal_size();
            System.debug('antes de beginning');
            Beginning();
            documentadorAux=filtralista(documentador); 
            
        }                
        return null;
    }
    
    
    
    public PageReference  GeneraPDF(  ){ 
        System.debug('valor de tipo de archivo->'+paramValue);
        
        Pagereference pageRef = new PageReference('/apex/GeneraPDFDocumentador');  
        pageref.getParameters().put('tipoArchivo',paramValue);
        
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    /*public PageReference print() {
renderAs = 'PDF';
return null;
}*/
    
    public PageReference  ActualizaObservaciones(  ){
        try{
            update documentadorAux;
        }    
        catch(Exception e){
            System.debug('Error Excepción ocurrida: '+String.valueOf(e));
        }
        return NULL;
    }
    
    public PageReference Beginning() { //user clicked beginning
        counter = 0;
        documentadorAux = new List<Documentador__c>();
        documentadorAux=filtralista(documentador);
        System.debug('en Beginning');
        System.debug('counter '+ counter);
        return null;
    }
    public PageReference Previous() { //user clicked previous button
        
        
        counter -= PAGE_SIZE; 
        documentadorAux = new List<Documentador__c>();
        documentadorAux=filtralista(documentador); 
        System.debug('en Previous');
        System.debug('counter '+ counter);
        return null;
    }
    
    public PageReference Next() { //user clicked next button
        counter += PAGE_SIZE;
        documentadorAux = new List<Documentador__c>();
        documentadorAux=filtralista(documentador); 
        
        System.debug('en next');
        System.debug('counter '+ counter);
        
        
        return null;
    }
    
    public PageReference End() { //user clicked end
        counter = total_size - math.mod(total_size, PAGE_SIZE);
        documentadorAux = new List<Documentador__c>();
        documentadorAux=filtralista(documentador); 
        System.debug('en End');
        System.debug('counter '+ counter);
        return null;
    }
    
    public Boolean getDisablePrevious() { 
        
        System.debug('en getDisablePrevious');
        
        System.debug('counter '+ counter);
        
        
        //this will disable the previous and beginning buttons
        if (counter>0){ 
            System.debug('regresa false ' );
            return false; 
        }else{
            System.debug('regresa true ' );
            return true;
        }
    }
    
    public Boolean getDisableNext() { //this will disable the next and end buttons
        System.debug('en getDisableNext');
        System.debug('counter '+ counter);
        System.debug('PAGE_SIZE '+ PAGE_SIZE);
        System.debug('total_size '+ total_size);
        
        // if (counter + PAGE_SIZE < total_size) return false; else return true;
        
        if (counter + PAGE_SIZE < total_size){ 
            System.debug('regresa false ' );
            return false; 
        }else{
            System.debug('regresa true ' );
            return true;
        }
        
    }
    
    public Integer getTotal_size() {
        return total_size;
    }
    
    public void setTotal_size(Integer total_size){
        this.total_size = total_size;
    }  
    
    public Integer getPageNumber() {
        return counter/PAGE_SIZE + 1;
    }
    
    public Integer getTotalPages() {
        if (math.mod(total_size, PAGE_SIZE) > 0) {
            return total_size/PAGE_SIZE + 1;
        } else {
            return (total_size/PAGE_SIZE);
        }
    }
    
    //*
    //Crea un objeto lista tipo SelectOption para formar un campo select dentro del Visualforce Page
    //@return List<SelectOption> options
    //*
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        //      options.add(new SelectOption(' ','Seleccion...'));
        options.add(new SelectOption(' ','Todos...'));
        options.add(new SelectOption('Clase Apex','Clase Apex'));
        options.add(new SelectOption('Visualforce Page','Visualforce Page'));
        options.add(new SelectOption('Trigger','Trigger'));
        options.add(new SelectOption('Recurso Estático','Recurso Estático'));
        options.add(new SelectOption('Componente','Componente'));
        options.add(new SelectOption('Objeto','Objeto'));
        options.add(new SelectOption('Objeto Personalizado','Objeto Personalizado'));
        // options.add(new SelectOption('Configuración Personalizada','Configuración Personalizada'));
        return options;
    }
    
    
    
}