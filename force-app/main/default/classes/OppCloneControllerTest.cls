@isTest
public class OppCloneControllerTest {
    
    @isTest 
    static void ValidateClass(){        
        test.startTest();
        
        Opportunity opp =new Opportunity();
        opp.Name = 'Abc';
        opp.CloseDate = System.today();
        opp.StageName = 'Prospecting';
        insert opp;
        
        OppCloneController.getFieldFromFieldSet(opp.Id);
        
        test.stopTest();
    }
}