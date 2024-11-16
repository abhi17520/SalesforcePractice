trigger testAccountTrigger on Account (before insert, before update, after insert, after update) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            AccountTriggerHandler.errorPhoneEmpty(trigger.new);
        }
        if(trigger.isInsert || trigger.isUpdate){
            AccountTriggerHandler.errorDuplicateAccount(trigger.new, trigger.oldMap);
        }
    }
    if(trigger.isAfter){
        if(trigger.isInsert || trigger.isUpdate){
            AccountTriggerHandler.createRelatedContacts(trigger.new, trigger.oldMap);
        }
        if(trigger.isUpdate){
            AccountTriggerHandler.updateRelatedContatcts(trigger.new, trigger.oldMap);
        }
    }
}