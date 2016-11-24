public with sharing class BarCodeMovilCtrl {

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
    public String sig {get; set;}
    public String plantel {get; set;}
    public List<String> programas {get; set;}
    public String totalPagar {get; set;}
    public List<FichaPago__c> fichas {get; set;}
    public String fecha  {get; set;}
    public Datetime  fechaCreacion  {get; set;}
    
    public BarCodeMovilCtrl(){
      
        String Ids = apexpages.currentpage().getparameters().get('ids');
      //  System.debug('primer prueba id--> '+Ids);
        programas = new List<String>();
        
         //Obtener Fichas de la base de datos
        fichas = getFichasFromString(Ids);
        System.debug('fichas.size() '+ fichas.size());
        if(fichas.size()>0){
            
            //Asignar valores que no cambian en las fichas de pago
            hasta = refactorDate(fichas.get(0).Hasta__c);
            totalPagar = String.valueOf(fichas.get(0).TotaPagar__c);
            nota1 = fichas.get(0).Notas1__c;
            concept = fichas.get(0).Concepto__c;
           //fechaCreacion = System.now();
           fechaCreacion =fichas.get(0).CreatedDate;
           fecha=fechaCreacion.format('dd/MM/yyyy HH:mm:ss') ;
    
            
            //Asignar plantel obtenido de la base de datos
            Plantel__c plantelObj= [SELECT Id,Name,Instituto__c  FROM Plantel__c WHERE Id=:fichas.get(0).Plantel__c];
            Instituto__c ns = [SELECT Id,Name FROM Instituto__c WHERE Id=:plantelObj.Instituto__c ];
           	System.debug(fichas.get(0));
            encabezado=GetResourceURL(fichas.get(0).Plantel__r.Instituto__r.Encabezado__c); 
            System.debug(encabezado);
            
            
            
            if(plantelObj.Name.length()>0){
                plantel=plantelObj.Name;
            }
          
            //Obtener los Programas Relacionados a la ficha y asginagnarlos a una lista de strings 
            List<Programa__c> programasR= getProgramasRelacionados(fichas.get(0).ProgramasRelacionados__c);
            for(Programa__c  prog:  programasR ){
                programas.add(prog.Name+'<br/>');
            }
        }
        
        
    }
    
	@future(callout=true)
	public static void sendMail(String ids  ){
        
        String hostName = String.valueOf(URL.getSalesforceBaseUrl().getHost());
        List<String> server = hostName.split('\\.');
		String urlB ='';
        if ( ValidaEntorno.isSandbox()) {      
  			urlB = 'https://sandbox-ieu.cs2.force.com/apex/BarCodeMovil?ids='+ids;
        } else { 
        	//urlB = 'https://c.' + server[0] + '.visual.force.com/apex/BarCodeMovil?ids='+ids;
        	urlB = 'http://ieu.force.com/apex/BarCodeMovil?ids='+ids;
        }
        urlB = Negocio__c.getOrgDefaults().urlSite__c + '/apex/BarCodeMovil?ids='+ids;
        
        PageReference pdf = new PageReference(urlB);
        System.debug(urlB);
     
        String userName = UserInfo.getUserName();
       	User activeUser = [Select Email From User where Username = : userName limit 1];
	 	String userEmail = activeUser.Email;
	 
        
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
		Blob body;
		try {
			body = pdf.getContent();
		} catch (VisualforceException e) {
			body = Blob.valueOf('Some Text');
		}
		
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType('application/pdf');
        attach.setFileName('Ficha de pago.pdf');
        
        attach.Body = body;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] { userEmail });
        mail.setSubject('PDF Generation');
        
        /*Implementación cuerpo del mail*/
        List<FichaPago__c> listFichas = new List<FichaPago__c>();
        String numFichas = '';
        String strProgramas = '';
        String strPlantel = '';
        String strperiodo = '';
        
        listFichas = getFichasFromString(Ids);
        if(listFichas.size()>0){
            numFichas = String.valueOf(listFichas.size());
            List<Programa__c> programasR = getProgramasRelacionados(listFichas.get(0).ProgramasRelacionados__c);
            strProgramas = '<ul>';  
            for(Programa__c  prog:  programasR ){
                strProgramas += '<li>' + prog.Name + '</li>';
            }
            strProgramas += '</ul>';
            Plantel__c plantelObj = [SELECT Id,Name,Instituto__c  FROM Plantel__c WHERE Id=:listFichas.get(0).Plantel__c];
            
            if(plantelObj.Name.length()>0){
                strPlantel = plantelObj.Name;
            }
            strperiodo = listFichas.get(0).Periodo__r.Name;
        }
        String urlHost = String.valueOf(URL.getSalesforceBaseUrl().getHost());
        try{
            Document doc = [SELECT Id, Name FROM Document WHERE Name = 'Nuevo Logo IEU'];
            
            String idImage = String.valueOf(doc.Id);
            String idOrg = UserInfo.getOrganizationId();            
            String cuerpoEmail = '<html><body><img src="https://'+urlHost+'/servlet/servlet.ImageServer?id='+idImage+'&oid='+idOrg+'"/><div style="margin-top:-3px;background-color:#FF6600;height:5px;width:100%;display:block;"></div><br><div>Fichas de Pago.</div>' 
                + '<div style="margin-left:2%">Se han enviado las fichas de pago correspondiente a la solicitud: </div><div><ul><li> Número de fichas: ' + numFichas 
                + '</li><li> Periodo: '+ strperiodo + '</li><li> Plantel: '+ strPlantel + '</li><li> Programas: '+ strProgramas + '</li></ul><div><br/><div>Saludos</div><br><div style="background-color:#FF6600;height:5px;width:100%;display: block;"></div></body></html>';
            mail.setHtmlBody(cuerpoEmail);
            
            
            // mail.setHtmlBody('PFA');
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });
            mails.add(mail);  
            if(!mails.isEmpty())
            {
                Messaging.SendEmail(mails);
            }
        }catch(Exception e){
            System.debug('Error al cargar logo: ' +e.getMessage());
        }
	}

    public static String encodeASCII(String cadena){
        return EncodingUtil.urlEncode(cadena, 'ASCII');
    }
    
  	/**
    * @author:      Gerardo Martínez
    * @date:        05/08/2016
    * @description: Reorganiza una fecha en el formato del cliente.  
    * @param:       Date
    * @return:      String
    */
 
    public static String refactorDate(Date dateToCast){
        String myDate = string.valueOfGmt(dateToCast);
        String[] myDateOnly = myDate.split(' ');
        String[] strDate = myDateOnly[0].split('-');
        Integer myIntMonth = integer.valueOf(strDate[1]);
        Integer myIntYear = integer.valueOf(strDate[0]);
        Integer myIntDate = integer.valueOf(strDate[2]);
        return  myIntDate +'-'+myIntMonth+'-'+myIntYear;
        
      
    }
    
  	/**
    * @author:      Gerardo Martínez
    * @date:        05/08/2016
    * @description: Regresa una lista de objetos FichaPago__c de un string de Ids, separados por un guion.  
    * @param:       String
    * @return:      List<FichaPago__c>
    */
    
    public static List<FichaPago__c> getFichasFromString(String Ids){
       List<FichaPago__c> results = new List<FichaPago__c>();
           System.debug('getFichasFromString ---> '+ Ids);
        if(Ids.length()>0 && !Ids.equals('')){
            System.debug('entra a if '+ Ids);
       		List<String> listOfIds = Ids.split('-');
     
            for(String s: listOfIds ){
                results.add([SELECT Id, Name, Notas1__c, Periodo__r.Name, Notas2__c, Hasta__c, Importe__c, Plantel__c, Plantel__r.Instituto__r.Encabezado__c,
                             Descuento__c, TotaPagar__c, ReferenciaOXXO__c, ReferenciaHSBC__c, Concepto__c, ProgramasRelacionados__c, CreatedDate
                             FROM FichaPago__c WHERE Id=:s LIMIT 1]);
            }   
        }
         //  System.debug('No entra a if '+ Ids);
        return results;
    }
    
    /**
    * @author:      Gerardo Martínez
    * @date:        05/08/2016
    * @description: Regresa una lista de objetos Programa__C de un string de Ids, separados por una coma.  
    * @param:       String
    * @return:      List<Programa__c>
    */
    
    public static List<Programa__c> getProgramasRelacionados(String Ids){
         List<Programa__c> results = new List<Programa__c>();
        System.debug('id--> '+Ids);
         if(Ids.length()>0 && !Ids.equals('') ){
            
       		List<String> listOfIds = Ids.split(',');
     
            for(String s: listOfIds ){
                results.add([SELECT Id, Name FROM Programa__c WHERE Id=:s LIMIT 1]);
            }   
        }
        return results;
    }
    
        /**
    * @author:      Gerardo Martínez
    * @date:        07/08/2016
    * @description: Regresa el url de un recurso estático.  
    * @param:       String
    * @return:      String
    */
    
    public static String GetResourceURL(String resourceName){

            // Fetching the resource
            List<StaticResource> resourceList= [SELECT Name, NamespacePrefix, SystemModStamp FROM StaticResource WHERE Name = :resourceName];

            // Checking if the result is returned or not
            if(resourceList.size() == 1){

               // Getting namespace
               String namespace = resourceList[0].NamespacePrefix;
               // Resource URL
               return '/resource/' + resourceList[0].SystemModStamp.getTime() + '/' + (namespace != null && namespace != '' ? namespace + '__' : '') + resourceName; 
            }
            else return '';
        }
    

}