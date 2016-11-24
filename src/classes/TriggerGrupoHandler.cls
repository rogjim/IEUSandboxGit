public with sharing class TriggerGrupoHandler extends TriggerHandler {
        private Map<Id, Grupo__c> newMap;
        private Map<Id, Grupo__c> oldMap;
        private List<Grupo__c> newList;
        private List<Grupo__c> oldList;
        
        public TriggerGrupoHandler() {
                this.newMap = (Map<Id, Grupo__c>) trigger.newMap;
                this.oldMap = (Map<Id, Grupo__c>) trigger.oldMap;
                this.newList = (List<Grupo__c>) trigger.new;
                this.oldList = (List<Grupo__c>) trigger.old;
                
        }
    
       
        public override void beforeUpdate() {
           
           sendToERP(this.newList,this.oldMap);
           verifyApertura(this.newList,this.oldMap);
           assignNomenclatura(this.newList);
        }
        
        public override void afterUpdate(){
            updateOpportunities(this.newList);
        }
          /**
	    * @author:      Rogelio Jiménez
	    * @date:        
	    * @description: Cuando un  grupo es autorizado, cambia a Ganda las oportunidades que estan inscritas
	    * @param:       List<Lead> newLeads
	    * @return:     
	    */
        public void updateOpportunities(List<Grupo__c> groups){
            set<Id> idGroup = new set<Id>();
            for(Grupo__c grupo: groups){
                if(grupo.Estatus__c == 'Autorizado' && oldMap.get(grupo.Id).Estatus__c != grupo.Estatus__c){
                    idGroup.add(grupo.Id);
                }
            }
            
            list<Opportunity> opportunities  = new list<Opportunity>();
            try{
            	if(idGroup.size() > 0){
            		opportunities = [SELECT id,Name,StageName FROM Opportunity WHERE Grupo__c IN : idGroup AND  StageName = 'Inscrito'];
            	}
            }catch(Exception e){
            
            }
            for(Opportunity opportunidad:opportunities){
                opportunidad.StageName = 'Ganada';
            }
            if(opportunities.size() >0){
            	update opportunities;
            }
        }
        
        /**
	    * @author:      Rogelio Jiménez
	    * @date:        27/06/2016
	    * @description: Verifica el cambio en los campos para poder ser envaidos en Batch del ERP Master
	    * @param:       List<Lead> newLeads
	    * @return:     
	    */
	    
	    public void sendToERP(list<Grupo__c> groups,map<Id,Grupo__c> oldMap){
	    	if(Utils.MAP_OBJECT_FIELDS.containsKey('Grupo__c')){
	    		for(String field : Utils.MAP_OBJECT_FIELDS.get('Grupo__c')){
	    			for(Grupo__c grupo: groups){
		    			if(grupo.get(field) != oldMap.get(grupo.Id).get(field) &&!grupo.ModificadoERP__c){
		    				grupo.ModificadoERP__c = true;
		    				break;
		    			}
	    			}
	    		}
	    	}
	    }
	    
	     /**
	    * @author:      Rogelio Jiménez
	    * @date:        25/10/2016
	    * @description: Verifica el cambio de autorizado
	    * @param:       List<Lead> newLeads
	    * @return:     
	    */
	    
	  public void verifyApertura(list<Grupo__c> groups,map<Id,Grupo__c> oldMap){
	    	for(Grupo__c grupo : groups){
	    		/*if(grupo.UsuarioApertura__c != oldMap.get(grupo.Id).UsuarioApertura__c && grupo.UsuarioApertura__c != null && grupo.Estatus__c == 'Autorizado'){
	    			grupo.FechaApertura__c = date.today();
	    			grupo.AperturaOperativo__c = true;
	    		}*/
                
                if(grupo.FechaApertura__c == null &&
                   grupo.AperturaOperativo__c == false &&
                   oldMap.get(grupo.Id).UsuarioApertura__c == null && 
                   grupo.Estatus__c == 'Autorizado' &&
                   oldMap.get(grupo.Id).Estatus__c == 'Planeado'){
                       grupo.FechaApertura__c = date.today();
                       grupo.AperturaOperativo__c = true;
                   } else if(((grupo.FechaApertura__c != null && (grupo.AperturaOperativo__c == false || grupo.AperturaOperativo__c == true) ) ||
                              (grupo.FechaApertura__c == null && grupo.AperturaOperativo__c == true) ||                               
                              (grupo.FechaApertura__c == null && grupo.AperturaOperativo__c == false && oldMap.get(grupo.Id).UsuarioApertura__c != null)) && 
                             grupo.Estatus__c == 'Autorizado' &&
                             oldMap.get(grupo.Id).Estatus__c == 'Planeado'
                             ) {
                                 grupo.Estatus__c = 'Planeado';
                                 grupo.addError('El grupo ' + grupo.Name + ' no se pudo autorizar, contacte al administrador.');//calvarez 19nov2016 - revisal ELSE.
                                 grupo.UsuarioApertura__c = oldMap.get(grupo.Id).UsuarioApertura__c;
                             }
	    		
                /*
				if(grupo.UsuarioApertura__c != oldMap.get(grupo.Id).UsuarioApertura__c && grupo.Estatus__c == 'Autorizado' && grupo.FechaApertura__c == null && grupo.AperturaOperativo__c == false){
	    			grupo.FechaApertura__c = date.today();
	    			grupo.AperturaOperativo__c = true;
	    		} else if(grupo.Estatus__c == 'Autorizado') {
	    			grupo.Estatus__c = 'Planeado';
	    			grupo.AperturaOperativo__c = false;
	    			//grupo.addError('El grupo ' + grupo.Name + ' no se pudo autorizar, contacte al administrador.');//calvarez 19nov2016 - revisal ELSE.
	    			//grupo.UsuarioApertura__c = oldMap.get(grupo.Id).UsuarioApertura__c;
	    		}*/
	    	}	
	    }
	    
	     /**
	    * @author:      Rogelio Jiménez
	    * @date:        27/10/2016
	    * @description: Nueva rutina para para asignar nomenclatura
	    * @param:       List<Lead> newLeads
	    * @return:     
	    */
	    
	    public void assignNomenclatura(list<Grupo__c> groups){
	    	list<Grupo__c> grupos= new list<Grupo__c>();
	    	set<Id> idsGrupo = new set<Id>();
	    	map<Id,Grupo__c> mapGrupos = new map<Id,Grupo__c>();
	    	for(Grupo__c grupo: groups){
                if(grupo.Estatus__c == 'Autorizado' && this.oldMap.get(grupo.Id).Estatus__c != grupo.Estatus__c && (grupo.Consecutivo__c ==  0 || grupo.Consecutivo__c == null ) ){
                	grupos.add(grupo);
                	idsGrupo.add(grupo.id);
                }
            }
            
            try{
            	
            	 mapGrupos = new map<Id,Grupo__c>([SELECT Id,Estatus__c,OfertaEducativa__r.LetraNomenclatura__c,LlaveConsecutivo__c,consecutivo__c FROM Grupo__c WHERE id IN: idsGrupo]);
            	
            }catch(Exception e){
            	
            }
            
           for (Grupo__c grupoCero : grupos){
				 if(Utils.MAP_GRUPOS_CONSECUTIVO_MAX.containsKey(grupoCero.LlaveConsecutivo__c)){
					grupoCero.consecutivo__c = Utils.MAP_GRUPOS_CONSECUTIVO_MAX.get(grupoCero.LlaveConsecutivo__c) + 1;
					Integer  intConsecutivo =  Integer.valueOf(grupoCero.consecutivo__c);
					Utils.MAP_GRUPOS_CONSECUTIVO_MAX.put(grupoCero.LlaveConsecutivo__c, intConsecutivo);
					String letra = Utils.MAP_GRUPOS_LETRA_MAX.get(grupoCero.LlaveConsecutivo__c);
					grupoCero.Nomenclatura__c = getNomenclatura (letra, String.valueOf(intConsecutivo));
			
				}else{
					grupoCero.consecutivo__c = 1;
					String letra = mapGrupos.get(grupoCero.Id).OfertaEducativa__r.LetraNomenclatura__c != null ? mapGrupos.get(grupoCero.Id).OfertaEducativa__r.LetraNomenclatura__c : '';
					grupoCero.Nomenclatura__c = getNomenclatura (letra, String.valueOf(1));
				}
			}
            
	    }
        
         public String getNomenclatura (String letra, String consecutivo){
			String nomenclatura = '';
			String partConsecutivo = '000' + consecutivo;
			Integer longitud = letra.length() + consecutivo.length() < 5 ? 4: 5;
			integer intRight = longitud - letra.length();
			partConsecutivo = partConsecutivo.right(intRight);
			nomenclatura = letra + partConsecutivo;
			return nomenclatura;
		}
        
    }