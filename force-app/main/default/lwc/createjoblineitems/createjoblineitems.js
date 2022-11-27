import { LightningElement ,api, wire, track} from 'lwc';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import insertAccounts from '@salesforce/apex/SandRHelper.insertAccounts'
import deleteAccounts from '@salesforce/apex/SandRHelper.deleteJobLineItem'
import fetchJobLineItems from '@salesforce/apex/SandRHelper.fetchJobLineItems'
import FetchProjectId from '@salesforce/apex/SandRHelper.FetchProjectId';
import JobItems from '@salesforce/apex/SandRHelper.JobItems';

const column=[
    {label:'Name',fieldName:'Name'},
     {label:'Transfer From',fieldName:'Transfer_From__c'},
    {label:'Transfer To',fieldName:'Transfer_To__c'},
     {label:'Project' ,  fieldName:'Project__r.Name'}]


export default class Createjoblineitems extends LightningElement {
    @api recordId;
    @track listOfAccounts = [];
    @track listOfTempAccounts = [];
    @track checkValue = false;


    connectedCallback() {
        this.initData();
    }

    initData() {
        debugger;
        //let listOfAccounts = [];
        //this.createRow(this.listOfAccounts);
        //this.listOfAccounts = listOfAccounts;
    }

    // selectDeselectAll(event) {
    //     //let targetId=event.target.dataset.id;
    //     debugger;

    //      const selectedRows = event.detail.selectedRows;
    //     //  for (let i = 0; i < selectedRows.length; i++) {
    //     //     alert('You selected: ' + selectedRows[i]);
    //     // }
    //     // const checked = Array.from(
    //     //     this.template.querySelectorAll('lightning-input')
    //     // )
    //     //     // Filter down to checked items
    //     //     .filter((element) => element.checked)
    //     //     // Map checked items to their labels
    //     //     .map((element) => element.label);
    //     // // this.selection = checked.join(', ');
    //     // // this.textid = event.target.dataset.id;
    //     // // this.idValue=event.target.detail;
        
    //     if (event.target.checked)
    // {
       
    // }
    // else
    // {
    // console.log('check box is unchecked');
    // }
    // }

    @wire(fetchJobLineItems,{jobId:'$recordId'})
    wiredProjectJobs({
        error,
        data
    }) {
        debugger;
        if (data) {
            debugger;
            if(data.length != 0)
                for(let i = 0; i < data.length; i++) {
                    let tempRecord = Object.assign({}, data[i]); //cloning object
                    this.listOfAccounts.push(tempRecord);
                    this.listOfTempAccounts.push(tempRecord);
                }
            //if (data.length == 0)
            this.createRow(this.listOfAccounts);
                //this.listOfAccounts 
        } else if (error) {
            this.error = error;
        }
    }

    createRow(listOfAccounts) {
        debugger;
        let tempList = [];
        tempList = this.listOfAccounts;
        this.listOfTempAccounts = this.listOfAccounts;
        if (this.listOfAccounts.length == 0) {
            for (let i = 0; i < 10; i++){
                let accountObject = {};
                if(this.listOfAccounts.length > 0) {
                    accountObject.Index__c = this.listOfAccounts[this.listOfAccounts.length - 1].Index__c + 1;
                } else {
                    accountObject.Index__c = 1;
                }
                accountObject.Date_In__c = null;
                accountObject.Description__c = null;
                accountObject.Model__c = null;
                accountObject.Serial__c = null
                accountObject.Sample_Accessory__c = null 
                accountObject.Date_Out__c = null
                accountObject.Transfer_Notes__c = null
                accountObject.Job__c = null
                accountObject.Id = null
                accountObject.Type__c = null
                this.listOfAccounts.push(accountObject);
                console.log('listOfAccounts::' + this.listOfAccounts);
            }
        } else if(this.listOfAccounts.length < 10){
            for (let i = 0; i < 10 - this.listOfTempAccounts.length; i++){
                let accountObject = {};
                if(this.listOfAccounts.length > 0) {
                    accountObject.Index__c = this.listOfAccounts[this.listOfAccounts.length - 1].Index__c + 1;
                } else {
                    accountObject.Index__c = 1;
                }
                accountObject.Date_In__c = null;
                accountObject.Description__c = null;
                accountObject.Model__c = null;
                accountObject.Serial__c = null
                accountObject.Sample_Accessory__c = null
                accountObject.Date_Out__c = null
                accountObject.Transfer_Notes__c = null
                accountObject.Job__c = null
                accountObject.Id = null
                accountObject.Type__c = null
                this.listOfAccounts.push(accountObject);
                console.log('listOfAccounts::' + this.listOfAccounts);
            }
        } else {
            let accountObject = {};
                if(this.listOfAccounts.length > 0) {
                    accountObject.Index__c = this.listOfAccounts[this.listOfAccounts.length - 1].Index__c + 1;
                } else {
                    accountObject.Index__c = 1;
                }
                accountObject.Date_In__c = null;
                accountObject.Description__c = null;
                accountObject.Model__c = null;
                accountObject.Serial__c = null
                accountObject.Sample_Accessory__c = null
                accountObject.Date_Out__c = null
                accountObject.Transfer_Notes__c = null
                accountObject.Job__c = null
                accountObject.Id = null
                accountObject.Type__c = null
                this.listOfAccounts.push(accountObject);
                console.log('listOfAccounts::' + this.listOfAccounts);
        }
        
        
    }



    @track HandleButtonDisable=true;

   @track  DescriptionValue;
   @track ModalValue;
   @track SerialValue;
   @track SampleAccessoryValue;
   @track TransferNotesValue;

   AllInputValues={};

    /**
     * Input
     */ 
    handleInput(event){
        debugger;
        var targetname = event.target.name;
        

        if (event.target.name == 'Description__c') {

            this.DescriptionValue=event.target.value;

        }
         else if(event.target.name == 'Model__c'){

            this.ModalValue=event.target.value;
           
         }
         else if(event.target.name == 'Serial__c'){

            this.SerialValue=event.target.value;
         }
         else if(event.target.name == 'Sample_Accessory__c'){

            this.SampleAccessoryValue=event.target.value;
         }
         else if(event.target.name == 'Transfer_Notes__c'){

            this.TransferNotesValue=event.target.value;
        }
        if ((this.DescriptionValue == undefined || this.DescriptionValue == "") && (this.ModalValue == undefined || this.ModalValue == "") && (this.SerialValue == undefined || this.SerialValue == "") &&  (this.SampleAccessoryValue == undefined || this.SampleAccessoryValue == "") && (this.TransferNotesValue == undefined || this.TransferNotesValue == "")) {
            this.HandleButtonDisable=true;
        } else {
            this.HandleButtonDisable=false;
        }

         this.AllInputValues={
            Description:this.DescriptionValue,
            Model:this.ModalValue,
            Serial:this.SerialValue,
            SampleAccessory:this.SampleAccessoryValue,
            TransferNotes:this.TransferNotesValue

         }

         console.log('All Input Values='+JSON.stringify(this.AllInputValues));

        //  if(this.DescriptionValue==null || this.ModalValue==null || this.SerialValue==null || this.SampleAccessoryValue==null || this.TransferNotesValue==null ){

        //     this.HandleButtonDisable=true;
        //  }
   }

   @track Typevalue;

   get options() {
    return [
        { label: 'Accessory', value: 'Accessory' },
        { label: 'Sample', value: 'Sample' },
    ];
  }

  handleChange(event){
    debugger;
    let index = event.target.dataset.id;
        let fieldName = event.target.name;
        let value = event.target.value;

    for(let i = 0; i < this.listOfAccounts.length; i++) {
        if(this.listOfAccounts[i].Index__c === parseInt(index)) {
            this.listOfAccounts[i][fieldName] = value;
            this.listOfAccounts[i]['Job__c'] = this.recordId;
        }
    }

  }

   changeHandler(event){
    debugger;
    let index = event.target.dataset.id - 1;

    if(this.listOfAccounts[index]['selected'] == undefined || this.listOfAccounts[index]['selected'] == false){
        this.checkValue = true;
        this.HandleButtonDisable=false;
    }
    else if(this.listOfAccounts[index]['selected'] ==true){
        this.checkValue=false;

    }
    this.listOfAccounts[index]['selected'] = this.checkValue;
   }

    CopyValuesToRows(){
            debugger;
            console.log('this.listOfAccounts::'+this.listOfAccounts);
        console.log('this.AllInputValues::' + this.AllInputValues);
        let counter = 0;
        for (let i = 0; i < this.listOfAccounts.length;i++){
            if (this.listOfAccounts[i].selected == undefined || this.listOfAccounts[i].selected != true) {
                ++counter;
            }
        }
        if (counter == this.listOfAccounts.length) {
            const evt = new ShowToastEvent({
                title: 'Error Toast',
                message: 'Please Select Any CheckBox',
                variant: 'error',
            });
            this.dispatchEvent(evt);
            this.HandleButtonDisable=true;
        }
        
        for (let i = 0; i < this.listOfAccounts.length;i++){
            if (this.listOfAccounts[i].selected != undefined && this.listOfAccounts[i].selected == true) {
                this.listOfAccounts[i].Description__c = this.DescriptionValue;
                this.listOfAccounts[i].Model__c = this.ModalValue;
                this.listOfAccounts[i].Serial__c = this.SerialValue;
                this.listOfAccounts[i].Sample_Accessory__c = this.SampleAccessoryValue;
                this.listOfAccounts[i].Transfer_Notes__c = this.TransferNotesValue;
                this.listOfAccounts[i].Job__c = this.recordId;
            }
        }

        console.log('this.listOfAccounts::' + this.listOfAccounts);

               
                
    }


    /**
     * Adds a new row
     */
    addNewRow() {
        debugger;
        this.createRow(this.listOfAccounts);
    }

    /**
     * Removes the selected row
     */
    removeRow(event) {
        debugger;
        let toBeDeletedRowIndex = event.target.name;

        let listOfAccounts = [];
        let tempList = [];
        for(let i = 0; i < this.listOfAccounts.length; i++) {
            let tempRecord = Object.assign({}, this.listOfAccounts[i]); //cloning object
            if(tempRecord.Index__c !== toBeDeletedRowIndex) {
                listOfAccounts.push(tempRecord);
            } else {
                tempList.push(tempRecord);
            }
        }

        for(let i = 0; i < listOfAccounts.length; i++) {
            listOfAccounts[i].Index__c = i + 1;
        }

        this.listOfAccounts = listOfAccounts;

        deleteAccounts({
            jobListString: JSON.stringify(tempList)
        })
            .then(data => {
                //this.initData();
                let event = new ShowToastEvent({
                    message: "Job Line Items successfully created!",
                    variant: "success",
                    duration: 2000
                });
                this.dispatchEvent(event);
            })
            .catch(error => {
                console.log(error);
            });
    }

    /**
     * Removes all rows
     */
    removeAllRows() {
        let listOfAccounts = [];
        this.createRow(listOfAccounts);
        this.listOfAccounts = listOfAccounts;
    }
    

    handleInputChange(event) {
        debugger;
        let index = event.target.dataset.id;
        let fieldName = event.target.name;
        let value = event.target.value;
        
        for(let i = 0; i < this.listOfAccounts.length; i++) {
            if(this.listOfAccounts[i].Index__c === parseInt(index)) {
                this.listOfAccounts[i][fieldName] = value;
                this.listOfAccounts[i]['Job__c'] = this.recordId;
            }
        }
    }

    createAccounts() {
        debugger;
        for(let i = 0; i < this.listOfAccounts.length; i++) {
            if(this.listOfAccounts[i].selected != undefined) {
                delete this.listOfAccounts[i].selected
            }
        }
        insertAccounts({
            jsonOfListOfAccounts: JSON.stringify(this.listOfAccounts)
        })
            .then(data => {
                //this.initData();
                let event = new ShowToastEvent({
                    message: "Job Line Items successfully created!",
                    variant: "success",
                    duration: 2000
                });
                this.dispatchEvent(event);
            })
            .catch(error => {
                console.log(error);
            });
    }


    /* 
    *Modal PopUp
    */

    @track OpenModal=false;
    CopyValuesFromExistingJobs(){

        this.OpenModal=true;
    }

    // get JobOptions(){
        
    //     return this.Jobs;
    // }

    @track ListOfJobs=[];

    @track columns=column;

    

    

    @wire(FetchProjectId,{JobId:'$recordId'})
     wiredJobResponse(result){
        debugger;
        if(result.data){
            console.log('ResultJobId='+JSON.stringify(result.data));
            this.ListOfJobs=result.data;
        }
        // for( let i=0;i<this.ListOfJobs;i++){
        //       debugger;
        //     this.Jobs.push({label:result.data[i].id,value:result.data[i].id});
        //     console.log('Jobs='+this.Jobs);

        // }

     }

     SelectedJobId;
     getSelectedId(event) {
        debugger;
        const selectedRows = event.detail.selectedRows;
        // Display that fieldName of the selected rows
        for (let i = 0; i < selectedRows.length; i++) {
            // alert('You selected: ' + selectedRows[i].Id);
            this.SelectedJobId=selectedRows[i].Id;
            console.log('SelectedJobId='+this.SelectedJobId);
        }
    }

     closeModal(){
        this.OpenModal=false;
     }

     HandleProceed(){
        debugger;
        JobItems({JobsId:this.SelectedJobId})
        .then(result=>{
            if(result!=null){
                this.listOfAccounts=result;
                this.OpenModal=false;
            }

        })
        .catch(error=>{
            console.log('error='+error);

        })

     }

    
}