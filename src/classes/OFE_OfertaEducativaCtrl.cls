public with sharing class OFE_OfertaEducativaCtrl {
    
    public OFE_OfertaEducativaCtrl(ApexPages.StandardController std){
        
    }
    public OFE_OfertaEducativaCtrl(){
        
    }    
  
    @RemoteAction
    public static List<sObject> query(String query) {
		return Database.query(query);   
    }
    
    @RemoteAction
    public static List<sObject> queryCount(String query) {
        if(!String.isEmpty(query)){            
            List<AggregateResult > obj = database.query(query);
            //System.debug('obj ' + obj);
            return obj;
        }
        return null;
    }

    @RemoteAction
    public static Schema.DescribeSobjectResult[] describe(String[] objs) {
       
        return Schema.describeSObjects(objs);
    }

    @RemoteAction
    public static List<Database.DeleteResult> deleteIds(String[] ids) {
        return Database.delete(ids);
    }
    
    @RemoteAction
    public static List<Database.UpsertResult> upsertObjects(String objType, String jsonString) {
        Type t = Type.forName('List<'+objType+'>');
        List<sObject> instances = (List<sObject>) JSON.deserialize(jsonString, t);
        System.debug(instances);
        return Database.upsert(instances);
    }
    
    @RemoteAction
    public static List<String> existeOFEenBCA (List<String> Periodos, List<String> Modalidades, List<String> Niveles, String[] fInicio, String[] fFin){
        String query = 'SELECT Id, Periodo__r.Name, Modalidad__r.Name, Nivel__r.Name, Descuento__r.Name, Descuento__r.FechaInicioVigencia__c, Descuento__r.FechaFinVigencia__c FROM BecaConvenioAsignacion__c WHERE RecordType.Name=\'Descuento\' AND Descuento__c !=null';// +
          /*  + '((fechaInicio>=Descuento__r.FechaInicioVigencia__c AND fechaFin<=Descuento__r.FechaFinVigencia__c) OR '+
            + '(Descuento__r.FechaFinVigencia__c>=fechaInicio AND Descuento__r.FechaFinVigencia__c<=fechaFin) OR '+
            + '(Descuento__r.FechaInicioVigencia__c>=fechaInicio AND Descuento__r.FechaInicioVigencia__c<=fechaFin))'; */  
        Date fechaInicio = Date.newInstance(Integer.valueOf(fInicio[2]), Integer.valueOf(fInicio[1]), Integer.valueOf(fInicio[0]));
        Date fechaFin = Date.newInstance(Integer.valueOf(fFin[2]), Integer.valueOf(fFin[1]), Integer.valueOf(fFin[0]));
        String andQuery= ' AND (';
        if(Periodos.size() == Modalidades.size() && Periodos.size() == Niveles.size()){
            for(Integer i = 0; i<Periodos.size(); i++){
                andQuery += Periodos[i] == 'Todos'  ? '(PeriodosTodos__c = true AND ' : '(Periodo__c = \'' + Periodos[i] + '\' AND ';
                andQuery += Modalidades[i] == 'Todos'  ? 'ModalidadTodas__c = true AND ' : 'Modalidad__c = \'' + Modalidades[i] + '\' AND ';
                andQuery += Niveles[i] == 'Todos'  ? 'NivelTodos__c = true) ' : 'Nivel__c = \'' + Niveles[i] + '\') ';
                andQuery += i != Periodos.size()-1 ? ' OR ' : ')';                
            }
        }      
        query += andQuery;
        List<String> becasCoincidentes = new List<String>();
        try{
            List<BecaConvenioAsignacion__c> becas = Database.query(query);
            String periodo='';
            String modalidad='';
            String nivel='';
            for(BecaConvenioAsignacion__c beca: becas){
                if ((fechaInicio>=beca.Descuento__r.FechaInicioVigencia__c 	&& fechaFin<=beca.Descuento__r.FechaFinVigencia__c) 	||
                     (beca.Descuento__r.FechaFinVigencia__c>=fechaInicio 	&& beca.Descuento__r.FechaFinVigencia__c<=fechaFin) 	||
                     (beca.Descuento__r.FechaInicioVigencia__c>=fechaInicio && beca.Descuento__r.FechaInicioVigencia__c<=fechaFin)){
                       periodo = beca.Periodo__r.Name == null ? ' Todos, ' : ' '+beca.Periodo__r.Name+', '; 
                       modalidad = beca.Modalidad__r.Name == null ? ' Todos, ' : ' '+beca.Modalidad__r.Name+', '; 
                       nivel = beca.Nivel__r.Name == null ? ' Todos. ' : ' '+beca.Nivel__r.Name+'. '; 
                       becasCoincidentes.add(periodo + modalidad + nivel + 'Para el descuento: ' +beca.Descuento__r.Name);
                   }
            }
            return becasCoincidentes;
        }catch(Exception e){
            System.debug('Exception '+e.getTypeName()+' Cause: ' + e.getCause() + ', Message: ' + e.getMessage());
            return null;
        }
        return becasCoincidentes;
    }

    @RemoteAction
    public static Reports.reportResults getReport(String idReport, String periodName, Boolean details) {
        Reports.ReportDescribeResult describe = Reports.ReportManager.describeReport(idReport);
        Reports.ReportMetadata rm = describe.getReportMetadata();
        if(rm.getReportFilters().size() > 0) {
            rm.getReportFilters()[0].setValue(periodName);
        }
        //List<Reports.ReportFilter> filters = rm.getReportFilters();
        //filters.add(new Reports.ReportFilter('Opportunity.Periodo__c', 'contains', periodName));
        //rm.setReportFilters(filters);

        return Reports.ReportManager.runReport(idReport, rm, details);
    }

    @RemoteAction
    public static Reports.ReportDescribeResult describeReport(String idReport) {
        return Reports.ReportManager.describeReport(idReport);
    }
    
    
     @RemoteAction
     public static list<Medidor> getMedidores(String periodo,String nombreInforme) {
      	 list<Medidor> medidores = new list<Medidor>();
      	 List <Report> reportList = [SELECT Id,DeveloperName FROM Report where 
		 DeveloperName =: nombreInforme];
		 String reportId = (String)reportList.get(0).get('Id');
		
		
		Reports.ReportDescribeResult describe = Reports.ReportManager.describeReport(reportId);
		Reports.ReportMetadata reportMedata = describe.getReportMetadata();
		Reports.reportResults results = null;
		
		//reportMedata.getReportFilters()[2].setValue(periodo); //Es fijo e indica el indice del filtro correspondiende a Periodo
		for(Reports.ReportFilter rf : reportMedata.getReportFilters()){
			if(rf.getColumn().contains('Periodo')){
				rf.setValue(periodo);
			}
		}
		
		boolean isFinish = false;
	    Reports.ReportInstance reportInstanceUno = Reports.ReportManager.runAsyncReport(reportId,reportMedata, true);
        Id instanceId = reportInstanceUno.getId();
		do{
			Reports.ReportInstance reportInstance = Reports.ReportManager.getReportInstance(instanceId);
			boolean reportIsRunning = reportInstance.getStatus() == 'Running' || reportInstance.getStatus() == 'New';
			if (!reportIsRunning) {
				results = reportInstance.getReportResults();
				medidores = processResult(results);
				isFinish = true;
			}
		}while(!isFinish);
      	
      	return medidores;
     }
    
     public static list<Medidor> processResult(Reports.reportResults results){
    	list<Medidor> medidores = new list<Medidor>();
    	//Reports.reportResults results = Reports.ReportManager.runReport(reportId, reportMedata,false);
		Reports.Dimension dim = results.getGroupingsDown();

		for(integer indice = 0; indice < dim.getGroupings().size() ; indice ++){
			Medidor medidor = new Medidor();
			Reports.GroupingValue groupingVal = dim.getGroupings()[indice];
			medidor.name = groupingVal.getLabel();
			medidor.idOwner = String.valueOf(groupingVal.getValue());
			String factMapKey = groupingVal.getKey() + '!T';
		
			// Get the fact map from the report results
			Reports.ReportFactWithDetails factDetails = (Reports.ReportFactWithDetails)results.getFactMap().get(factMapKey);
		
			// Get the first summary amount from the fact map
			Reports.SummaryValue sumVal = factDetails.getAggregates()[0];
			String letraSuma = String.valueOf(sumVal.getLabel());
			letraSuma = letraSuma.replace(',','');
			medidor.suma = Decimal.valueOf(letraSuma);
			medidores.add(medidor);
		}
		return medidores;
    }

    public  class Medidor{
    	public String idOwner {get;set;}
    	public String name {get;set;}
    	public Decimal suma {get;set;}
    	
    	public Medidor(){
    	}
    }
}