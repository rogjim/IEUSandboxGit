global with sharing class DES_DescuentoIframeCtrl {
    global DES_DescuentoIframeCtrl(ApexPages.StandardController std){
        
    }
    global DES_DescuentoIframeCtrl(){
        
    }    
    @RemoteAction
    global static List<sObject> query(String query) {
        return Database.query(query);
    }
    
    @RemoteAction
    global static Schema.DescribeSobjectResult[] describe(String[] objs) {
        
        return Schema.describeSObjects(objs);
    }
    
    @RemoteAction
    global static List<Database.DeleteResult> deleteIds(String[] ids) {
        return Database.delete(ids);
    }
    
    @RemoteAction
    global static List<Database.UpsertResult> upsertObjects(String objType, String jsonString) {
        Type t = Type.forName('List<'+objType+'>');
        List<sObject> instances = (List<sObject>) JSON.deserialize(jsonString, t);
        System.debug(instances);
        return Database.upsert(instances);
    }
}