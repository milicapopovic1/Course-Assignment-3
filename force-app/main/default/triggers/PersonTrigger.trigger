trigger PersonTrigger on Person__c (after insert, after update, after delete, before insert, before update, before delete) {
    //Person__c oldPerson = Trigger.isInsert?null:Trigger.oldMap.get(Trigger.new[0].Id);
    TriggerHelper.triggerDispatcher(Trigger.operationType); 

    
}