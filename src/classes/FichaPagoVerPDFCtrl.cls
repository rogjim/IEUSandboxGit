public class FichaPagoVerPDFCtrl {
	public FichaPago__c infoficha;
    public String hasta {get; set;}
    public String recibimosde {get; set;}
    public String pago {get; set;}
    public String nota1 {get; set;}
    public String nota2 {get; set;}
    public String folio {get; set;}
    public String HSBCRef {get; set;}
    public String cadenaCodigo {get; set;}
    public String concept {get; set;}
    public String encabezado {get; set;}
    public String numServicio {get; set;}
    public Datetime fechaCreacion {get; set;}
      public String fechaString  {get; set;}
    
    
    /**
    * @author:      Gabriel García
    * @date:        06/09/2016
    * @description: Constructor del controlador FichaPagoVerPDFCtrl
    * @param:       ApexPages.StandardController controller (controlador estandar).
    * @return:      
    */
  
    public FichaPagoVerPDFCtrl(ApexPages.StandardController controller){
    	infoFicha = (FichaPago__c)controller.getRecord();
    }
    
    /**
    * @author:      Gabriel García
    * @date:        06/09/2016
    * @description: Genera la página correspondiente al PDF de la ficha de pago.
    * @param:       ApexPages.StandardController controller (controlador estandar).
    * @return:      PageReference Visual Force Page
    */
    public void generarFichaPagoPDF(){
        FichaPago__c ord;
        try{
            ord = [SELECT Id, ReferenciaCliente__c, RecordType.Name, FolioLead__c, ConceptoEspecial__c,Concepto__c, RecibimosDe__c, TotaPagar__c,
                            Notas1__c, Notas2__c, NotaEspecial__c, Name, CondensacionFecha__c, Constante__c, CadenaCodigo__c,
                            Lead__r.Email, Hasta__c, Plantel__r.Instituto__r.Encabezado__c, ProgramasRelacionados__c, Lead__r.Nivel__r.Name,
                            ReferenciaOXXO__c, ReferenciaHSBC__c, Plantel__r.Instituto__r.ConvenioHSBC__c , CreatedDate FROM FichaPago__c WHERE Id = :infoFicha.Id];            
        }catch(Exception e){
            System.debug(e.getMessage());
        }        
        String myDate = String.valueOf(ord.Hasta__c);
        String[] myDateOnly = myDate.split(' ');
        String[] strDate = myDateOnly[0].split('-');
        Integer myIntMonth = integer.valueOf(strDate[1]);
        Integer myIntYear = integer.valueOf(strDate[0]);
        Integer myIntDate = integer.valueOf(strDate[2]);
        hasta = myIntDate +'-'+myIntMonth+'-'+myIntYear;
        hasta = myIntDate +'-'+myIntMonth+'-'+myIntYear;
        recibimosde = ord.RecibimosDe__c;
		pago = String.valueOf(ord.TotaPagar__c);
        if(ord.RecordType.Name == 'Ficha Especial'){
        	nota1 = ord.NotaEspecial__c;
        }else{
        	nota1 = ord.Notas1__c;
        }
		nota2 = ord.Notas2__c;
        folio = String.valueOf(ord.FolioLead__c);
        HSBCRef = ord.ReferenciaHSBC__c;
        cadenaCodigo = ord.ReferenciaOXXO__c;
        concept = ord.Concepto__c;
        encabezado = ord.Plantel__r.Instituto__r.Encabezado__c;
        numServicio = ord.Plantel__r.Instituto__r.ConvenioHSBC__c;
        fechaCreacion = ord.CreatedDate;
        
        fechaString =  fechaCreacion.format('dd/MM/yyyy HH:mm:ss') ;
    }
    
}