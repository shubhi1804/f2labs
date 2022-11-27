public class UserTriggerHelperService {

    public static void updatePermissionSetAssignment(Map<Id, User> newMap, Map<Id, User> oldMap) {
        Set<Id> userRoleChangedIdSet 							= new Set<Id>();
        List<Permission_Set_Assignment_by_Roles__mdt> mdtList 	= new List<Permission_Set_Assignment_by_Roles__mdt>();
        Map<String, String> userRoleAndPSNameMap				= new Map<String, String>();
        List<PermissionSet> permissionSetList 					= new List<PermissionSet>();
        Map<String, Id> permissionSetLabelAndIdMap 				= new Map<String, Id>();   
        List<PermissionSetAssignment> permissionSetAssgList 	= new List<PermissionSetAssignment>();
        Map<Id, List<PermissionSetAssignment>> permAssgMap 		= new Map<Id, List<PermissionSetAssignment>>();
        Map<String, Id> permAssignmentSetMap 					= new Map<String, Id>();
                
        for(User userObj : newMap.values()) {
            if(userObj.User_Roles__c != oldMap.get(userObj.Id).User_Roles__c) userRoleChangedIdSet.add(userObj.Id);
        }
        
        if(!userRoleChangedIdSet.isEmpty()) { 
            mdtList 	= UserTriggerHelperModel.getPermissionSetMappingMDT();
            for(Permission_Set_Assignment_by_Roles__mdt mdtObj : mdtList) {
                userRoleAndPSNameMap.put(mdtObj.Name__c, mdtObj.Permission_Set__c);
            }
            permissionSetList 	= UserTriggerHelperModel.getPermissionSets(userRoleAndPSNameMap.values());
            for(PermissionSet psObj : permissionSetList) {
                permissionSetLabelAndIdMap.put(psObj.Label, psObj.Id);
            }
            permissionSetAssgList 	= UserTriggerHelperModel.getPermissionSetAssgRelatedToUsers(userRoleChangedIdSet);
            for(PermissionSetAssignment psAssignObj : permissionSetAssgList) {
                if(permAssgMap.containsKey(psAssignObj.AssigneeId)) permAssgMap.get(psAssignObj.AssigneeId).add(psAssignObj);
                else permAssgMap.put(psAssignObj.AssigneeId, new List<PermissionSetAssignment>{psAssignObj});
                permAssignmentSetMap.put(psAssignObj.AssigneeId + '_' + psAssignObj.PermissionSetId, psAssignObj.Id);
            }
            for(Id userId : userRoleChangedIdSet) {
                for(String roleName : newMap.get(userId).User_Roles__c.split(';')) {
                    String permissionSetId = permissionSetLabelAndIdMap.get(userRoleAndPSNameMap.get(roleName));
                    if(!permAssignmentSetMap.containsKey(userId + '_' + permissionSetId)) {
                        PermissionSetAssignment permissionSetRec = new PermissionSetAssignment();
                        permissionSetRec.AssigneeId = userId;
                        permissionSetRec.PermissionSetId = permissionSetId;
                //        psList.add(permissionSetRec);
                    }
                }
            }
        }
    }
}