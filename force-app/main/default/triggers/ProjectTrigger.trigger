trigger ProjectTrigger on Project__c (before insert , after update , after insert) {
    system.debug('oppIds');
    ProjectTriggerHelper helperObj = ProjectTriggerHelper.getInstance();
    
    if(Trigger.isInsert && Trigger.isBefore) {
        helperObj.onBeforeInsert(Trigger.new);
        
        //helperObj.afterInsert(Trigger.newMap);
    }
    if(Trigger.isInsert && Trigger.isAfter) {
        helperObj.insertDocCategories(Trigger.new);
        helperObj.afterInsert(Trigger.newMap);
    }
    
}