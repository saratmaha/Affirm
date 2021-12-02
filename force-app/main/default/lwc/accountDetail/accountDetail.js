import { LightningElement,api, track } from 'lwc';
import getAccountDetails from '@salesforce/apex/AccountListHandler.getAccountDetails';

export default class AccountDetail extends LightningElement {
    @api accountId
    @track account

    connectedCallback(){
        this.handleAccountDetails(this.accountId)
    }

    @api handleAccountDetails(acc) {        
        getAccountDetails({searchId:acc})
        .then(result => {
            console.log('Result ' + JSON.stringify(result))
            this.account = result  
        })
        .catch(error => {
            console.log('error --> ' + error)
        })
    }       
}