public without sharing class JobTriggerHelper {
    public JobTriggerHelper() {

    }

    /*public static void assignJobRecordType(List<Job__c> newJobList){
        for(Job__C newJob : newJobList){
            system.debug('newJob.RecordTypeId::'+newJob.RecordTypeId);
            if(newJob.RecordTypeId == Constant.CUSTOMER_RECEIVED_ID){
                newJob.Job_Type__c = Constant.CUSTOMER_JOB_TYPE;
            }
            if(newJob.RecordTypeId == Constant.FINAL_RETURN_ID){
                newJob.Job_Type__c = Constant.RETURN_JOB_TYPE;
                
            }
            if(newJob.RecordTypeId == Constant.LAB_TRANSFER_ID){
                newJob.Job_Type__c = Constant.TRANSFER_JOB_TYPE;
                
            }
        }
    }*/
    
    public static void validateJobRecordtype(List<Job__c> newJobList){
        Set<Id> projectIdSet = new Set<Id>();
        for(Job__C newJob : newJobList){
            if(newJob.RecordTypeId == Constant.CUSTOMER_RECEIVED_ID){
                projectIdSet.add(newJob.Project__c);
            }
        }
        if(!projectIdSet.isEmpty()){
            List<Job__c> customerJobList = new List<Job__c>();
            customerJobList = [select id from job__c where RecordTypeId =: Constant.CUSTOMER_RECEIVED_ID and project__c in: projectIdSet ];
            
            if(!customerJobList.isEmpty()){
                Job__c jb = new Job__c();
                jb = customerJobList[0];
                newJobList[0].addError('You can not create duplicate customer received record in system!!!!');
            }
        }
    }
}