public class ComprobantePagoTarjetaPDFCtrl {
    public FichaPago__c infoficha;
	public String folio {get; set;}
    public String concepto {get; set;}
    public String autorizacion {get; set;}
    public String cantidad {get; set;}
    public String fecha  {get; set;} 
    public String nota2 {get; set;}
    public String hora {get; set;}
    private Pago__c pagos;
    
    /**
    * @author:      Gabriel García
    * @date:        06/09/2016
    * @description: Constructor del controlador ComprobantePagoTarjetaPDFCtrl
    * @param:       ApexPages.StandardController controller (controlador estandar).
    * @return:      
    */
  
    public ComprobantePagoTarjetaPDFCtrl(ApexPages.StandardController controller){
    	infoFicha = (FichaPago__c)controller.getRecord();
    }
    
    /**
    * @author:      Gabriel García
    * @date:        06/09/2016
    * @description: Genera la página correspondiente al PDF del comprobante de pago.
    * @param:       ApexPages.StandardController controller (controlador estandar).
    * @return:      PageReference Visual Force Page
    */
    
     public void generarComprobantePDF(){
         FichaPago__c ord;
         try{
             pagos = Pago__c.getInstance();        
             FichaPago__c fpid =[SELECT Oportunidad__c, NumeroAutorizacion__c, TotaPagar__c, FechaPago__c, HoraPago__c  FROM  FichaPago__c  WHERE Id = :infoFicha.Id]; 
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
                 
                 folio = opp.Folio__c;
                 autorizacion = fpid.NumeroAutorizacion__c;
                 cantidad = String.valueOf(fpid.TotaPagar__c);
                 fecha = fpid.FechaPago__c.format();
                 nota2 =  pagos.Mensaje_nota_comprobante__c;
                 hora = fpid.HoraPago__c;
             }
         }catch(Exception e){
             System.debug(e.getMessage());
         }        
         
    }
    
}