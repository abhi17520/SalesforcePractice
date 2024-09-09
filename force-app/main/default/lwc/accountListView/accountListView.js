import { LightningElement, api, track, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountListView.getAccounts';

const columns = [
    {label:'Account Name', fieldName:'recordLink', type:'url', typeAttributes:{
        label:{fieldName:'Name'}, 
        target: '_blank'
    }},
    {label:'Account Number', fieldName:'AccountNumber', type:'text'},
    {label:'Phone', fieldName:'Phone', type:'phone'},
    {label:'Industry', fieldName:'Industry', type:'text'},
    {label:'Rating', fieldName:'Rating', type:'text'},
    {label:'Annual Revenue', fieldName:'AnnualRevenue', type:'currency'}
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
                this.accounts = result.map(account => {
                    return {...account, recordLink: '/' + account.Id};
                });
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                console.log("error" + JSON.stringify(this.error));
                this.accounts = undefined;
            })
    }
}