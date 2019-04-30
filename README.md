# KLOVE_Homework

The following requirements where submitted by Nancy from KLOVE Recruiting on 4/11/19

Requirements:

Opportunity trigger runs for Donation record type only
Opportunity has a related recurring MONTHLY donation of $40 or more
Add a new note to all contacts on the corresponding household account by adding the following info:
Title: New Opportunity Created for {INSERT ACCOUNT NAME HERE}
Add to Body: Opportunity creator, Close date, Stage and Recurring donation amount
 

Bonus: Apex Unit Tests with at least 75% code coverage (please include asserts)

Once you’re done, throw the code on github with instructions on how to deploy to an org and email me and Shaun a link.

-------------------------------------------------------

To complete this project I have created one trigger and two classes and one test class that should be downloaded and committed in SFDC Developer Org in this order

1.HasRun.apxc

2.AddContactNote.apxc 

3.OpportunityTrigger.apxt 

4.testAddContactNote.apxc

I used Eclipse IDE to create these files and uploaded them to GitHub

In order to test this you must download a new developer org

https://developer.salesforce.com/signup

And dowload the Non-Profit Success Pack (NPSP) from the Salesforce AppExchange

https://appexchange.salesforce.com/appxListingDetail?listingId=a0N3000000B5Gx6EAF

Once dowloaded one small change must be made.  The Record Type on Opportunity Object must be updated from the standard NPSP name to Donation OR you can clone the NSPS Record Type and create a new Record Type called Donation.  If you choose to do this, you will be required to update the settings on the NPSP so that Recurring Donations automatically create opportunities with the Record Type Donation and not the NPSP record type (which is default)

Please reach out to me at patrickhmaxwell@gmail.com if you have more questions or you find that these instructions are not thorough enough.

**********************************

Update on 4-26-2019

I have committed a full SFDC project to Git.  This project includes the new Lightning Component that could be used to fix Nick's issue with phone support not being informed about if family members are deceased or not.  I also added a field the displays if someone is the head of the household, and if they are not, what their relationship is with the head of the household.

You can review this Lightning Component by navigating to a Contact page and clicking the gear icon in the upper right and selecting "Edit Page" that will bring up the lightning page editor.  On the left is a large list of standard components on after them will be the Custom Components.  You should see mine called "Contact List" and I would recommend adding it to a portion of the page that is longer horizontally since there are 5 or 6 fields that need to display.
