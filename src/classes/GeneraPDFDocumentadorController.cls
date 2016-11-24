public class GeneraPDFDocumentadorController {
    public String tipoArchivo {get; set;}
    public List<Documentador__c> documentadorAux  {get;set;}
    
    public GeneraPDFDocumentadorController(){
        tipoArchivo = apexpages.currentpage().getparameters().get('tipoArchivo');
    }
    
    public PageReference ListaDocumentador(){
       // System.debug('valor de filtro--->'+ tipoArchivo+'*');
        
        if(tipoArchivo !=null && tipoArchivo !=' '&& tipoArchivo !=''  ){
            
           //  System.debug('entra a tipo de archivp->' );
            documentadorAux=   [SELECT Id
                                ,Name
                                ,Tipo__c
                                ,FechaInicio__c
                                ,FechaModif__c
                                ,IdComponente__c
                                ,Observacion__c 
                                FROM Documentador__c 
                                WHERE Documentador__c.Tipo__c =: tipoArchivo
                                ORDER BY Name ASC  ]; 
        }else{
            
              //System.debug('entra a no trae tipo tipo de archivp->' );
            documentadorAux=   [SELECT Id
                                ,Name
                                ,Tipo__c
                                ,FechaInicio__c
                                ,FechaModif__c
                                ,IdComponente__c
                                ,Observacion__c 
                                FROM Documentador__c 
                                ORDER BY Tipo__c,Name ASC ]; 
        }
        return null;
    }
}