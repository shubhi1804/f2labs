/**
 * @author [Dinesh B]
 * @email dinesh.b@utilitarianLab.com
 * @create date 2022-07-11 17:58:07
 * @modify date 2022-07-11 17:58:07
 * @desc [description]t
 */

public class OppCloneController {

    static final String SELECT_CLAUSE = 'SELECT ';
    static final String WHERE_CLAUSE = 'WHERE';
    
    @AuraEnabled(cacheable=true)
    public Static Opportunity getFieldFromFieldSet(String oppId){
        List<Schema.FieldSetMember> getListOfFieldSet = SobjectType.Opportunity.FieldSets.FiledSet_Opp.getFields();
        List<String> opportunityFieldSet = new List<String>();
        try{
            for(Schema.FieldSetMember fieldsToAdd : getListOfFieldSet){
                opportunityFieldSet.add(String.valueOf(fieldsToAdd.sobjectfield));
            }
            String query = SELECT_CLAUSE + String.join(opportunityFieldSet, ',');
            query += ' FROM Opportunity '+WHERE_CLAUSE+' Id =: oppId';
            return Database.query(query);
        }catch(QueryException e){
            System.debug('Erron Message '+e.getMessage());
            System.debug('Erron Lineno '+e.getLineNumber());
        }
        return null;
    }
}