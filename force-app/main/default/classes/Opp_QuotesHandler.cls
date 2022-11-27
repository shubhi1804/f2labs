/**
 * @author Mukesh Chawla
 * @email Mukesh.chawla@utilitarianlab.com
 * @create date 2022-10-03 00:49:05
 * @modify date 2022-10-03 00:49:05
 * @desc Salesforce Analyst - UtilitarianLab Pvt. Ltd.
 */

public with sharing class Opp_QuotesHandler {
    
    @AuraEnabled(cacheable=true)
    public static list<SBQQ__QuoteLine__c> Quotes_UnderOpps(Id OppId){
        System.debug('OppId ====> ' + OppId);

        list<SBQQ__QuoteLine__c> QuoteLineItems = new List<SBQQ__QuoteLine__c>();
        List<SBQQ__Quote__c> QuotesList = [Select Id, Name, SBQQ__Opportunity2__c, Percent_completed__c
                                            from SBQQ__Quote__c 
                                            Where SBQQ__Opportunity2__c =: OppId];
        
        Project__c Pro = [SELECT Account__c,Id,Opportunity__c FROM Project__c where Id=:OppId]; 
        List<SBQQ__Quote__c> QuotesListWithQuoteLineItems = [Select Id, Name, SBQQ__Opportunity2__c, Percent_completed__c,
                                                            (SELECT Completed_In_percent__c, Category__c,Class__c,Id,Name,SBQQ__Quote__c,SBQQ__ProductFamily__c,SBQQ__ProductName__c,SBQQ__Description__c FROM SBQQ__LineItems__r)
                                                            from SBQQ__Quote__c 
                                                            Where SBQQ__Opportunity2__c =: Pro.Opportunity__c AND SBQQ__Primary__c = true];
        System.debug('QuotesList =====> ' + QuotesList);
        
        QuoteLineItems = QuotesListWithQuoteLineItems[0].SBQQ__LineItems__r; 
            return QuoteLineItems;
    }


    @AuraEnabled
    public static String Save_Quote(list<SBQQ__QuoteLine__c>  UpdatedQuoteList){
        string msg = '';
        try {

            System.debug('UpdatedQuoteList =====> ' + UpdatedQuoteList);
            update UpdatedQuoteList;
            // if (UpdatedQuoteList.id != null) {
            //     msg = 'Success';
            // }
            msg = 'Success';
            
        } catch (Exception e) {
            System.debug('the error has occured ====> ' + e.getMessage() + ' at line number =====> ' + e.getLineNumber());
        }
        return msg;
    }
}