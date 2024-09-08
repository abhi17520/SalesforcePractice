import { LightningElement, api, track, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountListView.getAccounts';

const columns = [
    {label:"Account Name", fieldName:"Name"},
    {label:"Account Number", fieldName:"AccountNumber"},
    {label:"Phone", fieldName:"Phone"},
    {label:"Industry", fieldName:"Industry"},
    {label:"Rating", fieldName:"Rating"},
    {label:"Annual Revenue", fieldName:"AnnualRevenue"}
];

export default class AccountListView extends LightningElement {
    columns = columns;
    @track accounts;
    @track error;

    connectedCallback(){
        console.log("connectedCallback");
        this.loadAccounts();
    }

    loadAccounts(){
        getAccounts()
            .then(result => {
                console.log("accounts" + JSON.stringify(result));
                this.accounts = result;
                console.log("accounts" + JSON.stringify(this.accounts));
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                console.log("error" + JSON.stringify(this.error));
                this.accounts = undefined;
            })
    }
}