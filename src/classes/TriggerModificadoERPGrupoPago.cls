public with sharing class TriggerModificadoERPGrupoPago  extends TriggerHandler{
    
    private Map<Id, OfertaConceptoPagos__c> newMap;
    private Map<Id, OfertaConceptoPagos__c> oldMap;
    private List<OfertaConceptoPagos__c> newList;
    private List<OfertaConceptoPagos__c> oldList;
    
    public override void afterUpdate(){
        
        this.newMap = (Map<Id, OfertaConceptoPagos__c>) trigger.newMap;
        this.oldMap = (Map<Id, OfertaConceptoPagos__c>) trigger.oldMap;
        this.newList = (List<OfertaConceptoPagos__c>) trigger.new;
        this.oldList = (List<OfertaConceptoPagos__c>) trigger.old;
        Boolean actualiza = false;
        
        List<Grupo__c> listaGrupo  = new  List<Grupo__c>();
        set<String> idOfertasEducativas = new set<String>();
        for(OfertaConceptoPagos__c ofenew: newList){
            
            Boolean difMonto =  ofenew.Monto__c != ((OfertaConceptoPagos__c)oldMap.get(ofenew.id)).Monto__c ; 
            Boolean difConcepto =  ofenew.ConceptoPago__c != ((OfertaConceptoPagos__c)oldMap.get(ofenew.id)).ConceptoPago__c ; 
            
            if(difMonto || difConcepto){ 
                actualiza = true;
                idOfertasEducativas.add(ofenew.OfertaEducativa__c);
            }
            
            
        } 
        for(Grupo__c grupo  : [Select id,ModificadoERPGrupoPago__c  From Grupo__c where OfertaEducativa__c IN : idOfertasEducativas]){
                grupo.ModificadoERPGrupoPago__c= true;
                listaGrupo.add(grupo);
            }
        update listaGrupo; 
    }
}