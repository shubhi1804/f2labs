public class ProjectTriggerHelperModel {

    public static List<Project_Opportunity_Mapping__mdt> getFieldMappingMDTList() {
        return [Select Id, Opportunity_Field_API_Name__c, Project_Field_API_Name__c
                from Project_Opportunity_Mapping__mdt];
    }
}