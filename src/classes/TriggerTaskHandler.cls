public with sharing class TriggerTaskHandler extends TriggerHandler {
    private Map<Id, Task> newMap;
	private Map<Id, Task> oldMap;
	private List<Task> newList;
	private List<Task> oldList;
	
	public TriggerTaskHandler() {
			this.newMap = (Map<Id, Task>) trigger.newMap;
			this.oldMap = (Map<Id, Task>) trigger.oldMap;
			this.newList = (List<Task>) trigger.new;
			this.oldList = (List<Task>) trigger.old;
			
	}
	
	public override void beforeDelete(){
		Negocio__c negocio = Negocio__c.getInstance(userinfo.getProfileId());
		if(!negocio.PermitirBorrarTareas__c){
			for(Task oldTask : oldList){
				oldTask.addError('No cuenta con permisos para borrar este registro.');
			}
		}
	}
}