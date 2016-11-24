public class PlantillaPromotorAsignadoController {
    
    public ID  salesRepID {get; set;}
    public String urlPlan {get; set;}
    public List<Plantel__c> plantel = new List<Plantel__c>();
    public List<RequisitosInscripcion__c> requisitos = new List<RequisitosInscripcion__c>();
    public  Lead AllLeads= new Lead();
    public  Plantel__c Direccion= new Plantel__c();
    //public  Rvoe__c rvoe;
    //Integer cantidadPlanteles {get; set;}
    String dir='';
    String Nivel='';
    String RvoeVigente='';
    public String urlSite {get; set;}
    public PlantillaPromotorAsignadoController() {
        
    }    
    
    public Lead  getAllLeads() {              
        
        try {
            AllLeads = [select Id, Promotor__c, Promotor__r.PromotorName__c ,Folio__c,Name, Programa__r.Name ,
                        Inscripcion__c, Nivel__r.Name,VigenciaDescuento__c,Programa__r.AbreviaturaPrograma__c,
                        Programa__r.NombreMin__c,Colegiatura__c, Nivel__c, Modalidad__c , Promotor__r.UrlFotoGrande__c, 
                        OfertaEducativa__r.RvoeVigente__r.ModalidadRVOE__c , OfertaEducativa__r.RvoeVigente__r.Name, 
                        OfertaEducativa__r.RvoeVigente__r.ClaveCentroTrabajo__c, Modalidad__r.Name ,
                        OfertaEducativa__r.DuracionPrograma__c , Plantel__c ,  Periodo__r.name , Periodo__r.FechaInicio__c ,
                        Programa__r.LigaPlan__c, OfertaEducativa__r.Periodicidad__c ,
                        Plantel__r.Name, GrupoAsignado__r.FechaInicioClases__c
                        from Lead where Id=: salesRepID  LIMIT 1];                           
           // System.debug(' URLPlanEstudios --> '+AllLeads.Programa__r.LigaPlan__c);
           // dir=AllLeads.Plantel__c; 
           // Nivel=AllLeads.Nivel__r.Name; 
           // RvoeVigente=AllLeads.OfertaEducativa__r.RvoeVigente__c;           
        	urlPlan = AllLeads.Programa__r.LigaPlan__c;
           
            if (ValidaEntorno.isSandbox()) { 
            	urlSite = 'https://sandbox-ieu.cs2.force.com';
            } else { 
            	urlSite = 'http://ieu.force.com';
            }
            
            
        } catch (Exception e) {
            // return AllLeads;
        }
        return AllLeads;
    }

}