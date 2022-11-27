trigger TriggerOnJob on Job__c (before insert) {

    if(Trigger.isInsert && Trigger.isBefore){
        //JobTriggerHelper.assignJobRecordType(trigger.New);
        JobTriggerHelper.validateJobRecordtype(trigger.New);
    }
}