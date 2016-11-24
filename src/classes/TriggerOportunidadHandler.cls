public with sharing class TriggerOportunidadHandler extends TriggerHandler{
    private Map<Id, Opportunity> newMap;
	private Map<Id, Opportunity> oldMap;
	private List<Opportunity> newList;
	private List<Opportunity> oldList;
	
	public TriggerOportunidadHandler() {
			//this.setMaxLoopCount(1);
			this.newMap = (Map<Id, Opportunity>) trigger.newMap;
			this.oldMap = (Map<Id, Opportunity>) trigger.oldMap;
			this.newList = (List<Opportunity>) trigger.new;
			this.oldList = (List<Opportunity>) trigger.old;
			
	}
	
	
    public override void beforeInsert(){
		assignFolio(newList);
	}
	
	public override void afterUpdate() {
		//assignVerifiedOpportinities(this.newList);
		assignWonOpportinities(this.newList);

		updateCounters(this.newList, this.oldMap);//Actualizar contadores - calvarez 16 nov 2016
	}
    
    public override void afterInsert() {
        updateCounters(this.newList, this.oldMap);//Actualizar contadores - calvarez 16 nov 2016
    }
    
    public override void beforeUpdate(){
    	changeProbabilityStage(this.newList);
        setWordValue(this.newList, this.oldMap);
        sendToERP(newList,this.oldMap);
        sendToERPBeca(newList,this.oldMap);
        //RJP--->Nuevos
        //verivyChangeGroup(this.newList); //calvarez - 16 nov 2016
        //unassignInscritos(this.newList);
    }
	/**
    * @author:      Rogelio Jimenez
    * @date:        09/06/2016
    * @description: Asigna folio si la oportunidad no viene de un lead
    * @param:       list<Opportunity>
    * @return:      
    */
    
    public void assignFolio(List<Opportunity> opportunities){
    	list<Opportunity> oppNeedFolio = new list<Opportunity>();
    	for(Opportunity opp : opportunities){
    		if(!opp.EsConvertido__c && (opp.Folio__c == null || opp.Folio__c == '')){
    			oppNeedFolio.add(opp);
    		}
    	}
       if(oppNeedFolio.size() > 0){
       	Utils.obtenerFolio('OPPORTUNITY',oppNeedFolio);
       }
    }
    
    /**
    * @author:      Rogelio Jimenez
    * @date:        17/06/2016
    * @description: Aumenta el valor de Incritos en el grupo cuando una oportuinda es Inscrito o Ganada
    * @param:       list<Opportunity>
    * @return:      
    */   
    public void assignWonOpportinities(List<Opportunity> opportunities){
    	list<Opportunity> opportunitesWon = new list<Opportunity>();
    	set<Id> idGrupos = new set<Id>();
    	map<Id,Grupo__c> mapGrupo = new map<Id,Grupo__c>();
    	
    	/*for(Opportunity oportunidad : opportunities){
    		if(oldMap.get(oportunidad.Id).StageName != oportunidad.StageName && oportunidad.StageName == 'Inscrito'){
    			opportunitesWon.add(oportunidad);
    			System.debug('oportunidad Inscrito: ' + oportunidad);
    			if(oportunidad.Grupo__c != null){
    				idGrupos.add(oportunidad.Grupo__c);
    			}
    		}
    	}
    	
    	for(Opportunity oportunidad : opportunities){
    		if(oldMap.get(oportunidad.Id).StageName != oportunidad.StageName && oportunidad.StageName == 'Ganada' && oldMap.get(oportunidad.Id).StageName != 'Inscrito'){
    			opportunitesWon.add(oportunidad);
    			if(oportunidad.Grupo__c != null){
    				idGrupos.add(oportunidad.Grupo__c);
    			}
    		}
    	}*/
    	
    	for(Opportunity oportunidad : opportunities){
    		if(this.oldMap.get(oportunidad.Id).StageName != oportunidad.StageName && oportunidad.StageName == 'Inscrito' ||  oportunidad.StageName  == 'Ganada'){
    			idGrupos.add(oportunidad.Grupo__c);
    		}
    	}
    	
    	list<Grupo__c> grupos = [SELECT Id,Inscritos__c,Validados__c FROM Grupo__c WHERE Id IN : idGrupos];
    	for (Grupo__c grupo : grupos){
		    grupo.Inscritos__c = getInscritosPerGrupo(grupo);
		}
		
		update grupos;
    	
    }
    
    private Integer getInscritosPerGrupo(Grupo__c grupo){
		Integer inscritos = 0;
		AggregateResult [] results = [SELECT count(Id) inscritos FROM Opportunity WHERE (StageName = 'Inscrito' OR  StageName  = 'Ganada') AND Grupo__c =: grupo.Id  GROUP BY Grupo__c ];
		if(results != null && results.size() > 0){
			inscritos = Integer.valueOf(results[0].get('inscritos'));
		}
		return inscritos;
	
	}
    
    /**
    * @author:      Rogelio Jimenez
    * @date:        17/06/2016
    * @description: Aumenta el valor de Verificados en el grupo cuando una oportuinda es verificada
    * @param:       list<Opportunity>
    * @return:      
    */
     public void assignVerifiedOpportinities(List<Opportunity> opportunities){
    	list<Opportunity> opportunitesVerify = new list<Opportunity>();
    	set<Id> idGrupos = new set<Id>();
    	map<Id,Grupo__c> mapGrupo = new map<Id,Grupo__c>();
    	
    	for(Opportunity oportunidad : opportunities){
    		if(oldMap.get(oportunidad.Id).Validado__c != oportunidad.Validado__c && oportunidad.Validado__c ){
    			opportunitesVerify.add(oportunidad);
    			if(oportunidad.Grupo__c != null){
    				idGrupos.add(oportunidad.Grupo__c);
    			}
    		}
    	}
    	
    	list<Grupo__c> grupos = [SELECT Id,Inscritos__c,Validados__c FROM Grupo__c WHERE Id IN : idGrupos];
    	
    	for (Grupo__c grupo : grupos){
		    grupo.Validados__c = getValidadosPerGrupo(grupo);
		}
		
		update grupos;
    }
    
    private Integer getValidadosPerGrupo(Grupo__c grupo){
		Integer validados = 0;
		AggregateResult [] results = [SELECT count(Id) validados FROM Opportunity WHERE Validado__c = true AND Grupo__c =: grupo.Id  GROUP BY Grupo__c ];
		if(results != null && results.size() > 0){
			validados = Integer.valueOf(results[0].get('validados'));
		}
		return validados;
	
	}
     
    
    /**
    * @author:      Rogelio Jiménez
    * @date:        27/06/2016
    * @description: Verifica el cambio en los campos para poder ser envaidos en Batch del ERP Master
    * @param:       List<Lead> newLeads
    * @return:     
    */
    
    public void sendToERP(list<Opportunity> newLeads,map<Id,Opportunity> oldMap){
    	if(Utils.MAP_OBJECT_FIELDS.containsKey('Opportunity')){
    		for(String field : Utils.MAP_OBJECT_FIELDS.get('Opportunity')){
    			for(Opportunity opp: newLeads){
	    			if(opp.get(field) != oldMap.get(opp.Id).get(field) &&!opp.ModificadoERP__c){
	    				opp.ModificadoERP__c = true;
	    				break;
	    			}
    			}
    		}
    	}
    }
    
    /**
    * @author:      Rogelio Jiménez
    * @date:        
    * @description: Verifica el cambio en los campos exclusivos para beca
    * @param:       List<Opportunity> newLeads
    * @return:     
    */
    
    public void sendToERPBeca(list<Opportunity> newLeads,map<Id,Opportunity> oldMap){
    	if(Utils.MAP_OBJECT_FIELDS.containsKey('Opportunity')){
    			for(Opportunity opp: newLeads){
    				if(opp.get('TipoBeca__c') != oldMap.get(opp.Id).get('TipoBeca__c') &&!opp.ModificadoBecaERP__c){
	    				opp.ModificadoBecaERP__c = true;
    				}else if(opp.get('PorcentajeBeca__c') != oldMap.get(opp.Id).get('PorcentajeBeca__c') &&!opp.ModificadoBecaERP__c){
	    				opp.ModificadoBecaERP__c = true;
    				}
    			}
    		}
    }
    
    /**
    * @author:      Rogelio Jiménez
    * @date:        26/09/2016
    * @description: Actuliza el número de incritos cuando se cambia de grupo
    * @param:       List<Lead> newLeads
    * @return:     
    */
    public void verivyChangeGroup(list<Opportunity> newOpportunities){
    	list<Grupo__c> gruposOld = new list<Grupo__c>();
    	list<Grupo__c> gruposNew = new list<Grupo__c>();
    	integer numeroOportunidades = 0;
    	map<Id,Decimal> mapOldGrupo = new map<Id,Decimal>(); 
    	map<Id,Decimal> mapNewGrupo = new map<Id,Decimal>();
    	
    	map<Id,Decimal> mapValidados = new map<Id,Decimal>(); 
    	Decimal numeroValidados = 0;
    	 
    	for(Opportunity oportunidad:newOpportunities){
    		if(oportunidad.Grupo__c != oldMap.get(oportunidad.Id).Grupo__c  && (oportunidad.StageName == 'Inscrito' || oportunidad.StageName == 'Ganada' )){
    			//Nuevos Grupo
    			if(!mapNewGrupo.containsKey(oportunidad.Grupo__c)){
    				mapNewGrupo.put(oportunidad.Grupo__c,0);
    			}
    			Decimal auxNuevo = mapNewGrupo.get(oportunidad.Grupo__c) != null ? mapNewGrupo.get(oportunidad.Grupo__c) : 0 ;
    			auxNuevo++;
    			mapNewGrupo.put(oportunidad.Grupo__c,auxNuevo);
    			//Anteriores Grupo
    			if(!mapOldGrupo.containsKey(oldMap.get(oportunidad.Id).Grupo__c)){
    				mapOldGrupo.put(oldMap.get(oportunidad.Id).Grupo__c,0);
    			}
    			Decimal auxOld = mapOldGrupo.get(oportunidad.Grupo__c) != null ? mapOldGrupo.get(oportunidad.Grupo__c) : 0 ;
    			auxOld++;
    			mapOldGrupo.put(oldMap.get(oportunidad.Id).Grupo__c,auxOld);
    			
    			//Para los validados
    			if(oldMap.get(oportunidad.Id).Validado__c){
    				if(!mapValidados.containsKey(oldMap.get(oportunidad.Id).Grupo__c)){
	    				mapValidados.put(oldMap.get(oportunidad.Id).Grupo__c,0);
	    			}
    				numeroValidados++;
    				mapValidados.put(oldMap.get(oportunidad.Id).Grupo__c,numeroValidados);
    			}
    		}
    	}
    	
    	for(Grupo__c newGrupo : [SELECT id,Inscritos__c,Validados__c FROM Grupo__c WHERE Id IN : mapNewGrupo.keySet()]){
    		newGrupo.Inscritos__c = newGrupo.Inscritos__c + mapNewGrupo.get(newGrupo.Id);
    		if(mapValidados.containsKey(newGrupo.Id)){
    			newGrupo.Validados__c = newGrupo.Validados__c + mapValidados.get(newGrupo.Id);
    		}
    		gruposNew.add(newGrupo);
    	}
    	
    	for(Grupo__c oldGrupo : [SELECT id,Inscritos__c,Validados__c FROM Grupo__c WHERE Id IN : mapOldGrupo.keySet()]){
    		oldGrupo.Inscritos__c = oldGrupo.Inscritos__c - mapOldGrupo.get(oldGrupo.Id);
    		if(mapValidados.containsKey(oldGrupo.Id)){
    			oldGrupo.Validados__c = oldGrupo.Validados__c - mapValidados.get(oldGrupo.Id);
    		}
    		gruposOld.add(oldGrupo);
    	}
    	
    	
    	if(gruposOld.size() > 0){
    		update gruposOld;
    	}
    	
    	if(gruposNew.size() > 0){
    		update gruposNew;
    	}
    }
    
    /**
    * @author:      Rogelio Jiménez
    * @date:        26/09/2016
    * @description: Actuliza el número de incritos cuando se cambia de etapa
    * @param:       List<Lead> newLeads
    * @return:     
    */
    public void unassignInscritos(list<Opportunity> oportunities){
    	set<Id> idGrupos = new set<Id>();
    	map<Id,Grupo__c> mapGrupo = new map<Id,Grupo__c>();
    	list<Opportunity> opportunitesUnassign = new list<Opportunity>();
    	for(Opportunity oportunidad: oportunities){
    		if(oportunidad.StageName != oldMap.get(oportunidad.Id).StageName 
    			&& (oldMap.get(oportunidad.Id).StageName == 'Inscrito' || oldMap.get(oportunidad.Id).StageName == 'Ganada') && oportunidad.StageName != 'Perdida'){
    				if(oportunidad.Grupo__c != null){
    					opportunitesUnassign.add(oportunidad);
    					idGrupos.add(oportunidad.Grupo__c);
    				}
    		}
    	}
    	
    	mapGrupo = new Map<ID,Grupo__c>([SELECT Id,Inscritos__c,Validados__c FROM Grupo__c WHERE Id IN : idGrupos]);
    	
    	for(Opportunity oportunidad : opportunitesUnassign){
    		if(mapGrupo.containsKey(oportunidad.Grupo__c)){
    			Decimal inscritosAux = mapGrupo.get(oportunidad.Grupo__c).Inscritos__c != null ? mapGrupo.get(oportunidad.Grupo__c).Inscritos__c : 0;
    			if(inscritosAux > 0){
	    			inscritosAux = inscritosAux - 1;
	    			mapGrupo.get(oportunidad.Grupo__c).Inscritos__c = inscritosAux;
    			}
    		}
    	}
    	
    	if(mapGrupo.values().size() >0){
    		update mapGrupo.values();
    	}
    }
    
    
    public void changeProbabilityStage(list<Opportunity> oportunities){
    	for(Opportunity opp:oportunities){
    		if(opp.StageName != oldMap.get(opp.Id).StageName){
    			if(MAP_OPP_STAGE.containsKey(opp.StageName)){
    				opp.Probability = MAP_OPP_STAGE.get(opp.StageName).DefaultProbability;
    			}
    		}
    	}
    	
    }
    
     public  map<String,OpportunityStage> MAP_OPP_STAGE{ 
    	get{
            if(MAP_OPP_STAGE == null){
                     MAP_OPP_STAGE = new map<String,OpportunityStage>();
                     for(OpportunityStage oppStage : [SELECT Id,DefaultProbability,MasterLabel FROM OpportunityStage WHERE isActive =: true]){
                     	if(!MAP_OPP_STAGE.containsKey(oppStage.MasterLabel)){
                     		MAP_OPP_STAGE.put(oppStage.MasterLabel,oppStage);
                     	}
                     }
                     
                }
              return MAP_OPP_STAGE;
            }
        set;
    }
    
    /**
    * @author:      Rogelio Jiménez
    * @date:        1/10/2016
    * @description: Coloca el valor de peso correspondiente a la Letra  beca
    * @param:       List<Lead> newLeads
    * @return:     
    */
    
     public void setWordValue(list<Opportunity> newOpps,map<Id,Opportunity> oldMap){
    	for(Opportunity opp :newOpps){
    		if(opp.LetraBeca__c != oldMap.get(opp.Id).LetraBeca__c && opp.LetraBeca__c != null){
    			opp.LetraBecaValor__c = PuntajeBeca__c.getValues(opp.LetraBeca__c).Valor__c;
    		}
    	}
    }
    
    public void verifyChangeGroup(list<Opportunity> newOpps,map<Id,Opportunity> oldMap){
    	map<Id,Grupo__c> mapGrupos = new map<Id,Grupo__c>();
    	list<Grupo__c> grupos = new list<Grupo__c>();
    	set<Id> idGrupos = new set<Id>();
    	for(Opportunity opp : newOpps){
    		if(opp.Grupo__c != null && oldMap.get(opp.Id).Grupo__c != opp.Grupo__c ){
    			idGrupos.add(opp.Grupo__c);
    		}
    	}
    	
    	try{
    		mapGrupos = new map<Id,Grupo__c>([SELECT id, Estatus__c FROM Grupo__c WHERE Id IN :idGrupos ]);
    	}catch(Exception e){
    	
    	}
    }

    //Actualiza contadores calvarez - 16 nov 2016
    public void updateCounters(List<Opportunity> newOpps, Map<Id, Opportunity> oldMap) {
        Map<Id, Id> groupsId = new Map<Id, Id>();
        for(Opportunity opp: newOpps) {
            if(opp.Grupo__c != null) {
                groupsId.put(opp.Grupo__c, opp.Grupo__c);
            }
            if(oldMap != null && oldMap.get(opp.Id) != null && oldMap.get(opp.Id).Grupo__c != null && oldMap.get(opp.Id).Grupo__c != opp.Grupo__c) {
                groupsId.put(oldMap.get(opp.Id).Grupo__c, oldMap.get(opp.Id).Grupo__c);
            }
        }

        if(groupsId.values().size() > 0) {
            
            //Inicializa grupos a actualizar
            Map<Id, Grupo__c> aux = new Map<Id, Grupo__c>();
            for(Id strId: groupsId.values()) {
                aux.put(strId, new Grupo__c(Id = strId, Inscritos__c = 0, ProspectosAsignados__c = 0, Validados__c = 0));
            }

            //Cuenta inscritos por grupo
            //Oportunidades
            AggregateResult[] counters = [SELECT count(Id) inscritos, Grupo__c From Opportunity Where Grupo__c IN: groupsId.values() AND StageName IN('Inscrito', 'Ganada') GROUP BY Grupo__c];
            for(AggregateResult counter: counters) {
                aux.get((Id) counter.get('Grupo__c')).Inscritos__c = Integer.valueOf(counter.get('inscritos'));
            }

            //Cuenta asignados por grupo
            //Oportunidades
            counters = [SELECT count(Id) asignados, Grupo__c From Opportunity Where Grupo__c IN: groupsId.values() AND StageName IN('Aspirante', 'Perdida') GROUP BY Grupo__c];
            for(AggregateResult counter: counters) {
                aux.get((Id) counter.get('Grupo__c')).ProspectosAsignados__c = Integer.valueOf(counter.get('asignados'));
            }
            //Candidatos
            counters = [SELECT count(Id) asignados, GrupoAsignado__c From Lead Where GrupoAsignado__c IN: groupsId.values() AND IsConverted=false GROUP BY GrupoAsignado__c];
            for(AggregateResult counter: counters) {
                aux.get((Id) counter.get('GrupoAsignado__c')).ProspectosAsignados__c += Integer.valueOf(counter.get('asignados'));
            }

            //Cuenta validados por grupo
            counters = [SELECT count(Id) validados, Grupo__c FROM Opportunity WHERE Validado__c=true AND Grupo__c IN: groupsId.values() GROUP BY Grupo__c ];
            for(AggregateResult counter: counters) {
                aux.get((Id) counter.get('Grupo__c')).Validados__c = Integer.valueOf(counter.get('validados'));
            }

            List<Grupo__c> groups = new List<Grupo__c>();
            for(Grupo__c g : aux.values()) {
                if(g.Id != null) {
                    groups.add(g);
                }
            }
            if(groups.size() > 0) {
                update groups;
            }
        }
    }
    
}