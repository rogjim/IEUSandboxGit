public with sharing class TriggerBecaHandler extends TriggerHandler{
    private Map<Id, Beca__c> newMap;
    private Map<Id, Beca__c> oldMap;
    private List<Beca__c> newList;
    private List<Beca__c> oldList;
    
    
    public TriggerBecaHandler() {
        this.newMap = (Map<Id, Beca__c>) trigger.newMap;
        this.oldMap = (Map<Id, Beca__c>) trigger.oldMap;
        this.newList = (List<Beca__c>) trigger.new;
        this.oldList = (List<Beca__c>) trigger.old;
    }
    
    public override void afterUpdate(){
    	//sendToERP(this.newList,this.oldMap);
    }
    
    public override void beforeUpdate(){
    	
    }
    
    public override void beforeInsert(){
    	setConsecutivoIds(this.newList);
    }
    
     /**
    * @author:      Rogelio Jiménez
    * @date:        27/06/2016
    * @description: Verifica el cambio en los campos para poder ser envaidos en Batch del ERP Master
    * @param:       List<Lead> newLeads
    * @return:     
    */
    
    public void sendToERP(list<Beca__c> newBecas,map<Id,Beca__c> oldMap){
    	set<Id> ids = new set<Id>();
    	if(Utils.MAP_OBJECT_FIELDS.containsKey('Beca__c')){
    		for(String field : Utils.MAP_OBJECT_FIELDS.get('Beca__c')){
    			for(Beca__c beca: newBecas){
    				if(beca.get(field) != oldMap.get(beca.Id).get(field)){
	    				ids.add(beca.Id);
	    			}
    			}
    		}
    	}
    	
    	try{
    		list<Lead> leads = [SELECT id,ModificadoERP__c FROM Lead WHERE Beca__c IN : ids];
    		for(Lead lead:leads){
    			lead.ModificadoERP__c = true;
    		}
    		update leads;
    	}catch(Exception e){
    		System.debug('Error al actulizar candidatos para envío a ERP');
    	}
    	
    	try{
    		list<Opportunity> opportunities = [SELECT id,ModificadoERP__c FROM Opportunity WHERE Beca__c IN : ids];
    		for(Opportunity opp:opportunities){
    			opp.ModificadoERP__c = true;
    		}
    		update opportunities;
    	}catch(Exception e){
    		System.debug('Error al actulizar oportunidades para envío a ERP');
    	}
    }
    
    public void setConsecutivoIds(list<Beca__c> newBecas){
    	Integer maxIdInternoConvenio = 0;
    	Integer maxIdInternoComercial  = 0;
    	try{
    		list<AggregateResult> ar = [SELECT MAX(IdInternoConvenio__c) idInternoConvenio FROM Beca__c WHERE TipoBeca__c = 'Convenio'];
			maxIdInternoConvenio =  Integer.valueOf(ar[0].get('idInternoConvenio'));
    	}catch(Exception e){
    		System.debug('Error recuperando maxIdInternoConvenio:' + e.getMessage());
    	}
    	
    	try{
    		list<AggregateResult> ar = [SELECT MAX(IdInterno__c) idInterno FROM Beca__c WHERE TipoBeca__c = 'Comercial'];
			maxIdInternoComercial =  Integer.valueOf(ar[0].get('idInterno'));
    	}catch(Exception e){
    		System.debug('Error recuperando maxIdInternoComercial:' + e.getMessage());
    	}
    	for(Beca__c beca:newBecas){
    		if(beca.TipoBeca__c == 'Convenio'){
    			maxIdInternoConvenio = maxIdInternoConvenio != null ? maxIdInternoConvenio + 1 : 0;
    			beca.IdInternoConvenio__c = maxIdInternoConvenio;
    		}
    		if(beca.TipoBeca__c == 'Comercial'){
    			maxIdInternoComercial = maxIdInternoComercial != null ? maxIdInternoComercial + 1 : 0;
    			beca.IdInterno__c = maxIdInternoComercial;
    		}
    	}
    }
}