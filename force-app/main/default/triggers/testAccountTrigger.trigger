trigger testAccountTrigger on Account (before insert, before update, after insert, after update) {
    if(trigger.isBefore && trigger.isInsert){
        AccountTriggerHandler.errorPhoneEmpty(trigger.new);
    }
}