public with sharing class Constant {
    public static final string CUSTOMER_RECEIVED_ID    = Schema.SObjectType.Job__c.getRecordTypeInfosByName().get('Customer Received').getRecordTypeId();
    public static final string FINAL_RETURN_ID         = Schema.SObjectType.Job__c.getRecordTypeInfosByName().get('Final Return').getRecordTypeId();
    public static final string LAB_TRANSFER_ID         = Schema.SObjectType.Job__c.getRecordTypeInfosByName().get('Lab Transfer').getRecordTypeId();
    public static final string CUSTOMER_JOB_TYPE    = 'Customer Received';
    public static final string RETURN_JOB_TYPE      = 'Final Return';
    public static final string TRANSFER_JOB_TYPE    = 'Lab Transfer';
}