public  with sharing class EnviarComprobantePagoTarjetaCtrl {
    public FichaPago__c idToken {get; set;}
    private String mail='';
    private String nivel=''; 
    private String concepto='';
    private Pago__c pagos;
    
    public EnviarComprobantePagoTarjetaCtrl(ApexPages.StandardController controller ){
        idToken = (FichaPago__c)controller.getRecord();
    }
    
    public void sendMail(){  
		pagos = Pago__c.getInstance();        
        FichaPago__c fpid =[SELECT Oportunidad__c, NumeroAutorizacion__c, TotaPagar__c, FechaPago__c, HoraPago__c  FROM  FichaPago__c  WHERE Id = :idToken.Id]; 
        System.debug('fpid ' + fpid);
        
        if(fpid != null){
            Opportunity opp =[SELECT Nivel__r.Name, PrimerPagoConTarjeta__c, Pago__c, RecordType.Name, Folio__c,
                              CorreoCuenta__c FROM Opportunity WHERE Id =: fpid.Oportunidad__c]; 
            
            if((opp.Nivel__r.Name).equals('Doctorado') && opp.PrimerPagoConTarjeta__c && !opp.Pago__c){
                concepto = Schema.sObjectType.Pago__c.fields.Examen__c.getLabel();
            }
            else{
                concepto = Schema.sObjectType.Pago__c.fields.Inscripcion__c.getLabel();
            }
            
            mail=opp.CorreoCuenta__c;
            
            ComprobanteLeadCtrl.sendMailComprobante(opp.Folio__c, concepto, opp.CorreoCuenta__c, fpid.NumeroAutorizacion__c, String.valueOf(fpid.TotaPagar__c), String.valueOf(fpid.FechaPago__c), pagos.Mensaje_nota_comprobante__c, String.valueOf(fpid.HoraPago__c));                        
        }
    }
}