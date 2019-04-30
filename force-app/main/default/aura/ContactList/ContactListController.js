({
	myAction : function(component, event, helper) {
        component.set("v.Columns", [
            {label:"First Name", fieldName:"FirstName", type:"text"},
            {label:"Last Name", fieldName:"LastName", type:"text"},
            {label:"Phone", fieldName:"Phone", type:"phone"},
            {label:"Deceased", fieldName:"npsp__Deceased__c", type:"boolean"},
			{label:"Head of Household", fieldName:"Head_of_Household__c", type:"boolean"},
            {label:"Realationship to Head of Household", fieldName:"Relationship_to_Head_of_Household__c", type:"text"}            
        ]);

        var action = component.get("c.getContacts");
        action.setParams({
            recordId: component.get("v.recordId")
        });
        action.setCallback(this, function(data) {
            component.set("v.Contacts", data.getReturnValue());
        });
        $A.enqueueAction(action);
	}
})