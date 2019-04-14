@isTest
public class testAddContactNote {
    
    @isTest
    static void testCreateNote() {
        system.debug('Begin testCreateNote');

        Contact con = new Contact(FirstName = 'Test', LastName = 'CreateNote');
        insert con;
        
        npe03__Recurring_Donation__c rDonation = new npe03__Recurring_Donation__c(name = 'CreatNote Fellowship', 
                                                                                  npe03__Contact__c = con.id, 
                                                                                  npe03__Amount__c = 2000, 
                                                                                  npe03__Installment_Period__c = 'Monthly', 
                                                                                  npe03__Installments__c = 2);
        
        insert rDonation;
        
        list<Opportunity> opps = [select id, accountid, account.name, npe03__Recurring_Donation__r.npe03__Installment_Amount__c, 
								  npe03__Recurring_Donation__r.npe03__Installment_Period__c, CreatedBy.FirstName, 
								  CreatedBy.LastName, CloseDate, StageName, RecordType.Name from Opportunity order by CreatedDate];
        
        list<Note> nte = [select id, ParentId, Title, Body from Note order by CreatedDate];
        
        system.assertEquals(nte[0].ParentId, con.Id);
		system.assertEquals(nte[0].Title, 'New Opportunity Created for ' + opps[0].account.name);
        system.assertEquals(nte[0].Body, 'Opportunity Creator: ' + opps[0].CreatedBy.FirstName + ' ' + opps[0].CreatedBy.LastName + 
                              '\r\nClose Date: ' + opps[0].CloseDate.month() + '/' + opps[0].CloseDate.day() + '/' + opps[0].CloseDate.year() + 
                              '\r\nStage: ' + opps[0].StageName + 
                              '\r\nRecurring Donation Amount: $' + opps[0].npe03__Recurring_Donation__r.npe03__Installment_Amount__c);
        
        
    } 

}