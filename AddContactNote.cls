public class AddContactNote {
    
    //Declare instance variable(s)
    
    map<Id, Opportunity> newMap = new map<Id, Opportunity>();
    
    public AddContactNote(map<Id, Opportunity> newTriggerMap){

        newMap = newTriggerMap;

    }// end constructor
    
    public void createNote () {
    	//system.debug('createNote Begins');
        
        //HasRun variable used to prevent recursion
        if(!HasRun.createNoteHasRun){
            HasRun.createNoteHasRun = TRUE;
            
            //Declare local variable(s)
            map<id, list<Opportunity>> mapAccIdToOpp = new map<Id, list<Opportunity>>();
            list<Note> notes = new list<Note>();
            list<Opportunity> lookupOpps = [select id, accountid, account.name, npe03__Recurring_Donation__r.npe03__Installment_Amount__c, 
                                            npe03__Recurring_Donation__r.npe03__Installment_Period__c, CreatedBy.FirstName, 
                                            CreatedBy.LastName, CloseDate, StageName, RecordType.Name from Opportunity where id in: newMap.keySet()];
            
            //filter opportunities based on requirements: Opportunity has a related recurring MONTHLY donation of $40 or more, and Donation record type only
            for(Opportunity o : lookupOpps){
                if(o.npe03__Recurring_Donation__r.npe03__Installment_Amount__c >= 40 && 
                   o.npe03__Recurring_Donation__r.npe03__Installment_Period__c == 'Monthly' &&
                   o.RecordType.Name == 'Donation'){
                       if(!mapAccIdToOpp.keyset().contains(o.AccountId)){
                           mapAccIdToOpp.put(o.AccountId, new list<Opportunity>());
                           mapAccIdToOpp.get(o.AccountId).add(o);
                       } else { mapAccIdToOpp.get(o.AccountId).add(o);}// end if
                }// end if
            }// end for loop
            
            if(mapAccIdToOpp.keyset().size() > 0){
                for(contact c : [select id, AccountId from Contact where AccountId in: mapAccIdToOpp.keyset()]){
                    for(Opportunity o : mapAccIdToOpp.get(c.AccountId)){
                        
                        //create note
                        string closeDate;
                        string title;
                        string body;
                        
                        closeDate = o.CloseDate.month() + '/' + o.CloseDate.day() + '/' + o.CloseDate.year();
                        title = 'New Opportunity Created for ' + o.account.name;
                        body = 'Opportunity Creator: ' + o.CreatedBy.FirstName + ' ' + o.CreatedBy.LastName + 
                            '\r\nClose Date: ' + closeDate + 
                            '\r\nStage: ' + o.StageName + 
                            '\r\nRecurring Donation Amount: $' + o.npe03__Recurring_Donation__r.npe03__Installment_Amount__c;
                        Note nte = new Note(Title = title, Body = body, ParentId = c.id);
                        notes.add(nte);
                    }
                }// end for loop
            }// end if
            
            try{
                insert notes;
            } catch(DmlException e) {
                System.debug('The following exception has occurred: ' + e.getMessage());
            }
        }
    }// end createNote method
}