public without sharing class SandRHelper {
    public SandRHelper() {

    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList() {
        return [SELECT Id, Name, Type, Rating,
                Phone, Website, AnnualRevenue
            FROM Account];
    }

    @AuraEnabled(cacheable=true)
    public static List<Job__c> getProjectJobDetails(Id projectId) {

        System.debug('projectId::'+projectId);
        return [SELECT Id,Name,Project__c,Project__r.Name,Received_By__c,Received_By__r.Name,Send_By__c,Send_By__r.Name,
        Status__c,Transfer_From__c,Transfer_Received_By__c,Transfer_Received_By__r.Name,Transfer_To__c,Job_Type__c
            FROM Job__c where Project__c =:projectId ];
    }

    @AuraEnabled
    public static void insertAccounts(String jsonOfListOfAccounts) {
        try{
           
            system.debug('jsonOfListOfAccounts:'+jsonOfListOfAccounts);
           List<Item__c> listOfAccounts = (List<Item__c>) JSON.deserialize(jsonOfListOfAccounts, List<Item__c>.class);
           for(Item__c item : listOfAccounts){
            system.debug('item::'+item);
           }
            upsert listOfAccounts;
            
        } catch(DmlException e){
            
             System.debug('The following exception has occurred: ' + e.getMessage());
        }
        
    }

    @AuraEnabled(cacheable=true)
    public static List<Item__c> fetchJobLineItems(Id jobId){
        List<Item__c> itemListTobeReturn = New List<Item__c>();
        try {
            itemListTobeReturn = [select Id,createddate,Index__c,Date_In__c,Description__c,Type__c,Model__c,Serial__c,Sample_Accessory__c,Date_Out__c,Transfer_Notes__c from Item__c where Job__c =: jobId order by createddate asc];
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return itemListTobeReturn;
    }

    @AuraEnabled
    public static string deleteJobLineItem(String jobListString){
        try {
            List<Item__c> jobList = (List<Item__c>) JSON.deserialize(jobListString, List<Item__c>.class);
            delete jobList;
            return 'success';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static job__c validateCustomerReceivedRecord(String projectId){
        try {
            return [select id from job__c where recordtypeId =: Constant.CUSTOMER_RECEIVED_ID];
        } catch (Exception e) {
            //throw new AuraHandledException(e.getMessage());
            return null;
        }
    }
    
     @AuraEnabled(cacheable=True)
    Public Static List<Job__c> FetchProjectId(String JobId){
        
        Job__c JobList=[Select Id,Project__c From Job__c Where id =: JobId ];
        system.debug('JobList='+JobList);
        
        string ProjectId=JobList.Project__c;
        
        List<Job__c> jobs=[Select Id, Name, Transfer_From__c,Transfer_To__c, Project__r.Name From Job__c Where Project__c =: ProjectId AND Id!=:JobId];
        system.debug('jobs='+jobs);
        
        return jobs;
        
    }
    
    @AuraEnabled(Cacheable=True)
    Public Static List<Item__c> JobItems(String JobsId){
        
        list<Item__c> ItemRec=[Select Id,createddate,Index__c,Date_In__c,Description__c,Type__c,Model__c,Serial__c,Sample_Accessory__c,Date_Out__c,Transfer_Notes__c from Item__c where Job__c=:JobsId ];
        system.debug('ItemRec='+ItemRec);
        
        return ItemRec;
        
    }
    
}