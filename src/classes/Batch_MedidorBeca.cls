global class Batch_MedidorBeca implements Database.Batchable<sObject>, Database.AllowsCallouts {
    global string query = '';
    global Batch_MedidorBeca() {
        query ='SELECT LetraBeca__c, LetraBecaValor__c From Lead WHERE LetraBecaValor__c = null AND LetraBeca__c != null and  IsConverted = false ';
    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> sobjects) {
        list<Lead>leads = new list<Lead>();
        for(Object objecto : sobjects){
            Lead lead = (Lead) objecto;
            //System.debug(PuntajeBeca__c.getValues(lead.LetraBeca__c).Valor__c);
            lead.LetraBecaValor__c = PuntajeBeca__c.getValues(lead.LetraBeca__c).Valor__c;
            leads.add(lead);
        }
        update leads;
    }
    
    global void finish(Database.BatchableContext BC) {
        AsyncApexJob a = [SELECT Id, CreatedDate, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =:BC.getJobId()];
        // Send an email to the Apex job's submitter notifying of job completion. 
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> toAddresses = new String[] {'rjimenez@ctconsulting.com.mx','ggarcia@ctconsulting.com.mx'};
            mail.setToAddresses(toAddresses);
        mail.setSubject('Resúmen de ejecución de medidor');
        mail.setPlainTextBody('Lotes ejecutados: ' + a.TotalJobItems +', errores: '+ a.NumberOfErrors +'\n\n Hora de inicio:     ' + a.CreatedDate.format('dd-MM-YYYY HH:mm ss') +'\n Hora de término: ' + DateTime.now().format('dd-MM-YYYY HH:mm ss'));
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}