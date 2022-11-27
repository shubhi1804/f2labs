trigger UserTrigger on User (after insert, after update) {
    
    UserTriggerHelper helperObj = UserTriggerHelper.getInstance();

    if(trigger.isAfter && Trigger.isInsert){
        UserTriggerHelper.permissionSetAssignment(Trigger.New);
    }
    
    if(Trigger.isUpdate && Trigger.isAfter) {
        
    }
}