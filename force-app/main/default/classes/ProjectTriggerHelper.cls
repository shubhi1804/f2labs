public class ProjectTriggerHelper {
    
    private static ProjectTriggerHelper newObj = null;
    
    private ProjectTriggerHelper() {}
    
    public static ProjectTriggerHelper getInstance() {
        if(newObj == null) {
            newObj = new ProjectTriggerHelper();
        }
        return newObj;
    }
    
    public void onBeforeInsert(List<Project__c> newList) {
        ProjectTriggerHelperService.getProjectRecord(newList);
        ProjectTriggerHelperService.mapValuesFromOppOnInsert(newList);
    }
    
    
    public static void sendEmailAlert(List<Project__c> projects, Map<Id, Project__c>newMap, Map<Id, Project__c> oldMap){
        //custom setting for email
        Accounting_Group_Emails__c age = [select name , email__c from Accounting_Group_Emails__c];
        String Body = '';
        List<String> Accids = new List<String>();
        List<EmailTemplate> etList=[Select id, Name, Subject, Body from EmailTemplate];
        map<String,String> accnameByAccId = new map<String,String>();
        map<String,EmailTemplate> emailtemplatesBycondiditon = new map<String,EmailTemplate>();
        
        for(Project__c prj : projects){
            Accids.add(prj.Account__c);
        }
        List<Account> AccList = [Select id, name from account where id in : Accids];
        for(Account acc : AccList){
            accnameByAccId.put(acc.Id,acc.name);
        }
        
        for(EmailTemplate et : etList){
            if(et.Name == 'Project Cancellation Mail to AccGroup'){
                emailtemplatesBycondiditon.put('cancelledTemplate',et);
                
            }else if(et.Name == 'EMC Pending to AccGroup'){
                emailtemplatesBycondiditon.put('emcTemplate',et);
                
            }else if(et.Name == 'Environmental Status Payment Pending to AccGroup'){
                emailtemplatesBycondiditon.put('envtTemplate',et);
                
            }else if(et.Name == 'EU Services Payment Pending to AccGroup'){
                emailtemplatesBycondiditon.put('euTemplate',et);
                
            }else if(et.Name == 'Hazloc Status Payment Pending to AccGroup'){
                emailtemplatesBycondiditon.put('hazlocTemplate',et);
                
            }else if(et.Name == 'Radio Status Payment Pending to AccGroup'){
                emailtemplatesBycondiditon.put('radioTemplate',et);
                
            }else if(et.Name == '	Safety Status Payment Pending to AccGroup'){
                emailtemplatesBycondiditon.put('safetystatusTemplate',et);
                
            }else if(et.Name == 'Safety Subs Status Payment Pending to AccGroup'){
                emailtemplatesBycondiditon.put('safetysubTemplate',et);
                
            }else if(et.Name == 'TF Payment Pending to AccGroup'){
                emailtemplatesBycondiditon.put('tfpaymentTemplate',et);
                
            }else if(et.Name == 'TF Status In Progress to AccGroup'){ 
                emailtemplatesBycondiditon.put('tfstatusTemplate',et);
            }
            system.debug('emailtemplatesBycondiditon'+emailtemplatesBycondiditon);
        }
        for(Project__c proj : projects){
            if((newMap.get(proj.id).Project_Status__c != oldMap.get(proj.id).Project_Status__c) && proj.Project_Status__c == 'Cancelled' ){
                Body = emailtemplatesBycondiditon.get('cancelledTemplate').Body;
                Body = Body.replace('{!Project__c.Name}',proj.Name);
                Body = Body.replace('{!Project__c.Account__c}',accnameByAccId.get(proj.Account__c));
                system.debug('Body'+Body);
                sendEmailTemplate(emailtemplatesBycondiditon.get('cancelledTemplate').Subject,Body,age.email__c,proj.Id);
            }
            else if((newMap.get(proj.id).EMC_Status__c != oldMap.get(proj.id).EMC_Status__c) && proj.EMC_Status__c == 'Payment Pending'){
                Body = emailtemplatesBycondiditon.get('cancelledTemplate').Body;
                Body = Body.replace('{!Project__c.Name}',proj.Name);
                Body = Body.replace('{!Project__c.Account__c}',accnameByAccId.get(proj.Account__c));
                system.debug('Body'+Body);
                sendEmailTemplate(emailtemplatesBycondiditon.get('emcTemplate').Subject,Body,age.email__c,proj.Id);
            }
            else if((newMap.get(proj.id).Radio_Status__c != oldMap.get(proj.id).Radio_Status__c) && proj.Radio_Status__c == 'Payment Pending'){
                Body = emailtemplatesBycondiditon.get('cancelledTemplate').Body;
                Body = Body.replace('{!Project__c.Name}',proj.Name);
                Body = Body.replace('{!Project__c.Account__c}',accnameByAccId.get(proj.Account__c));
                system.debug('Body'+Body);
                sendEmailTemplate(emailtemplatesBycondiditon.get('radioTemplate').Subject,Body,age.email__c,proj.Id);
            }
            else if((newMap.get(proj.id).Safety_Status__c != oldMap.get(proj.id).Safety_Status__c) && proj.Safety_Status__c == 'Payment Pending'){
                Body = emailtemplatesBycondiditon.get('cancelledTemplate').Body;
                Body = Body.replace('{!Project__c.Name}',proj.Name);
                Body = Body.replace('{!Project__c.Account__c}',accnameByAccId.get(proj.Account__c));
                system.debug('Body'+Body);
                sendEmailTemplate(emailtemplatesBycondiditon.get('safetystatusTemplate').Subject,Body,age.email__c,proj.Id);
            }
            else if((newMap.get(proj.id).Environmental_Status__c != oldMap.get(proj.id).Environmental_Status__c) && proj.Environmental_Status__c == 'Payment Pending'){
                Body = emailtemplatesBycondiditon.get('cancelledTemplate').Body;
                Body = Body.replace('{!Project__c.Name}',proj.Name);
                Body = Body.replace('{!Project__c.Account__c}',accnameByAccId.get(proj.Account__c));
                system.debug('Body'+Body);
                sendEmailTemplate(emailtemplatesBycondiditon.get('envtTemplate').Subject,Body,age.email__c,proj.Id);
            }
            else if((newMap.get(proj.id).Hazloc_Status__c != oldMap.get(proj.id).Hazloc_Status__c) && proj.Hazloc_Status__c == 'Payment Pending'){
                Body = emailtemplatesBycondiditon.get('cancelledTemplate').Body;
                Body = Body.replace('{!Project__c.Name}',proj.Name);
                Body = Body.replace('{!Project__c.Account__c}',accnameByAccId.get(proj.Account__c));
                system.debug('Body'+Body);
                sendEmailTemplate(emailtemplatesBycondiditon.get('hazlocTemplate').Subject,Body,age.email__c,proj.Id);
            }
            else if((newMap.get(proj.id).Tech_File_Status__c != oldMap.get(proj.id).Tech_File_Status__c) && proj.Tech_File_Status__c == 'TF In Progress' && proj.TF_Paid__c == 'No'){
                Body = emailtemplatesBycondiditon.get('cancelledTemplate').Body;
                Body = Body.replace('{!Project__c.Name}',proj.Name);
                Body = Body.replace('{!Project__c.Account__c}',accnameByAccId.get(proj.Account__c));
                system.debug('Body'+Body);
                sendEmailTemplate(emailtemplatesBycondiditon.get('tfstatusTemplate').Subject,Body,age.email__c,proj.Id);
            }
            else if((newMap.get(proj.id).Tech_File_Status__c != oldMap.get(proj.id).Tech_File_Status__c) && proj.Tech_File_Status__c == 'TF Payment Pending'){
                Body = emailtemplatesBycondiditon.get('cancelledTemplate').Body;
                Body = Body.replace('{!Project__c.Name}',proj.Name);
                Body = Body.replace('{!Project__c.Account__c}',accnameByAccId.get(proj.Account__c));
                system.debug('Body'+Body);
                sendEmailTemplate(emailtemplatesBycondiditon.get('tfpaymentTemplate').Subject,Body,age.email__c,proj.Id);
            }
            else if((newMap.get(proj.id).EU_Services_Status__c != oldMap.get(proj.id).EU_Services_Status__c) && proj.EU_Services_Status__c == 'Payment Pending'){
                Body = emailtemplatesBycondiditon.get('cancelledTemplate').Body;
                Body = Body.replace('{!Project__c.Name}',proj.Name);
                Body = Body.replace('{!Project__c.Account__c}',accnameByAccId.get(proj.Account__c));
                system.debug('Body'+Body);
                sendEmailTemplate(emailtemplatesBycondiditon.get('euTemplate').Subject,Body,age.email__c,proj.Id);
            }
            else if((newMap.get(proj.id).Safety_Subs_Status__c != oldMap.get(proj.id).Safety_Subs_Status__c) && proj.Safety_Subs_Status__c == 'Payment Pending'){
                Body = emailtemplatesBycondiditon.get('cancelledTemplate').Body;
                Body = Body.replace('{!Project__c.Name}',proj.Name);
                Body = Body.replace('{!Project__c.Account__c}',accnameByAccId.get(proj.Account__c));
                system.debug('Body'+Body);
                sendEmailTemplate(emailtemplatesBycondiditon.get('safetysubTemplate').Subject,Body,age.email__c,proj.Id);
            }  
        }
    }
    
    public static void sendEmailTemplate (String subject, String body, string emailId,String recId){
        
        
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        //mail.setWhatId(recId);
        List<String> sendTo = new List<String>();
        sendTo.add(emailId);
        mail.setToAddresses(sendTo);
        mail.setSubject(subject);
        mail.setHtmlBody(body);
        mails.add(mail);
        Messaging.sendEmail(mails);
        //mail.setReplyTo('sirdavid@bankofnigeria.com');
        //mail.setSenderDisplayName('Official Bank of Nigeria');
        // List<String> ccTo = new List<String>();
        //ccTo.add('business@bankofnigeria.com');
        //mail.setCcAddresses(ccTo);
        
        
    }
    public  void insertDocCategories(List<Project__c> newProjectList){
        Folder_Names__c folders = [Select id , name , Folder_Names__c from Folder_Names__c];
        List<String> lstAlpha = folders.Folder_Names__c.split(',');
        List<Proposal_Document__c> proposalDocLists = new List<Proposal_Document__c> ();
        
        for(Project__c prj : newProjectList){
            for(String str : lstAlpha){
                Proposal_Document__c pd = new Proposal_Document__c();
                pd.Name = str;
                pd.Project__c = prj.Id;
                proposalDocLists.add(pd);
            }
        }
        insert proposalDocLists;
        
    }
    
    public  void getProjectRecord(List<Project__c> newProjectList){
        List<String> oppIds = new List<String>();
        for(Project__c project : newProjectList){
            oppIds.add(project.Opportunity__c);
        }
        system.debug('oppIds'+oppIds);
        List<Project__c> existingProjectList = [Select Id, Name, Opportunity__c from Project__c where Opportunity__c IN :oppIds];
        if(existingProjectList.size() > 0){
            newProjectList[0].addError('Project for this opportunity has already been created');
        }
    }
    
    public void afterInsert(Map<Id,Project__c> proposalMap){
        SharePointCallout.createFolder(proposalMap.keySet());
    }
}