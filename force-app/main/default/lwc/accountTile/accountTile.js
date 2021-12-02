import { LightningElement, api } from 'lwc';

export default class AccountTile extends LightningElement {

    @api account

    handleAccount(){
        console.log('account id --> ' + this.account.Id)
        const myEvent = new CustomEvent('accountclick',{
            detail:this.account.Id
        })
        this.dispatchEvent(myEvent)
    }
}