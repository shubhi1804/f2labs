public class TestClass {
	
    public static void generateError(){
        for(integer i = 0;i < 52 ;i++){
            //List<Account> accList= [select id from account];
            childGenerateError();
        }
        //childGenerateError();
    }
    @future
    public static void childGenerateError(){
        for(integer i = 0;i < 50 ;i++){
            List<Account> accList = [select id from account];
        }
    }
    
}