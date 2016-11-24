/*
Class to find Salesforce Id for a specific custom object
*/
public class DescribeCustomObject {
    
    
    // Pattern to be searched
    private static final Pattern OBJECT_PATTERN = Pattern.compile('<a href="/(\\w*)\\?setupid=CustomObjects">(.+?)</a>');
    private static final String CUSTOM_OBJECT_PAGE_URL = '/p/setup/custent/CustomObjectsPage?setupid=CustomObjects';
    
    // Method to get the Custom Object Id
    public static String getCustomObjectId(String custObjName) {
        // Check the parameter
        if(custObjName == null || custObjName == '') {
            return null;
        }
        // find out all listed custom object Ids
        map<String, String> mapCustObjectIds = findObjectIds();
        
        String customObjectId = mapCustObjectIds.get(custObjName);
        
        // Find custom object Id
        return customObjectId;
        
    }
    
    // Method to get the content and prepare map of Custom object with its Salesforce Id
    private static map<String, String> findObjectIds() {
        // PageReference instance. NOTE: the URL is standard and does not supposed to be change between different orgs
        Pagereference pr = new PageReference(CUSTOM_OBJECT_PAGE_URL);
        
        
        // Get the Page content and store as String
        String htmlContent = pr.getContent().toString();
        
        // Matcher for the defined pattern
        Matcher match = OBJECT_PATTERN.matcher(htmlContent);
        
        // Map to store Object Name with its Salesforce ID 
        map<String, String> mapObjectIds = new map<String, String>();
        // Iterate the matcher and find out the specified pattern
        while(match.find()) {
            // If matched, Add the custom object and Id to the map
            
            if(match.group(2) != null && match.group(1) != null){
                mapObjectIds.put(match.group(2), match.group(1));
            }
        } 
        
        // Return map of Object Ids
        return mapObjectIds;
    }
    
    
    public static String getdemo(String custObjName) {
        
        
        
        
        String objectName = custObjName;
        
        String query = 'SELECT Id From CustomObject Where DeveloperName = \'' + objectName + '\'';
        String endpoint = Url.getSalesforceBaseUrl().toExternalForm();
        endpoint += '/services/data/v29.0/tooling/query/?q=';
        endpoint += EncodingUtil.urlEncode(query, 'UTF-8');
        
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
        request.setEndpoint(endpoint);
        
        HttpResponse response = new Http().send(request);
        Id customObjectId = response.getBody().substringAfter('"Id":"').substringBefore('"');
        
        //eg '01Id0000001BSeoEAG'
        System.debug(customObjectId);
        
        return customObjectId;
    }
    
}