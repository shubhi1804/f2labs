public class ProjectTriggerHelperService {

    public static void mapValuesFromOppOnInsert(List<Project__c> newList) {
        Set<Id> opportunityIdSet 								= new Set<Id>();
        Map<Id,Opportunity> oppMap 	 							= new Map<Id,Opportunity>();
        List<Project_Opportunity_Mapping__mdt> mappingMDTList 	= new List<Project_Opportunity_Mapping__mdt>();
        mappingMDTList 											= ProjectTriggerHelperModel.getFieldMappingMDTList();
        system.debug('mappingMDTList' + mappingMDTList);
        
        for(Project__c projectObj : newList) {
            if(projectObj.Opportunity__c != null) opportunityIdSet.add(projectObj.Opportunity__c);
        }
        
        for(Opportunity oppObj : Database.query(createDynamicQueryForOpp(opportunityIdSet, mappingMDTList))) {
			 oppMap.put(oppObj.Id, oppObj);           
        }
        
        for(Project__c projectObj : newList) {
            if(oppMap.containsKey(projectObj.Opportunity__c)) {
                Opportunity oppObj = oppMap.get(projectObj.Opportunity__c);
                for(Project_Opportunity_Mapping__mdt mdtObj : mappingMDTList) {  
                    system.debug('oppObj.get(mdtObj.Opportunity_Field_API_Name__c)'+oppObj.get(mdtObj.Opportunity_Field_API_Name__c));
                    system.debug('mappingMDTList' + mappingMDTList);
                    projectObj.put(mdtObj.Project_Field_API_Name__c, oppObj.get(mdtObj.Opportunity_Field_API_Name__c));
                }
            }
        }        
    }
    
    private static String createDynamicQueryForOpp(Set<Id> opportunityIdSet, List<Project_Opportunity_Mapping__mdt> mappingMDTList) {
        String queryStr = 'Select Id';
        for(Project_Opportunity_Mapping__mdt mdtObj : mappingMDTList) {
            if(String.isNotBlank(mdtObj.Opportunity_Field_API_Name__c) && mdtObj.Opportunity_Field_API_Name__c != 'Id') queryStr += ' ,' + mdtObj.Opportunity_Field_API_Name__c;
        }
        queryStr += ' from Opportunity where ID IN: opportunityIdSet';
        return queryStr;
    }
    
    public static  void getProjectRecord(List<Project__c> newProjectList){
        
        List<String> oppIds = new List<String>();
        Map<Id, List<Project__c>> projectAndOppMap = new Map<Id, List<Project__c>>();
        for(Project__c project : newProjectList){
            oppIds.add(project.Opportunity__c);
        }
        system.debug('oppIds'+oppIds);
        List<Project__c> existingProjectList = [Select Id, Name, Opportunity__c from Project__c where Opportunity__c IN :oppIds];
        /*for(Project__c projectObj: existingProjectList) {
            if(projectAndOppMap.containsKey(projectObj.Opportunity__c)) {
                projectObj.addError('Project for this opportunity has already been created');
            }else{
                projectAndOppMap.put(projectObj.Opportunity__c, new List<Project__c>{projectObj});
            }
        } */
        
        
        if(existingProjectList.size() > 0){
            newProjectList[0].addError('Project for this opportunity has already been created');
        }

    }
}