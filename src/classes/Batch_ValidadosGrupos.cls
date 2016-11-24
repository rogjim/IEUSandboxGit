global with sharing class Batch_ValidadosGrupos implements Database.Batchable<sObject>, Database.AllowsCallouts{
	AggregateResult [] results {get;set;} 
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		String query = 'SELECT Validados__c,Id FROM Grupo__c'; 
		return Database.getQueryLocator(query);
	} 
 
	global void execute(Database.BatchableContext BC, List<sObject> scope){ 
		list<Grupo__c> grupos = new list<Grupo__c>();
		for (sObject ar : scope)  {
		    Grupo__c grupo = (Grupo__c) (ar);
		    grupo.Validados__c = getValidadosPerGrupo(grupo);
		    grupos.add(grupo);
		}
		update grupos;
	} 
	
 
	global void finish(Database.BatchableContext BC){ 
		AsyncApexJob a = [SELECT Id, CreatedDate, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =:BC.getJobId()];
	        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	        List<String> toAddresses = new String[] {'rjimenez@ctconsulting.com.mx'};
	        mail.setToAddresses(toAddresses);
	        mail.setSubject('Resúmen de ejecución de validados');
	        mail.setPlainTextBody('Lotes ejecutados: ' + a.TotalJobItems +', errores: '+ a.NumberOfErrors +'\n\n Hora de inicio:     ' + a.CreatedDate.format('dd-MM-YYYY HH:mm ss') +'\n Hora de término: ' + DateTime.now().format('dd-MM-YYYY HH:mm ss'));
	        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
	}
	
	private Integer getValidadosPerGrupo(Grupo__c grupo){
		Integer validados = 0;
		AggregateResult [] results = [SELECT count(Id) validados FROM Opportunity WHERE Validado__c = true AND Grupo__c =: grupo.Id  GROUP BY Grupo__c ];
		if(results != null && results.size() > 0){
			validados = Integer.valueOf(results[0].get('validados'));
		}
		return validados;
	
	}
    
}