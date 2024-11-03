trigger testAccountTrigger on Account (before insert, before update, after insert, after update) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            AccountTriggerHandler.errorPhoneEmpty(trigger.new);
        }
        if(trigger.isInsert || trigger.isUpdate){
            AccountTriggerHandler.errorDuplicateAccount(trigger.new);
        }
    }
    if(trigger.isAfter){
        if(trigger.isUpdate){
            AccountTriggerHandler.updateRelatedContatcts(trigger.new, trigger.oldMap);
        }
    }
}