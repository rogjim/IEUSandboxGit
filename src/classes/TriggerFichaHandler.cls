public class TriggerFichaHandler extends TriggerHandler{
    
    /**
* @author:      Salvador Reyna 
* @date:        17/06/2016
* @description: Trigger antes de insertar para evitar la inserción de fichas erroneas por Data Loader
* @param:       
* @return:      
*/
    
    public override void beforeInsert(){
        for (FichaPago__c token : (List<FichaPago__c>) trigger.new){
            if(token.ReferenciaHSBC__c != null || token.ReferenciaOXXO__c != null){
                token.addError('No hay ficha asociada para esta referencia');
            }
        }
    }
    
    
    /**
* @author:      Gerardo Martínez 
* @date:        17/06/2016
* @description: Trigger despues de insertar una ficha de pago, envia la misma por correo electrónico 
* @param:       
* @return:      
*/
    
    public override void afterInsert(){
        
        SET<Id> ids = new SET<Id>();
        List<FichaPago__c> fichas= new List<FichaPago__c> ();
        List<FichaPago__c> listFicha = new List<FichaPago__c>();
        
        for (FichaPago__c token : (List<FichaPago__c>) trigger.new){
            ids.add(token.Id);
        }
        fichas = [SELECT Id, Oportunidad__c, Oportunidad__r.CorreoCuenta__c, FolioLead__c, ReferenciaCliente__c, RecordType.Name, ConceptoEspecial__c,Concepto__c, RecibimosDe__c, TotaPagar__c,
                  Notas1__c, Notas2__c, NotaEspecial__c, Name, CondensacionFecha__c, Constante__c, CadenaCodigo__c, ReferenciaHSBC__c, ReferenciaOXXO__c,
                  Lead__r.Email, Hasta__c, Plantel__r.Instituto__r.Encabezado__c, ProgramasRelacionados__c, Lead__r.Nivel__r.Name, Plantel__r.Instituto__r.PrefijoOXXO__c,  
                  Oportunidad__r.Name, Oportunidad__r.Nivel__r.Name, Plantel__r.Instituto__r.ConvenioHSBC__c,Plantel__r.Instituto__r.MostrarReferenciaOXXO__c
                  FROM FichaPago__c WHERE Id IN :ids];        
        
        for(FichaPago__c token : fichas){
            if(token.Lead__c!=null){   
                String mailOwner = [SELECT Owner.Email FROM Lead WHERE Id =: token.Lead__c].Owner.Email;
            	if (token.Plantel__r.Instituto__r.MostrarReferenciaOXXO__c){    
                	token.ReferenciaOXXO__c = Utils.getOXXOReference(token.Plantel__r.Instituto__r.PrefijoOXXO__c  + token.cadenaCodigo__c);
            	}
                token.ReferenciaHSBC__c = Utils.getHSBCReference(token.ReferenciaCliente__c, token.CondensacionFecha__c, token.Constante__c, String.valueOf(token.TotaPagar__c));
                if(token.RecordType.Name == 'Ficha Especial'){
                    BarCodeLeadCtrl.sendMail(token.Hasta__c, token.NotaEspecial__c,'', token.ConceptoEspecial__c, token.Lead__r.Email, token.RecibimosDe__c, String.valueOf(token.FolioLead__c), String.valueOf(token.TotaPagar__c), token.ReferenciaHSBC__c, token.ReferenciaOXXO__c, String.valueOf(token.Plantel__r.Instituto__r.Encabezado__c), String.valueOf(token.Plantel__r.Instituto__r.ConvenioHSBC__c), mailOwner);
                }else if(token.RecordType.Name == 'Ficha de Nivel'){
                    if(token.Lead__r.Nivel__r.Name == 'Cursos y Diplomados'){
                        BarCodeLeadCtrl.sendMail(token.Hasta__c, token.Notas1__c, token.Notas2__c, token.Concepto__c, token.Lead__r.Email, token.RecibimosDe__c, String.valueOf(token.FolioLead__c), String.valueOf(token.TotaPagar__c), token.ReferenciaHSBC__c, token.ReferenciaOXXO__c, String.valueOf('INSTITUTO_NIVEL2'), String.valueOf(token.Plantel__r.Instituto__r.ConvenioHSBC__c), mailOwner);
                    }else{                
                        BarCodeLeadCtrl.sendMail(token.Hasta__c, token.Notas1__c, token.Notas2__c, token.Concepto__c, token.Lead__r.Email, token.RecibimosDe__c, String.valueOf(token.FolioLead__c), String.valueOf(token.TotaPagar__c), token.ReferenciaHSBC__c, token.ReferenciaOXXO__c, String.valueOf(token.Plantel__r.Instituto__r.Encabezado__c), String.valueOf(token.Plantel__r.Instituto__r.ConvenioHSBC__c), mailOwner);
                    }
                }
                listFicha.add(token);
            }else if(token.Oportunidad__c!=null){    
            	if (token.Plantel__r.Instituto__r.MostrarReferenciaOXXO__c){              
                	token.ReferenciaOXXO__c = Utils.getOXXOReference(token.Plantel__r.Instituto__r.PrefijoOXXO__c  + token.cadenaCodigo__c);
            	}
                token.ReferenciaHSBC__c = Utils.getHSBCReference(token.ReferenciaCliente__c, token.CondensacionFecha__c, token.Constante__c, String.valueOf(token.TotaPagar__c));              
                listFicha.add(token);
            }else{
            	if (token.Plantel__r.Instituto__r.MostrarReferenciaOXXO__c){  
                	token.ReferenciaOXXO__c = Utils.getOXXOReference(token.Plantel__r.Instituto__r.PrefijoOXXO__c + token.cadenaCodigo__c);
            	}
                token.ReferenciaHSBC__c = Utils.getHSBCReference(token.ReferenciaCliente__c, token.CondensacionFecha__c, token.Constante__c, String.valueOf(token.TotaPagar__c));
                listFicha.add(token);
            }            
        }
        update listFicha;
    }
}