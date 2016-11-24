@IsTest public with sharing class TriggerSolicitudBecaHandlerTest {
    @IsTest   public static void  TriggerSolicitudBecaHandlerTest(){
    	SolicitudBeca__c solicitudBeca = new SolicitudBeca__c (Name = 'solicitudBeca');	
    	insert solicitudBeca;
    }
}