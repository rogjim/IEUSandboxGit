public with sharing class ComprobanteLeadCtrl {
    public String folio {get; set;}
    public String concepto {get; set;}
    public String autorizacion {get; set;}
    public String cantidad {get; set;}
    public String fecha  {get; set;} 
    public String encabezado {get; set;}
    public String nota2 {get; set;}
    public String hora {get; set;}
    
    public ComprobanteLeadCtrl(){ 
        Integer myIntDate = 9;
        folio = apexpages.currentpage().getparameters().get('folio');
        fecha =apexpages.currentpage().getparameters().get('fecha');
        concepto= apexpages.currentpage().getparameters().get('concepto');
        autorizacion = apexpages.currentpage().getparameters().get('autorizacion');
        cantidad = apexpages.currentpage().getparameters().get('cantidad');
        nota2 = apexpages.currentpage().getparameters().get('nota2');
        hora = apexpages.currentpage().getparameters().get('hora');
    } 
    
    @future(callout=true)
    public static void sendMailComprobante(String folioR, String concepto, String leadmail, String autorizacion, String cantidad ,String fecha, String nota2, String hora){
        //System.debug('entra a sendMailComprobante' + folioR + ' ' + concepto + ' ' + leadmail + ' ' + autorizacion + ' ' + cantidad + ' ' + fecha + ' ' + nota2 + ' ' + hora);
        String hostName = String.valueOf(URL.getSalesforceBaseUrl().getHost());
        List<String> server = hostName.split('\\.');
        
        String urlCT ='';
        if ( ValidaEntorno.isSandbox()) { 
            urlCT = 'https://c.' + server[0] + '.visual.force.com/apex/ComprobanteLead?folio='+ encodeASCII(folioR) ;
            //urlCT = 'https://c.cs2.visual.force.com/apex/ComprobanteLead?folio='+ encodeASCII(folioR) ;
            urlCT = urlCT +  '&concepto='+ encodeASCII(concepto); 
            urlCT = urlCT + '&autorizacion='+ encodeASCII(autorizacion) +'&cantidad='+ encodeASCII(cantidad)+'&fecha='+ encodeASCII(fecha) +'&nota2='+ encodeASCII(nota2) + '&hora=' + encodeASCII(hora); 
        } else { 
            urlCT = 'https://c.' + server[0] + '.visual.force.com/apex/ComprobanteLead?folio='+ encodeASCII(folioR) + '&concepto='+ encodeASCII(concepto); 
            //urlCT = 'https://c.cs2.visual.force.com/apex/ComprobanteLead?folio='+ encodeASCII(folioR) + '&concepto='+ encodeASCII(concepto); 
            urlCT = urlCT + '&autorizacion='+ encodeASCII(autorizacion) +'&cantidad='+ encodeASCII(cantidad)+'&fecha='+ encodeASCII(fecha) +'&nota2='+ encodeASCII(nota2) + '&hora=' + encodeASCII(hora) ;
        }
        System.debug('Comprobante urlCT-------- ' +urlCT);     
        
        PageReference pdf = new PageReference(urlCT); 
        
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Blob body;
        try {
            
           body = pdf.getContent();
            //    body = pdf.getContentAsPDF();
        } catch (VisualforceException e) {
            body = Blob.valueOf('Some Text');
        }
        
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType('application/pdf');
        attach.setFileName('Comprobante de Pago.pdf');
        
        attach.Body = body;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] { leadmail });
        mail.setSubject('Comprobante de Pago');
        mail.setHtmlBody('Comporbante de Pago');
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });
        mails.add(mail);  
        if(!mails.isEmpty())
        {
            Messaging.SendEmail(mails);
        }   
    }
    
    public static String encodeASCII(String cadena){
        return EncodingUtil.urlEncode(cadena, 'UTF-8');
    }
}