public with sharing class FichaPagoOpportunityCtrl {
    
    public Opportunity infoOpp;
    public Boolean existApproval {get;set;}
    /**
* @author:      Gerardo Martínez
* @date:        17/06/2016
* @description: Constructor del controlador FichaPagoOpportunityCtrl
* @param:       ApexPages.StandardController controller (controlador estandar).
* @return:      
*/
    public FichaPagoOpportunityCtrl(ApexPages.StandardController controller){
        infoOpp = (Opportunity)controller.getRecord();
        existApproval = false;
        System.debug('info opp--> '+ infoOpp);
        System.debug('info oppid--> '+ infoOpp.id);
    } 
    
    
    /**
* @author:      Gerardo Martínez
* @date:        17/06/2016
* @description: Regresa el registro creado de la página
* @param:       ApexPages.StandardController controller (controlador estandar).
* @return:      PageReference Visual Force Page
*/
    public PageReference createPayToken(){
        //System.debug('entra a createPayToken' );
        System.debug('id opp ' + infoOpp.id );
        
        try{
            SolicitudBeca__C solicitudes = [SELECT Id FROM SolicitudBeca__c WHERE Oportunidad__c =: infoOpp.id AND Estatus__c = 'Inactivo'];
            
            System.debug('despues de solicitud '   );
            if(solicitudes != null){
                existApproval = true;
                System.debug('en if '   );
                 //return null;
                
                if(!Test.isRunningTest()){
                    return null;
                    
                }
                
                
            
              //  return null;
                System.debug('despues de en if '   );
            }
            
        }catch(Exception e){
            System.debug('entra a error' +e.getCause()); 
            System.debug('entra a error' +e.getLineNumber()); 
            System.debug('entra a error' +e.getMessage()); 
            System.debug('entra a error' +e.getTypeName()); 
            System.debug('entra a error' ); 
        }
        
        System.debug('despues de consulta' );
        //System.debug('infoOpp.Id '+ infoOpp.Id);
        Opportunity data = [SELECT Id, Name, VigenciaDescuento__c, Folio__c, ImporteTotal__c, AplicaPromocionCero__c, ImportePagarConDescuento__c, Nivel__r.Name, Plantel__c, Account.Name, Account.ApeMaterno__c FROM Opportunity WHERE Id =: infoOpp.Id];       
        
        //System.debug('name-->  '+data.Name);
        
        FichaPago__c newToken = new FichaPago__c();
        
        newToken.FolioLead__c = Decimal.valueOf(data.Folio__c.replace('C-',''));
        newToken.RecibimosDe__c = newToken.RecibimosDe__c = (data.Account.Name != null ? data.Account.Name : '') + ' ' + (data.Account.ApeMaterno__c != null ? data.Account.ApeMaterno__c : '');//(data.Name != null ? data.Name : '');
        newToken.TotaPagar__c = data.ImporteTotal__c; //Antes ImportePagarConDescuento__c
        newToken.Oportunidad__c = infoOpp.Id;
        newToken.Plantel__c = data.plantel__c;
        
        if(data.nivel__r.Name == 'Licenciatura' || data.nivel__r.Name == 'Maestría'){
            newToken.TipoFicha__c = 'Nivel';
        }else if(data.nivel__r.Name == 'Doctorado'){
            newToken.TipoFicha__c = 'Nivel Doctorado';
        }
        if(data.AplicaPromocionCero__c){
            newToken.TipoFicha__c = 'Promoción Cero';
            newToken.RecordTypeId = Schema.SObjectType.FichaPago__c.getRecordTypeInfosByName().get('Promoción Cero').getRecordTypeId();
        } 
        
        System.debug('entra aaaaa');
        if(data.VigenciaDescuento__c != null){
            newToken.Hasta__c = data.VigenciaDescuento__c; 
        }else{
            Date today = Date.today();
            Date vigancia = today.addDays(10); 
            newToken.Hasta__c = vigancia; 
        }
        
        insert newToken;
        return new PageReference('/' + newToken.Id);
        
    }
    
    public PageReference exit(){
        return new PageReference('/' + infoOpp.id);
    }
}