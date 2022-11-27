public class EmailMessageTriggerHelper {
    
    public static void updateRelatesRecordID(List<EmailMessage> emailMessageList){
        system.debug('Who id is '+ emailMessageList[0]);
        List<String> whoIds = new List<String>();
        List<String> whatIds = new List<String>();
        String activityId = '';
        map<String,String> activityIdByEmailMessage = new map<String,String>();
        map<String,String> emailMessageIdByEmailMessage = new map<String,String>();
        String MessageIdentifier = '';
        for(EmailMessage em : emailMessageList){
            system.debug('em - Bcc address'+em.CcAddress);
            activityIdByEmailMessage.put(em.Id,em.ActivityId);  
            MessageIdentifier = em.MessageIdentifier;
            //emailMessageIdByEmailMessage.put(em.Id,em.MessageIdentifier);
        }
        system.debug('Who id is '+ MessageIdentifier);
        List<Task> activityData = [Select id , WhoId ,whatId from Task where id in : activityIdByEmailMessage.values()]  ;
        for(Task tk  : activityData){
            whoIds.add(tk.WhoId);
            whatIds.add(tk.WhatId);
            
        }
        system.debug('Who id is '+ whoIds);
        system.debug('Who id is '+ whatIds);
        List<Project__c> leadList = [Select Id,Email_Message_Id__c from Project__c where id in : whatIds];
        
        for(Project__c ld : leadList){
            ld.Last_Email_Sent__c = system.now();
            ld.Email_Message_Id__c = MessageIdentifier;
        }
        system.debug('leadList'+leadList);
        update leadList;
        system.debug('leadList'+leadList);
    }
    public static void setDefaultFields(List<EmailMessage> emailMessageList){
        for(EmailMessage em : emailMessageList){
            //em.
            em.BccAddress = 'salesforceemail@2ie4lte9u5gde1483db93nhqf5o8xc5dj2l3bjxjfpywwh1o2d.8b-4fdduay.cs215.apex.sandbox.salesforce.com'; 
            em.CcAddress = 'salesforceemail@2ie4lte9u5gde1483db93nhqf5o8xc5dj2l3bjxjfpywwh1o2d.8b-4fdduay.cs215.apex.sandbox.salesforce.com';
        }
        system.debug('Coming Here'+emailMessageList[0].BccAddress);
    }
}