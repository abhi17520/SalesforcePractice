trigger contactTrigger on Contact (before insert, before update, after insert, after update, after delete, after undelete) {
    if(trigger.isAfter){
        if(trigger.isUpdate){
            if(!trigger.new.isEmpty()){
                ContactTriggerHandler.updateRelatedAccounts(trigger.new, trigger.oldMap);
                ContactTriggerHandler.updateContactCount(trigger.new, trigger.oldMap);
            }
        }
        if(trigger.isInsert || trigger.isUndelete){
            if(!trigger.new.isEmpty()){
                ContactTriggerHandler.updateContactCount(trigger.new, null);
            }
        }
        if(trigger.isDelete){
            if(!trigger.old.isEmpty()){
                ContactTriggerHandler.updateContactCount(trigger.old, null);
            }
        }
    }
}