global class UtilsExternal {
    /**
* @author:      Salvador Reyna
* @date:        28/06/2016
* @description: 
* @param:       
* @return:      
*/
    public Id idLead {get;set;}
    public String email {get;set;}
    
    @RemoteAction
    global static ComboWrapper getExternalOfertaAcademica(){
        List<OfertaEducativa__c> listOffer = [SELECT Id, Modalidad__c, Modalidad__r.Name,
                                              Nivel__c, Nivel__r.Name,
                                              Plantel__c, Plantel__r.Name,
                                              Programa__c, Programa__r.Name,
                                              Periodo__r.ActivoEjecutiva__c, 
                                              Periodo__r.ActivoOnline__c, 
                                              Periodo__r.ActivoPresencial__c
                                              FROM OfertaEducativa__c WHERE 
                                              Periodo__r.Activo__c = 'Activo' 
                                              AND (Nivel__r.Name = 'Licenciatura' 
                                                   OR Nivel__r.Name = 'Maestría' 
                                                   OR Nivel__r.Name = 'Doctorado')
                                              AND (Periodo__r.ActivoEjecutiva__c = true OR 
                                                   Periodo__r.ActivoOnline__c = true OR 
                                                   Periodo__r.ActivoPresencial__c = true)
                                              AND estatus__c = 'Activo'];
        
        ItemWrapper itemModalidad = new ItemWrapper('Modalidad');
        ItemWrapper itemNivel = new ItemWrapper('Nivel');
        ItemWrapper itemPlantel = new ItemWrapper('Plantel');
        ItemWrapper itemPrograma = new ItemWrapper('Programa');
        
        String modalidadBussy = '';
        String nivelBussy = '';
        String plantelBussy = '';
        String programaBussy = '';
        for(OfertaEducativa__c offer: listOffer){
            InfoWrapper infoModalidad = new infoWrapper();
            InfoWrapper infoNivel = new infoWrapper();
            InfoWrapper infoPlantel = new infoWrapper();
            InfoWrapper infoPrograma = new infoWrapper();
            
            if(((offer.Modalidad__r.Name).equals('Online') && offer.Periodo__r.ActivoOnline__c == true) ||
               ((offer.Modalidad__r.Name).equals('Ejecutiva') && offer.Periodo__r.ActivoEjecutiva__c == true) ||
               ((offer.Modalidad__r.Name).equals('Presencial') && offer.Periodo__r.ActivoPresencial__c == true)){
                   //Informacion de la modalidad
                   infoModalidad.dataId = offer.Modalidad__c;
                   infoModalidad.name = offer.Modalidad__r.Name;
                   //Información del nivel
                   infoNivel.dataId = String.valueOf(offer.Nivel__c) + '-' +String.valueOf(offer.Modalidad__c);
                   infoNivel.name = offer.Nivel__r.Name;
                   infoNivel.parent = offer.Modalidad__c;
                   //Información del Plantel
                   infoPlantel.dataId = String.valueOf(offer.Plantel__c) + '-' + String.valueOf(offer.Nivel__c) + '-' + String.valueOf(offer.Modalidad__c);
                   infoPlantel.name = offer.Plantel__r.Name;
                   infoPlantel.parent = String.valueOf(offer.Nivel__c) + '-' + String.valueOf(offer.Modalidad__c);
                   //Información del Programa
                   infoPrograma.dataId =  String.valueOf(offer.Id) + '-' +String.valueOf(offer.Programa__c) + '-' + String.valueOf(offer.Plantel__c) + '-' + String.valueOf(offer.Nivel__c) + '-' + String.valueOf(offer.Modalidad__c);
                   infoPrograma.name = offer.Programa__r.Name;
                   infoPrograma.parent = String.valueOf(offer.Plantel__c) + '-' + String.valueOf(offer.Nivel__c) + '-' + String.valueOf(offer.Modalidad__c);
                   
                   if(!modalidadBussy.contains(offer.Modalidad__c)){
                       itemModalidad.items.add(infoModalidad);
                       modalidadBussy += '-' + offer.Modalidad__c;
                   }
                   
                   String toNivel = String.valueOf(offer.Nivel__c) + String.valueOf(offer.Modalidad__c);
                   if(!nivelBussy.contains(toNivel)){
                       itemNivel.items.add(infoNivel);
                       nivelBussy += '-' + offer.Nivel__c + offer.Modalidad__c;
                   }
                   
                   String toPlantel = String.valueOf(offer.Plantel__c) + String.valueOf(offer.Nivel__c) + String.valueOf(offer.Modalidad__c);
                   if(!plantelBussy.contains(toPlantel)){
                       itemPlantel.items.add(infoPlantel);
                       plantelBussy += '-' + offer.Plantel__c + offer.Nivel__c + offer.Modalidad__c;
                   }
                   
                   String toPrograma = String.valueOf(offer.Programa__c) + String.valueOf(offer.Plantel__c) + String.valueOf(offer.Nivel__c) + String.valueOf(offer.Modalidad__c);
                   if(!programaBussy.contains(toPrograma)){
                       itemPrograma.items.add(infoPrograma);
                       programaBussy += '-' + offer.Programa__c + offer.Plantel__c + offer.Nivel__c + offer.Modalidad__c;
                   }
               }
        }
        ComboWrapper cw = new ComboWrapper();
        cw.modalidad = itemModalidad;
        cw.nivel = itemNivel;
        cw.plantel = itemPlantel;
        cw.programa = itemPrograma;
        return cw;
    }
    
    /**
* @author:      Gabriel Garcia
* @date:        04/07/2016
* @description: Método para obtener los cátalogos de ubicación
* @param:       
* @return:      
*/
    @RemoteAction
    global static Map<String, List<SObject>> getExternalUbicacion(){
        Map<String, List<SObject>> ubicacion = new Map<String, List<SObject>>();
        ubicacion.put('pais', Database.query('SELECT Id, IdUbicacion__c, Name, IdEstadoPais__c FROM Ubicacion__c WHERE TipoUbicacion__c= \'País\' ORDER BY Name'));
        ubicacion.put('estado', Database.query('SELECT IdUbicacion__c, Name, IdEstadoPais__c FROM Ubicacion__c WHERE TipoUbicacion__c= \'Estado\' ORDER BY Name'));
        ubicacion.put('municipio', Database.query('SELECT IdUbicacion__c, Name, IdEstadoPais__c FROM Ubicacion__c WHERE TipoUbicacion__c= \'Municipio\' ORDER BY Name'));
        
        return ubicacion;
    }
    
    @RemoteAction
    //  @future(callout=true)
    global static void sendEmailCalculadora(String idLead, String email, String promedio, String descuentoInsc, String descuentoMens, String vigencia){
        Id leadId = Id.valueOf(idLead); 
        PlantillaCalculoRegistradoController.sendMail(idLead, email, promedio, descuentoInsc, descuentoMens, vigencia);   
    }
    
    @RemoteAction
    global static Map<String, String> getMontos(String ofe){
        Map<String, String> montos = new Map<String , String>();
        List<OfertaConceptoPagos__c> listMontos = new List<OfertaConceptoPagos__c>();
        listMontos = [SELECT Id, Monto__c, ConceptoPago__r.Name, OfertaEducativa__c FROM OfertaConceptoPagos__c  WHERE OfertaEducativa__c =: ofe];
        for(OfertaConceptoPagos__c mont: listMontos){
            montos.put(mont.ConceptoPago__r.Name, String.valueOf(mont.Monto__c));
        }
        return montos;
    }
    
    @RemoteAction
    global static String getFolioCRM(){
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
        nextFolio = nextFolio + 1;
        configuracionNegocio.Folio__c = nextFolio;
        update configuracionNegocio;
        return String.valueOf(nextFolio);
    }
    
    @RemoteAction
    global static void updateNegocio(String folio){
        Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
        configuracionNegocio.Folio__c = Decimal.valueOf(folio);
        update configuracionNegocio;
    }
    
    global class InfoWrapper{
        public String dataId {get;set;}
        public String parent {get;set;}
        public String name {get;set;}
        
        public InfoWrapper(){}
    }
    
    global class ItemWrapper{
        public List<InfoWrapper> items {get;set;}
        public String titulo {get; set;}
        public ItemWrapper(String titulo){
            items = new List<InfoWrapper>();
            this.titulo = titulo;
        }
        
    }
    
    global class ComboWrapper{
        public ItemWrapper modalidad {get;set;}
        public ItemWrapper nivel {get;set;}
        public ItemWrapper plantel {get;set;}
        public ItemWrapper programa {get;set;}
        
        public ComboWrapper(){
            modalidad = new ItemWrapper('Modalidad');
            nivel = new ItemWrapper('Nivel');
            plantel = new ItemWrapper('Plantel');
            programa = new ItemWrapper('Programa');
        }
    }   
    
    @RemoteAction 
    public static Lead sendMailLead(String IdLead){ 
        Lead lead ;   
        try{ 
            lead = [Select Modalidad__r.Name, Nivel__r.Name, Plantel__r.Name, Programa__r.Name, Promedio__c, PorcentajeBeca__c, 
                    FolioCalculadora__c, Inscripcion__c, InscripcionDescuento__c, PorcentajeDescuento__c, Colegiatura__c, 
                    ColegiaturaDescuento__c, Numero_Mensualidades__c, VigenciaDescuento__c, OfertaEducativa__c  ,Email
                    FROM Lead WHERE Id = : IdLead ]; 
            String vigencia =  lead.VigenciaDescuento__c.year()+'-'+lead.VigenciaDescuento__c.month()+'-'+lead.VigenciaDescuento__c.day()  ;
            sendEmailCalculadora(lead.Id, lead.Email, lead.Promedio__c, String.valueOf(lead.PorcentajeDescuento__c), String.valueOf(lead.PorcentajeBeca__c),  vigencia);
            // sendEmailCalculadora(String idLead, String email, String promedio, String descuentoInsc, String descuentoMens, String vigencia){
        }catch (Exception e){
            
            System.debug('Exception --> '+ e); 
        } 
        return   lead;
    }
}