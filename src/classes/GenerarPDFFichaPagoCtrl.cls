public with sharing class GenerarPDFFichaPagoCtrl {
    public FichaPago__c idToken {get; set;}
    private String mail='';
    private String nivel=''; 
    private String mailOwner='';
    
    public GenerarPDFFichaPagoCtrl(ApexPages.StandardController controller ){
        idToken = (FichaPago__c)controller.getRecord();
    }
    
    public void sendMail(){  
        FichaPago__c ord = new FichaPago__c(); 
        
        FichaPago__c fpid =[SELECT Lead__c FROM  FichaPago__c  WHERE Id = :idToken.Id]; 
        
        if( fpid.Lead__c!=null){ 
            ord = [SELECT Id, FolioLead__c, ReferenciaCliente__c, RecordType.Name, ConceptoEspecial__c,Concepto__c, RecibimosDe__c, TotaPagar__c,
                   Notas1__c, Notas2__c, NotaEspecial__c, Name, CondensacionFecha__c, Constante__c, CadenaCodigo__c,
                   Lead__r.Email, Lead__r.Owner.Email, Hasta__c, Plantel__r.Instituto__r.Encabezado__c, ProgramasRelacionados__c, Lead__r.Nivel__r.Name,
                   ReferenciaOXXO__c, ReferenciaHSBC__c, Plantel__r.Instituto__r.ConvenioHSBC__c FROM FichaPago__c WHERE Id = :idToken.Id];
            mailOwner = ord.Lead__r.Owner.Email;
            mail=ord.Lead__r.Email;
            nivel=ord.Lead__r.Nivel__r.Name; 
        }else{ 
            ord = [SELECT Id, FolioLead__c, ReferenciaCliente__c, RecordType.Name, ConceptoEspecial__c,Concepto__c, RecibimosDe__c, TotaPagar__c,
                   Notas1__c, Notas2__c, NotaEspecial__c, Name, CondensacionFecha__c, Constante__c, CadenaCodigo__c,
                   Oportunidad__r.Account.PersonEmail, Oportunidad__r.Owner.Email, Hasta__c, Plantel__r.Instituto__r.Encabezado__c, ProgramasRelacionados__c, Oportunidad__r.Nivel__r.Name,
                   ReferenciaOXXO__c, ReferenciaHSBC__c, Plantel__r.Instituto__r.ConvenioHSBC__c FROM FichaPago__c WHERE Id = :idToken.Id];
            mailOwner = ord.Oportunidad__r.Owner.Email;
            mail=ord.Oportunidad__r.Account.PersonEmail;
            nivel=ord.Oportunidad__r.Nivel__r.Name; 
        }
        if(ord.RecordType.Name == 'Ficha Especial'){
            BarCodeLeadCtrl.sendMail(ord.Hasta__c, ord.NotaEspecial__c,'', ord.ConceptoEspecial__c, mail, ord.RecibimosDe__c, String.valueOf(ord.FolioLead__c), String.valueOf(ord.TotaPagar__c), ord.ReferenciaHSBC__c, ord.ReferenciaOXXO__c, String.valueOf(ord.Plantel__r.Instituto__r.Encabezado__c), String.valueOf(ord.Plantel__r.Instituto__r.ConvenioHSBC__c), mailOwner);
        }else if(ord.RecordType.Name == 'Ficha de Nivel'){
            if(nivel == 'Cursos y Diplomados'){
                BarCodeLeadCtrl.sendMail(ord.Hasta__c, ord.Notas1__c, ord.Notas2__c, ord.Concepto__c, mail, ord.RecibimosDe__c, String.valueOf(ord.FolioLead__c), String.valueOf(ord.TotaPagar__c), ord.ReferenciaHSBC__c, ord.ReferenciaOXXO__c, String.valueOf('INSTITUTO_NIVEL2'), String.valueOf(ord.Plantel__r.Instituto__r.ConvenioHSBC__c), mailOwner);
            }else{   
                BarCodeLeadCtrl.sendMail(ord.Hasta__c, ord.Notas1__c, ord.Notas2__c, ord.Concepto__c, mail, ord.RecibimosDe__c, String.valueOf(ord.FolioLead__c), String.valueOf(ord.TotaPagar__c), ord.ReferenciaHSBC__c, ord.ReferenciaOXXO__c, String.valueOf(ord.Plantel__r.Instituto__r.Encabezado__c), String.valueOf(ord.Plantel__r.Instituto__r.ConvenioHSBC__c), mailOwner);
            }
        }else{  
            BarCodeLeadCtrl.sendMail(ord.Hasta__c, ord.Notas1__c, ord.Notas2__c, ord.Concepto__c, mail, ord.RecibimosDe__c, String.valueOf(ord.FolioLead__c), String.valueOf(ord.TotaPagar__c), ord.ReferenciaHSBC__c, ord.ReferenciaOXXO__c, String.valueOf(ord.Plantel__r.Instituto__r.Encabezado__c), String.valueOf(ord.Plantel__r.Instituto__r.ConvenioHSBC__c), mailOwner);
        }
    }
}