/**
 * @author Mukesh Chawla
 * @email Mukesh.chawla@utilitarianlab.com
 * @create date 2022-10-03 13:37:19
 * @modify date 2022-10-18 14:37:38
 * @desc [description]
 */

import { LightningElement, api, track, wire } from 'lwc';
import QuotesUnderOpps from '@salesforce/apex/Opp_QuotesHandler.Quotes_UnderOpps';
import SaveQuote from '@salesforce/apex/Opp_QuotesHandler.Save_Quote';
import { CloseActionScreenEvent } from 'lightning/actions';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import LightningAlert from 'lightning/alert';

export default class CompletedWork_Percentage extends LightningElement {

    @api recordId;
    @track NewQuoteList = [];
    @track record = [];
    @track error;
    disable_savebutton = false;
    textid;
    textvalue;

    // connectedCallback() {
    //     this.Quotes_Under_Opps();
    // }

    // Quotes_Under_Opps() {
    //     debugger;
    //     QuotesUnderOpps({ OppId: this.recordId}).then(result => {
    //         debugger;
    //         if (result) {
    //                  this.record = result;
    //              this.error = undefined;
    //                 } else if (error) {
    //                     this.error = error;
    //                     this.record = undefined;
    //                 }
    //     }).catch(err => {
    //         console.log('err::' + err);
    //     })
    // }
    @wire(QuotesUnderOpps, { OppId: '$recordId' })
    wiredQuotes({ error, data }) {
        debugger;
        if (data) {
            this.record = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.record = undefined;
        }
    }

    handleChange(event) {
        debugger;
        this.textid = event.target.dataset.id;
        this.textvalue = event.target.value;;
        let QuoteDetails = this.record;
        let QuoteDetailsList = [];
        QuoteDetails.forEach(SBQQ__QuoteLine__c => {
            if (this.textid == SBQQ__QuoteLine__c.Id) {
                //SBQQ__Quote__c.Percent_completed__c = this.textvalue;
                QuoteDetailsList.push({
                    Id: SBQQ__QuoteLine__c.Id ? SBQQ__QuoteLine__c.Id : "",
                    Name: SBQQ__QuoteLine__c.Name ? SBQQ__QuoteLine__c.Name : "",
                    SBQQ__ProductName__c: SBQQ__QuoteLine__c.SBQQ__ProductName__c ? SBQQ__QuoteLine__c.SBQQ__ProductName__c : "",
                    SBQQ__ProductFamily__c: SBQQ__QuoteLine__c.SBQQ__ProductFamily__c ? SBQQ__QuoteLine__c.SBQQ__ProductFamily__c : "",
                    SBQQ__Description__c: SBQQ__QuoteLine__c.SBQQ__Description__c ? SBQQ__QuoteLine__c.SBQQ__Description__c : "",
                    Completed_In_percent__c: this.textvalue ? this.textvalue : ""
                })
            }
            else{
                QuoteDetailsList.push({
                    Id: SBQQ__QuoteLine__c.Id ? SBQQ__QuoteLine__c.Id : "",
                    Name: SBQQ__QuoteLine__c.Name ? SBQQ__QuoteLine__c.Name : "",
                    SBQQ__ProductName__c: SBQQ__QuoteLine__c.SBQQ__ProductName__c ? SBQQ__QuoteLine__c.SBQQ__ProductName__c : "",
                    SBQQ__ProductFamily__c: SBQQ__QuoteLine__c.SBQQ__ProductFamily__c ? SBQQ__QuoteLine__c.SBQQ__ProductFamily__c : "",
                    SBQQ__Description__c: SBQQ__QuoteLine__c.SBQQ__Description__c ? SBQQ__QuoteLine__c.SBQQ__Description__c : "",
                    Completed_In_percent__c: SBQQ__QuoteLine__c.Completed_In_percent__c ? SBQQ__QuoteLine__c.Completed_In_percent__c : ""
                })
            }
        })
        this.record = QuoteDetailsList;

    }

    handleClick() {
        debugger;
        this.disable_savebutton = true;
        SaveQuote({ UpdatedQuoteList: this.record }).then(result => {
            debugger;
            if (result) {
                this.showSuccessToastQuoteSaved();
                this.closeQuickAction();
                //this.handleAlertClick();
            }
        }).catch(err => {
            console.log('err::' + err);
        })
    }

    showSuccessToastQuoteSaved() {
        const event = new ShowToastEvent({
            title: 'Quote Line Items Updated',
            message: 'Quote Line Items Updated Successfully!',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);

    }
    closeQuickAction() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    handleAlertClick() {
         LightningAlert.open({
            message: 'This is the alert message.',
            theme: 'error', // a red theme intended for error states
            label: 'Error!', // this is the header text
        });
        // alert modal has been closed
    }



}