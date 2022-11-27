import { LightningElement ,api, wire, track} from 'lwc';
import getAccountList from '@salesforce/apex/SandRHelper.getAccountList';
import { CloseActionScreenEvent } from 'lightning/actions';
import {ShowToastEvent} from "lightning/platformShowToastEvent";
import { NavigationMixin } from 'lightning/navigation';
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';
import USER_ID from '@salesforce/user/Id'; 
import getProjectJobList from '@salesforce/apex/SandRHelper.getProjectJobDetails';

import JOB_OBJECT from '@salesforce/schema/Job__c';
import {getObjectInfo } from 'lightning/uiObjectInfoApi';
import TRANSFER_DATE from '@salesforce/schema/Job__c.Transfer_Date__c';
import TRANSFER_FROM from '@salesforce/schema/Job__c.Transfer_From__c';
import TRANSFER_TO from '@salesforce/schema/Job__c.Transfer_To__c';
import PROJECT_ID from '@salesforce/schema/Job__c.Project__c';
import validateCustomerReceived from '@salesforce/apex/SandRHelper.validateCustomerReceivedRecord'
export default class ProductSendingReceiving extends NavigationMixin(LightningElement) {
    @api recordId;
    @track newJobCreate = false;
    @track afterRecordType = false;
    jobObject = JOB_OBJECT;
    value = '';
    recordtypeId;
    @track error;
    @track jobsList;
    fields = [TRANSFER_DATE, TRANSFER_FROM, TRANSFER_TO];
    get options() {
        return [
            { label: 'Customer Received', value: 'Customer Received' },
            { label: 'Lab Transfer', value: 'Lab Transfer' },
            { label: 'Final Return', value: 'Final Return' },
            
        ];
    }

    @wire(getObjectInfo, { objectApiName: 'Job__c' })
    Function({ error, data }) {
        debugger;
        if (data) {
            console.log('Data::' + data);

            
         // perform your custom logic here
       }else if(error){
           // perform your logic related to error 
        }
     };

    @wire(getProjectJobList,{projectId:'$recordId'})
    wiredProjectJobs({
        error,
        data
    }) {
        if (data) {
            debugger;
            this.jobsList = data;
        } else if (error) {
            this.error = error;
        }
    }

    handleRadioChange(event) {
        this.value = event.detail.value;
    }

    recordCreateNextAction() {
        debugger;
        console.log('Value::' + this.value);
        
        if (this.value == "") {
            this.recordtypeToast();
            
        } else {
            if (this.value =='Customer Received') {
                this.recordtypeId = 'Customer Received'
            }
            if (this.value =='Lab Transfer') {
                this.recordtypeId = 'Lab_Transfer'
            }
            if (this.value =='Final Return') {
                this.recordtypeId = 'Final_Return'
            }
            validateCustomerReceived({ projectId: this.recordId }).then(result => {
                debugger;
                console.log(result);
                /*if (result != null && this.value == 'Customer Received') {
                    this.validateCustomerReceive();
                } else {*/
                    const defaultValues = encodeDefaultFieldValues({
                        recordTypeId  : '0128B000000CnEm',
                        Transfer_Date__c: '',
                        Transfer_From__c: '',
                        Transfer_To__c: '',
                        Project__c: this.recordId,
                        Job_Type__c: this.value
                        
                    });
             
                    this[NavigationMixin.Navigate]({
                        type: 'standard__objectPage',
                        attributes: {
                            objectApiName: 'Job__c',
                            actionName: 'new'
                        },
                        state: {
                            defaultFieldValues: defaultValues
                        }
                    });
               // }
            }).catch(error => {
                debugger;
                console.log(error);
            })
        }
        
        
        //this.afterRecordType = true;
        //this.project__c = 'a1w8B0000000KHPQA2';
    }
    validateCustomerReceive() {
        const event = new ShowToastEvent({
            title: 'Duplicate Record',
            message: 'You can not create multiple Customer Received Record!!!!!',
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }

    recordtypeToast() {
        const event = new ShowToastEvent({
            title: 'Job Type',
            message: 'Please select job type!!!!!',
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }

    handleLoad(event) {
        debugger;
        //this.fields.PROJECT_ID = 'a1w8B0000000KHPQA2';
        //this.accId = fields.AccountId.value;
    }

    createNewJob() {
        this.newJobCreate = true;
    }
    back() {
        this.newJobCreate = false;
    }
    recordPageUrl;
    redirectToRecordPage(event) {
        debugger;
        console.log('Job Id::' +event.target.dataset.id);
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.target.dataset.id,
                actionName: 'view',
            },
        }).then(url => {
                //2. Assign it to the prop
            this.recordPageUrl = url;
        });
    }
    
}