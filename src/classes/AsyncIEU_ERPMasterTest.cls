@isTest  public class AsyncIEU_ERPMasterTest {

    @IsTest   public static void saveToken(){
        
     //   Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator()); 
        // Call method to test. 
        // This causes a fake response to be sent 
        // from the class that implements HttpCalloutMock.  
        //HttpResponse res = CalloutClass.getInfoFromExternalService(); 
        //Blob body = !Test.isRunningTest() ? pdf.getContent() : Blob.ValueOf('dummy text');
        
    /*    AsyncIEU_ERPMaster.AddPagosGrupoInfoResponse_elementFuture obj1 = new AsyncIEU_ERPMaster.AddPagosGrupoInfoResponse_elementFuture();
        
        AsyncIEU_ERPMaster.AddPagosInscripcionInfoResponse_elementFuture obj2 = new AsyncIEU_ERPMaster.AddPagosInscripcionInfoResponse_elementFuture();
        
        AsyncIEU_ERPMaster.AddCandidatoInfoResponse_elementFuture obj3 = new AsyncIEU_ERPMaster.AddCandidatoInfoResponse_elementFuture();
        
        AsyncIEU_ERPMaster.HolaResponse_elementFuture obj4 = new AsyncIEU_ERPMaster.HolaResponse_elementFuture();
        
        AsyncIEU_ERPMaster.AddGrupoInfoResponse_elementFuture obj5 = new AsyncIEU_ERPMaster.AddGrupoInfoResponse_elementFuture();
        
        AsyncIEU_ERPMaster.AddBecasInfoResponse_elementFuture obj6 = new AsyncIEU_ERPMaster.AddBecasInfoResponse_elementFuture();
        
        
        
        obj1.getValue();
        obj2.getValue();
        obj3.getValue();
        obj4.getValue();
        obj5.getValue();
        obj6.getValue();
        AsyncIEU_ERPMaster.AsyncserviceSoap ob = new AsyncIEU_ERPMaster.AsyncserviceSoap();
        
        ob.beginAddPagosGrupoInfo(continuation, usuario, pwd, PagosGrupoInfo)
        
     */
          
 
        // This causes a fake response to be generated
 Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
 
        // Call the method that invokes a callout
 
     //   String output = AsyncIEU_ERPMaster.AddBecasInfoResponse_elementFuture();


      
 
        // Verify that a fake result is returned
 
       // System.assertEquals('Mock response', output);

/*  
   HttpResponse res = AsyncIEU_ERPMaster       obj.getValue();
    */    
        // Verify response received contains fake values 
  /*    String contentType = res.getHeader('Content-Type'); 
        System.assert(contentType == 'application/json'); 
        String actualValue = res.getBody(); 
        String expectedValue = '{"foo":"bar"}'; 
        System.assertEquals(actualValue, expectedValue); 
        System.assertEquals(200, res.getStatusCode()); 
        */
         //new AsyncIEU_ERPMaster.AddPagosGrupoInfoResponse_elementFuture().getValue();
         
         
    }
}