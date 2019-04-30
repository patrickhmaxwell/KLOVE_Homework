public class HouseholdContactListController {
    
    @AuraEnabled
    public static List<Contact> getContacts(Id recordId) {
        
       Contact con = [select accountId from Contact where Id = :recordId limit 1];
        
       return [Select Id, FirstName, LastName, Email, Phone, npsp__Deceased__c, Head_of_Household__c, 
               Relationship_to_Head_of_Household__c From Contact Where Id !=: recordId AND AccountId = :con.accountId];
    }

}