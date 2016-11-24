public with sharing class OFE_CandidatoMotor {
    
    public OFE_CandidatoMotor(){
    
    }
    /**
    * @author:      Rogelio Jiménez
    * @date:        10/05/2016
    * @description: Obtiene los promotores por plantel
    * @param:       Lead
    * @return:      map<Id,list<Promotor__c>>
    */
    public Promotor__c lookupForPromotor(Lead lead){
        Promotor__c promotorAssigned = null;
        
        if(Utils.MAP_PROMOTORES_BY_PLANTEL.containsKey(lead.Plantel__c)){
            //System.debug('Utils.MAP_PROMOTORES_BY_PLANTEL.get(lead.Plantel__c).size() '+Utils.MAP_PROMOTORES_BY_PLANTEL.get(lead.Plantel__c).size());
           // System.debug('Utils.MAP_PROMOTORES_NO_DISPONIBLE_BY_PLANTEL.get(lead.Plantel__c).size() '+Utils.MAP_PROMOTORES_NO_DISPONIBLE_BY_PLANTEL.get(lead.Plantel__c).size());
        	if(Utils.MAP_PROMOTORES_NO_DISPONIBLE_BY_PLANTEL.containsKey(lead.Plantel__c)){
	        	if (Utils.MAP_PROMOTORES_BY_PLANTEL.get(lead.Plantel__c).size() == Utils.MAP_PROMOTORES_NO_DISPONIBLE_BY_PLANTEL.get(lead.Plantel__c).size()){
	        		try{
		        		list<Promotor__c> promotores = [SELECT id,Asignado__c FROM PRomotor__c WHERE ASignado__c =: true AND Plantel__c =: lead.Plantel__c ];
		        		for(Promotor__c promotor : promotores){
		        			promotor.Asignado__c = false;
		        		}
		        		update promotores;
	        		}catch(Exception e){
	        		
	        		}
	        	}
        	}
            list<Promotor__c> promotores = Utils.MAP_PROMOTORES_DISPONIBLE_BY_PLANTEL.get(lead.Plantel__c);
           	promotorAssigned = getNextPromotor(promotores);
        }else{
        	String idUniversidadVirtual = Utils.getCatalogoId('Plantel', 'UNIVERSIDAD VIRTUAL');
        	if(idUniversidadVirtual != null){
        		if (Utils.MAP_PROMOTORES_BY_PLANTEL.get(idUniversidadVirtual).size() == Utils.MAP_PROMOTORES_NO_DISPONIBLE_BY_PLANTEL.get(idUniversidadVirtual).size()){
        			try{
	        			list<Promotor__c> promotores = [SELECT id,Asignado__c FROM PRomotor__c WHERE ASignado__c =: true AND Plantel__c =: idUniversidadVirtual ];
		        		for(Promotor__c promotor : promotores){
		        			promotor.Asignado__c = false;
		        		}
		        		update promotores;
	        		}catch(Exception e){
        		
        			}
	        	}
	        	list<Promotor__c> promotores = Utils.MAP_PROMOTORES_DISPONIBLE_BY_PLANTEL.get(idUniversidadVirtual);
	           	promotorAssigned = getNextPromotor(promotores);
        	}
        }
        return promotorAssigned;
    }
    
    /**
    * @author:      Rogelio Jiménez
    * @date:        10/05/2016
    * @description: Obtiene y actualiza los promotores de acuerdo al número asignados
    * @param:       list<Promotor__c>
    * @return:     Promotor__c
    */
    public Promotor__c getNextPromotor(list<Promotor__c> promotores){
        Promotor__c promotorChoosen = null;
        boolean hasMaximo = true;
        
        if(promotores != null){
        	promotorChoosen = promotores.get(0);
        	promotorChoosen.Asignado__c = true;
        }
        //Utils.MAP_PROMOTORES_BY_PLANTEL = null;
        return promotorChoosen;
    }
}