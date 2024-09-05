trigger contactTrigger on Contact (before insert, before update, after insert, after update) {
    if(trigger.isAfter && trigger.isUpdate){
        ContactTriggerHandler.updateRelatedAccounts(trigger.new, trigger.oldMap);
    }
}