import { LightningElement,wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountListHandler.getAccounts';

export default class AccountListDemo extends LightningElement {
    @wire(getAccounts)
    accounts
}