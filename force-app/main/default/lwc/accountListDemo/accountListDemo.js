import { LightningElement,wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountListHandler.getAccounts';

export default class AccountListDemo extends LightningElement {
    
    accounts =[]
    error
    selectedAccount
    showAccountDetail = false
    
    @wire(getAccounts)
    accountshandler({data, error}){
        if(data){
            this.accounts = data
            //console.log('my data' + JSON.stringify(data))
        }
        if(error){
            this.error = error
            //console.error('my error' + error)
        }
    } 
    
    handleAccountClick(event){
        let msg = event.detail
        this.selectedAccount = msg
        this.showAccountDetail = false
        console.log('message from child -> ' + msg)
    }

    handleNext(){
        if(this.selectedAccount){
            this.showAccountDetail = true
            console.log('handle next ' + this.selectedAccount);
            this.template.querySelector('c-account-detail').getAccountDetails(this.selectedAccount)
        }
    }

    handleBack(){
        this.selectedAccount = null
        this.showAccountDetail = false
    }
}