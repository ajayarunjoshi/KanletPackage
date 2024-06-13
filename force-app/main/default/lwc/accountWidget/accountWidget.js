import { LightningElement, api, wire } from 'lwc';
import kpcDetails from '@salesforce/apex/AccountCardController.kProcessedContact';

export default class AccountWidget extends LightningElement {

    @api recordId;
    accountId;
    leftCount = 0;
    joinedCount = 0;
    promotedCount = 0;
    accounts = [];

    @wire(kpcDetails, { accountId: '$recordId' })
    wiredData({ data, error }) {
        if (data) {
            this.accounts = data.map(account => ({
                ...account,
                contactStatus: account.Contact_Status__c ? account.Contact_Status__c : ''
            }));

            // Reset counts
            this.leftCount = 0;
            this.joinedCount = 0;
            this.promotedCount = 0;

            // Count occurrences of each status
            this.accounts.forEach(account => {
                if (account.contactStatus === 'Joined') {
                    this.joinedCount++;
                } else if (account.contactStatus === 'Left') {
                    this.leftCount++;
                } else if (account.contactStatus === 'Promoted') {
                    this.promotedCount++;
                }
            });
        }

        if (error) {
            this.handleApexError(error, 'Error fetching accounts.');
        }
    }
    
    handleApexError(error, message) {
        // Implement your error handling logic here
        console.error(message, error);
    }
}