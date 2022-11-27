public class UserTriggerHelperModel {

    public static List<Permission_Set_Assignment_by_Roles__mdt> getPermissionSetMappingMDT() {
        return [SELECT Id,Label,Permission_Set__c,Name__c  FROM Permission_Set_Assignment_by_Roles__mdt];
    }
    
    
    public static List<PermissionSet> getPermissionSets(List<String> labelsList) {
        return [Select Id, Label, Name FROM PermissionSet where Label IN: labelsList];
    }
    
    
    public static List<PermissionSetAssignment> getPermissionSetAssgRelatedToUsers(Set<Id> usersSet) {
        return [Select Id, PermissionSetId, AssigneeId from PermissionSetAssignment where AssigneeId IN: usersSet];
    }
}