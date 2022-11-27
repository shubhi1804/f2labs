public class ProjectFlowHelper {
    @AuraEnabled
    public static List<String> getFieldRecordFromProject(String recordId){
        system.debug('recordId'+recordId);
        
        List<String> servicesList = new List<String>(); 
        
        Project__c projectRecord = [SELECT Authorized_EU__c,CB_project__c,CE_Annual_Review__c,EMC__c,Environmental__c,EU_Consulting__c,EU_services__c,Field_Label__c,Food_Contact_Materials__c,Hazloc__c,Id,Listing__c,Name,Prop_65__c,Radio_testing__c,REACH__c,ROHS__c,Safety_Subs__c,Safety__c,TF_or_TDF__c FROM Project__c WHERE Id =: recordId];
        
        if(projectRecord.Authorized_EU__c == 'Yes') servicesList.add('Authorized EU');      
        if(projectRecord.CB_project__c == 'Yes') servicesList.add('CB project');      
        if(projectRecord.CE_Annual_Review__c == 'Yes') servicesList.add('CE Annual Review');      
        if(projectRecord.EMC__c == 'Yes') servicesList.add('EMC');      
        if(projectRecord.Environmental__c == 'Yes') servicesList.add('Environmental');
        if(projectRecord.EU_Consulting__c == 'Yes') servicesList.add('EU Consulting');
        if(projectRecord.EU_services__c == 'Yes') servicesList.add('EU Services');
        if(projectRecord.Field_Label__c == 'Yes') servicesList.add('Field Label');
        if(projectRecord.Food_Contact_Materials__c == 'Yes') servicesList.add('Food Contact Materials');
        if(projectRecord.Hazloc__c == 'Yes') servicesList.add('Hazloc');
        if(projectRecord.Listing__c == 'Yes') servicesList.add('Listing');
        if(projectRecord.Prop_65__c == 'Yes') servicesList.add('Prop 65');
        if(projectRecord.Radio_testing__c == 'Yes') servicesList.add('Radio Testing');
        if(projectRecord.REACH__c == 'Yes') servicesList.add('REACH');
        if(projectRecord.ROHS__c == 'Yes') servicesList.add('ROHS');
        if(projectRecord.Safety_Subs__c == 'Yes') servicesList.add('Safety Subs');
        if(projectRecord.Safety__c == 'Yes') servicesList.add('Safety');
        if(projectRecord.TF_or_TDF__c  == 'Yes') servicesList.add('TF or TDF');
        
        system.debug('servicesList'+servicesList);
       /* ScopeResult sr = new ScopeResult();
        sr.selectedValue = servicesList;
        
        List<ScopeResult> resultList = new  List<ScopeResult>();
        resultList.add(sr);*/
        return servicesList;
    }
    
    
    /*public class ScopeRequest{
        @InvocableVariable
        public List<ID> recordId;
        
    }
    
    public class ScopeResult{
        @InvocableVariable
        public List<String> selectedValue;
    }*/
    
}