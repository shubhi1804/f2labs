trigger EmailMessageTrigger on EmailMessage (after insert,Before insert) {
    if(trigger.isInsert && trigger.isAfter){
      
        for(EmailMessage em : trigger.new){
            if(em.Incoming == false){
                EmailMessageTriggerHelper.updateRelatesRecordID(Trigger.New);    
                system.debug('Email was send'+Trigger.New[0].ActivityId);    
            }
        }
        
    }
    
    if(trigger.isInsert && trigger.isBefore){
        EmailMessageTriggerHelper.setDefaultFields(Trigger.New);   
        //system.debug('Email was send'+Trigger.New[0].ActivityId);
    }
    system.debug('Email was send'+Trigger.New[0].ActivityId);
}