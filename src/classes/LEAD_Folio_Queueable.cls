public without sharing class LEAD_Folio_Queueable implements Queueable,Database.AllowsCallouts {
    public list<Lead> leads {get;set;}
	
	public LEAD_Folio_Queueable(list<Lead> leads){
		this.leads = leads;
	}
	
	 public void execute(QueueableContext context) {
	 	list<Lead> leadsClone = new list<Lead>();
	 	Negocio__c configuracionNegocio = Negocio__c.getOrgDefaults();
    	Integer nextFolio = configuracionNegocio.Folio__c != null ? Integer.valueOf(configuracionNegocio.Folio__c) : 0;
	 	for(Lead lead: this.leads){
	 		nextFolio = nextFolio + 1;
	 		Lead cloneLead = lead.clone(true,true,false,false);
     		cloneLead.Folio__c = String.valueOf(nextFolio);
     		leadsClone.add(cloneLead);
	 	}
	 	configuracionNegocio.Folio__c = nextFolio;
	 	update leadsClone;
     	update configuracionNegocio;
	 }
}