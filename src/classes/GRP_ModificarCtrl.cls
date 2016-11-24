public with sharing class GRP_ModificarCtrl {
	
    public GRP_ModificarCtrl(ApexPages.StandardController stdController){
	
	}
	
	public PageReference redirigir(){
		PageReference pagRef = new PageReference('../apex/OFE_OfertaEducativa');
		pagRef.setRedirect(true);
		return pagRef;
	}
}