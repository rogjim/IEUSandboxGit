global class Batch_InscritosGrupos implements Database.Batchable<sObject>, Database.AllowsCallouts{ 
	AggregateResult [] results {get;set;} 
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		String query = 'SELECT Inscritos__c,Id FROM Grupo__c'; 
		return Database.getQueryLocator(query);
	} 
 
	global void execute(Database.BatchableContext BC, List<sObject> scope){ 
		list<Grupo__c> grupos = new list<Grupo__c>();
		for (sObject ar : scope)  {
		    Grupo__c grupo = (Grupo__c) (ar);
		    grupo.Inscritos__c = getInscritosPerGrupo(grupo);
		    grupos.add(grupo);
		}
		update grupos;
	} 
	
 
	global void finish(Database.BatchableContext BC){ 
		AsyncApexJob a = [SELECT Id, CreatedDate, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =:BC.getJobId()];
	        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	        List<String> toAddresses = new String[] {'rjimenez@ctconsulting.com.mx'};
	        mail.setToAddresses(toAddresses);
	        mail.setSubject('Resúmen de ejecución de inscritos');
	        mail.setPlainTextBody('Lotes ejecutados: ' + a.TotalJobItems +', errores: '+ a.NumberOfErrors +'\n\n Hora de inicio:     ' + a.CreatedDate.format('dd-MM-YYYY HH:mm ss') +'\n Hora de término: ' + DateTime.now().format('dd-MM-YYYY HH:mm ss'));
	        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
	}
	
	private Integer getInscritosPerGrupo(Grupo__c grupo){
		Integer inscritos = 0;
		AggregateResult [] results = [SELECT count(Id) inscritos FROM Opportunity WHERE (StageName = 'Inscrito' OR  StageName  = 'Ganada') AND Grupo__c =: grupo.Id  GROUP BY Grupo__c ];
		if(results != null && results.size() > 0){
			inscritos = Integer.valueOf(results[0].get('inscritos'));
		}
		return inscritos;
	
	}
}