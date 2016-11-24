public with sharing class PagoTarjetaOpportunityCtrl {
	public Opportunity infoOpp;
   	public Boolean existApproval {get;set;}
    /**
    * @author:      Gerardo Martínez
    * @date:        17/06/2016
    * @modify by:	Gabriel García
    * @modify date:	06/09/2016
    * @description: Constructor del controlador PagoTarjetaOpportunityCtrl
    * @param:       ApexPages.StandardController controller (controlador estandar).
    * @return:      
    */
    public PagoTarjetaOpportunityCtrl(ApexPages.StandardController controller){
    	infoOpp = (Opportunity)controller.getRecord();
        existApproval = false;
    } 
    

    /**
    * @author:      Gabriel García
    * @date:        06/09/2016
    * @description: Regresa la página de aprobación de pago con tarjeta o captura de pago con tarjeta 
    * @param:       ApexPages.StandardController controller (controlador estandar).
    * @return:      PageReference Visual Force Page
    */
    public PageReference revisarAprobacionesPendientes(){
        try{
        	SolicitudBeca__C solicitudes = [SELECT Id FROM SolicitudBeca__c WHERE Oportunidad__c =: infoOpp.id AND Estatus__c = 'Inactivo'];
            if(solicitudes != null){
                existApproval = true;
                return null;
            }
        }catch(Exception e){
            System.debug(e.getMessage());
        }
        PageReference pagina = Page.OPP_PagoTarjeta; // new PageReference('OPP_PagoTarjeta?id='+infoOpp.id ); 
        pagina.getParameters().put('id', infoOpp.id);
        return pagina;
    }
    
    public PageReference exit(){
        return new PageReference('/' + infoOpp.id);
    }
}