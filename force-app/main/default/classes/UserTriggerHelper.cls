public class UserTriggerHelper {
    
    private static UserTriggerHelper newObj = null;
    
    private UserTriggerHelper() {}
    
    public static UserTriggerHelper getInstance() {
        if(newObj == null) {
            newObj = new UserTriggerHelper();
        }
        return newObj;
    }
    
    
    public static void permissionSetAssignment (List<User> userList){
        List<Permission_Set_Assignment_by_Roles__mdt> permissionSetByUserRole = [SELECT Id,Label,Permission_Set__c,Name__c  FROM Permission_Set_Assignment_by_Roles__mdt];
        Map<String, String> rolePermissionSetMap = new Map<String, String>();
        for (Permission_Set_Assignment_by_Roles__mdt userRole : permissionSetByUserRole){            
            rolePermissionSetMap.put(userRole.Name__c, userRole.Permission_Set__c);
        }
        system.debug('rolePermissionSetMap' + rolePermissionSetMap);
        List<PermissionSetAssignment> psList = new List<PermissionSetAssignment>();
        List<PermissionSet> permissionSetList = [SELECT Id,Label,Name FROM PermissionSet];
        Map<String, Id> permissionSetIdByName = new Map<String,Id>();
        for(PermissionSet PSID : permissionSetList){
            permissionSetIdByName.put(PSID.Label, PSID.Id);
        } 
        system.debug('permissionSetIdByName' + permissionSetIdByName);
        for(User users : userList){
            if(users.User_Roles__c != Null && users.IsActive == true){
                for(String role : users.User_Roles__c.split(';')){
                    system.debug('Role is '+role +'role Id is' + permissionSetIdByName.get(role));
                    String permissionSetID = permissionSetIdByName.get(role);
                    system.debug('permissionSetID' + permissionSetID);
                    if(permissionSetID != null){
                        PermissionSetAssignment permissionSetRec = new PermissionSetAssignment();
                        permissionSetRec.AssigneeId = users.Id;
                        permissionSetRec.PermissionSetId = permissionSetID;
                        psList.add(permissionSetRec);    
                    } 
                }
            }        
        }
        system.debug('psList'+psList);
        try{
            upsert psList;
        }catch(exception e){
            system.debug('exception caught' + e.getMessage());
        }
    }
    
    
    public static void onAfterUpdate(List<User> userList, Map<Id, User> newMap, Map<Id, User> oldMap) {
        
        Set<Id> userIds = new Set<Id>();
        for(User u : userList){
            userIds.add(u.ProfileId);
        }
        
        Map<Id,User> userPerm = new Map<Id,User>();
        List<PermissionSetAssignment> psaList = [SELECT Id, PermissionSetId, PermissionSet.Name, PermissionSet.ProfileId, PermissionSet.Profile.Name, 
                                                 AssigneeId, Assignee.Name FROM PermissionSetAssignment WHERE AssigneeId IN: userIds];
       
        
    }
}