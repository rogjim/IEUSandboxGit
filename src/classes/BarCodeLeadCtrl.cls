public with sharing class BarCodeLeadCtrl {
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
    
    
    public BarCodeLeadCtrl(){
        String myDate = apexpages.currentpage().getparameters().get('Hasta');
        String[] myDateOnly = myDate.split(' ');
        String[] strDate = myDateOnly[0].split('-');
        Integer myIntMonth = integer.valueOf(strDate[1]);
        Integer myIntYear = integer.valueOf(strDate[0]);
        Integer myIntDate = integer.valueOf(strDate[2]);
        hasta = myIntDate +'-'+myIntMonth+'-'+myIntYear;
        recibimosde = apexpages.currentpage().getparameters().get('recibimosde');
		pago = apexpages.currentpage().getparameters().get('pago');
        nota1 = apexpages.currentpage().getparameters().get('Nota1');
		nota2 = apexpages.currentpage().getparameters().get('Nota2');
        folio = apexpages.currentpage().getparameters().get('folio');
        HSBCRef = apexpages.currentpage().getparameters().get('HSBC');
        cadenaCodigo = apexpages.currentpage().getparameters().get('Oxxo');
        concept = apexpages.currentpage().getparameters().get('Concepto');
        encabezado = apexpages.currentpage().getparameters().get('encabezado');
        numServicio = apexpages.currentpage().getparameters().get('numServicio');
    }
    
	@future(callout=true)
	public static void sendMail(Date hasta, String nota1, String nota2, String concepto, String leadmail,String recibimosde, String folioR, String pagoR, String refHSBC, String refOXXO, String encabezado, String numSer, String emailOwner){
      
    	String hostName = String.valueOf(URL.getSalesforceBaseUrl().getHost());
        List<String> server = hostName.split('\\.');
    	
        
        String urlE ='';
        if ( ValidaEntorno.isSandbox()) { 
        urlE = Negocio__c.getOrgDefaults().urlSite__c + '/apex/BarCodeLead?recibimosde='+ encodeASCII(recibimosde) + '&pago='+ encodeASCII(pagoR); 
        urlE = urlE + '&folio='+ encodeASCII(folioR) +'&HSBC='+ encodeASCII(refHSBC) +'&Oxxo='+ encodeASCII(refOXXO);
        urlE = urlE + '&Concepto=' + encodeASCII(concepto) + '&Nota1=' + encodeASCII(nota1) +'&Nota2=' + encodeASCII(nota2) + '&Hasta=' + encodeASCII(String.valueOf(hasta));
		urlE = urlE + '&encabezado=' + encodeASCII(encabezado) + '&numServicio=' + encodeASCII(numSer);        
  
        } else { 
            urlE = Negocio__c.getOrgDefaults().urlSite__c + '/apex/BarCodeLead?recibimosde='+ encodeASCII(recibimosde) + '&pago='+ encodeASCII(pagoR); 
        urlE = urlE + '&folio='+ encodeASCII(folioR) +'&HSBC='+ encodeASCII(refHSBC) +'&Oxxo='+ encodeASCII(refOXXO);
        urlE = urlE + '&Concepto=' + encodeASCII(concepto) + '&Nota1=' + encodeASCII(nota1) +'&Nota2=' + encodeASCII(nota2) + '&Hasta=' + encodeASCII(String.valueOf(hasta));
		urlE = urlE + '&encabezado=' + encodeASCII(encabezado) + '&numServicio=' + encodeASCII(numSer);       
        }
        PageReference pdf = new PageReference(urlE);
		//System.debug('/apex/BarCodeLead?recibimosde='+recibimosde+'&pago='+pagoR+'&folio='+folioR+'&HSBC='+refHSBC+'&Oxxo='+refOXXO+'&Concepto='+concepto+'&Nota1='+nota1+'&Nota2='+nota2+'&Hasta='+hasta);
		System.debug(urlE);
		//UtilsLog.createLogOK('BarCodeLead.sendMail URLE', urlE);
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
		Blob body;
		try {
			//body = pdf.getContent();
			body = pdf.getContentAsPDF();
		} catch (VisualforceException e) {
			body = Blob.valueOf('Some Text');
		}
		
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType('application/pdf');
        attach.setFileName('Ficha de pago.pdf');
        attach.Body = body;
        
        Id templateId; 
        //try {
           // templateId = [SELECT Id, name FROM EmailTemplate WHERE name = 'Plantilla Promotor Asignado'].id;
        //}catch (Exception e) {
            //System.debug('Mensaje error plantilla: ' +e.getMessage());
        //}

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String vigencia = hasta.format();
        String asunto = 'Ficha de pago ' + recibimosde; 
        String urlHost = String.valueOf(URL.getSalesforceBaseUrl().getHost());
        
        try{
            Negocio__c negocio = Negocio__c.getOrgDefaults();
            OrgWideEmailAddress[] owea = [select Id,DisplayName from OrgWideEmailAddress where DisplayName =: negocio.DisplayName__c];
            if ( owea.size() > 0 ) {
                mail.setOrgWideEmailAddressId(owea.get(0).Id);
            }
        }catch(Exception e){
            
        }
        
        try{
            Document doc = [SELECT Id, Name FROM Document WHERE Name = 'Nuevo Logo IEU'];
            String idImage = String.valueOf(doc.Id);
            String idOrg = UserInfo.getOrganizationId();
            //String urlLogo = 
            //String cuerpoEmail = '<html><body><img src="{!$Resource.LogoIEU}"/><div style="background-color:#FF6600;height:5px;width:100%;"></div><br/><br/><div>' + recibimosde + '</div></body></html>';
            String cuerpoEmail = '<html><body><img src="https://'+urlHost+'/servlet/servlet.ImageServer?id='+idImage+'&oid='+idOrg+'"/><div style="margin-top:-3px;background-color:#FF6600;height:5px;width:100%;display:block;"></div><br><div>Gracias por tu interés.</div><div style="margin-left:2%">' 
                + recibimosde + '</div><br/><div style="margin-left:2%">Te hemos enviado la ficha de pago correspondiente a tu solicitud: </div><div><ul><li> Monto: $' + pagoR 
                + '</li><li> Vigencia: '+ vigencia + '</li></ul><div><br/><div>Estaremos en contacto contigo</div><br><div style="background-color:#FF6600;height:5px;width:100%;display: block;"></div></body></html>';
            mail.setToAddresses(new String[] { leadmail });
            mail.setReplyTo(emailOwner);
            mail.setSubject(asunto);
            mail.setHtmlBody(cuerpoEmail);
            //mail.setTemplateId(templateId);
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });
            mails.add(mail);  
            if(!mails.isEmpty())
            {
                Messaging.SendEmail(mails);
            }
        }catch(Exception e){
           System.debug('Error al cargar logo: ' +e.getMessage());
        }
        
        //https://c.cs2.content.force.com/servlet/servlet.ImageServer?id=015R0000000GzkN&oid=00DR0000001yhEY&lastMod=1470068689000
	}

    public static String encodeASCII(String cadena){
        if(cadena!=null){
            return EncodingUtil.urlEncode(cadena, 'UTF-8');
        }
        else{
            return '';
        } 
    }
}