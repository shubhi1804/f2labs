public with sharing class SharePointCallout {
    @future(callout=true)
    public static void createFolder(Set<Id> proposalList){
        Map<Id,Project__c> pMap = new Map<Id,Project__c>([Select Id,Name,(Select Id,Name From Project_Documents__r) From Project__c Where Id In : proposalList]);
        for(Project__c pro : pMap.values()){
            String response = SharePointHandler.createFolderInsideSite('Projects/'+pro.Name);
            if(response=='Success'){
                for(Proposal_Document__c pd: pro.Project_Documents__r){
                    SharePointHandler.createFolderInsideSite('Projects/'+pro.Name+'/'+pd.Name);
                }
            }
        }
    }
    
    public static void createCustomFolder(String recordId, Integer fNumbers,List<String> expensesList, List<String> recDocs){
        Project__c pro = [Select Id,Name From Project__c Where Id=:recordId];
        for(Integer i = 1; i<=fNumbers; i++){
            String fName = i+'';
            
            if(i==1){
                fName += ' st';
            }else if(i==2){
                fName += ' nd';
            }else if(i==3){
                fName += ' rd';
            }else if(i==4 || i== 5 || i==6 || i==7 || i==8 || i==9){
                fName += ' th';
            }
            
            fName += ' '+expensesList[i-1];
            cFolder('Projects/'+pro.Name+'/'+fName);
        }
        
        for(String fName : recDocs){
            cFolder('Projects/'+pro.Name+'/'+fName);
        }
    }
    
    @future(callout=true)
    public static void cFolder(String folderName){
        SharePointHandler.createFolderInsideSite(folderName);
    }
}