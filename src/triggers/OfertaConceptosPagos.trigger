trigger OfertaConceptosPagos on OfertaConceptoPagos__c (after update) {
// new TriggerModificadoERPGrupoPago().run();
   new TriggerOfertaConceptoPago().run();
}