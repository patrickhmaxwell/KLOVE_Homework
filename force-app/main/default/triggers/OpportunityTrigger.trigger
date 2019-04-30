trigger OpportunityTrigger on Opportunity (before insert, after insert, before update, after update) {
    //system.debug('Opportunity Trigger Begins');
    if(trigger.isInsert){
        //system.debug('Opportunity Trigger isInsert');
        if(trigger.isAfter){
            //system.debug('Opportunity Trigger isBefore');
            AddContactNote acn = new AddContactNote(Trigger.newMap);
            acn.createNote();
        }
    }
}