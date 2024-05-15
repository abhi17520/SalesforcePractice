trigger testAccountTrigger on Account (before insert, before update, after insert, after update) {
    if(trigger.isBefore && trigger.isInsert){
        AccountTriggerHandler.errorPhoneEmpty(trigger.new);
    }
    if(trigger.isAfter && trigger.isUpdate){
        AccountTriggerHandler.updateRelatedContatcts(trigger.new, trigger.oldMap);
    }
}