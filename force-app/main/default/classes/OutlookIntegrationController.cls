public class OutlookIntegrationController {

    public string authtoken{get;set;} 

    public string refereshtoken{get;set;}

    public string bodyprint{get;set;}

    public string Email{get;set;}

    public String FullName{get;set;}

    public String UserId{get;set;}

    public static final string CLIENT_SECRET='B788Q~vXo997LIGyc72aeywlo-Jcy5GPL-zNWcX_'; 

    public static final string CLIENT_ID = '4db19746-d8da-4f99-8aa3-2b36b5b7dc40';

    public static final string REDIRECT_URL = 'https://f2labs--ullabs--c.sandbox.vf.force.com/apex/OutlookIntegration';

    public static final string OAUTH_TOKEN_URL= 'https://login.microsoftonline.com/common/oauth2/v2.0/token';

    public static final string OAUTH_CODE_END_POINT_URL= 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize';

    public static final string GRANT_TYPE= 'grant_type=authorization_code';

    public static final string SCOPE= 'https://outlook.office.com/mail.read';

    public static final string STATE= '/profile';

    //Approval Prompt Constant

    //public static final string APPROVAL_PROMPT=’force’;    

    public pagereference connect(){        

        String x=OAUTH_CODE_END_POINT_URL+'?scope='+EncodingUtil.urlEncode(SCOPE,'UTF-8')+'&state='+EncodingUtil.urlEncode(STATE,'UTF-8')+'&redirect_uri='+EncodingUtil.urlEncode(REDIRECT_URL,'UTF-8')+'&response_type=code&client_id='+CLIENT_ID;

        pagereference p=new pagereference(x);

        return p;        

    }                         

    public pagereference showtoken(){

        string codeparam = apexpages.currentpage().getparameters().get('code');

        Http h = new Http();
        system.debug('codeparam'+codeparam);
        String body= 'code='+codeparam+'&client_id='+CLIENT_ID+'&client_secret='+CLIENT_SECRET+'&redirect_uri='+REDIRECT_URL+'&'+GRANT_TYPE;

        HttpRequest req = new HttpRequest();

        req.setEndpoint(OAUTH_TOKEN_URL);

        req.setHeader('Content-Type','application/x-www-form-urlencoded');

        req.setMethod('POST');

        req.setBody(body); 

        system.debug('REQUEST BODY'+body);

        HttpResponse res = h.send(req);

        system.debug('body'+res.getbody());

        getAccessToken getAccessTokenFromGmailApi = (getAccessToken)JSON.deserialize(res.getBody(), getAccessToken.class);

        system.debug('getAccessTokenFromGmailApi'+getAccessTokenFromGmailApi.access_token);

        authtoken = getAccessTokenFromGmailApi.access_token;

        system.debug('authtoken:::'+authtoken);

        bodyprint=res.getbody();

        return null;        

    } 

    public pagereference getInfo(){ 

        System.debug('authtoken>>'+authtoken);

        Http http = new Http();  

        HttpRequest request = new HttpRequest();

        request.setEndpoint('https://outlook.office.com/api/v2.0/me');

        request.setMethod('GET'); 

        request.setHeader('Authorization', 'Bearer '+authtoken);

        request.setHeader('Accept','application/json');  

        request.setHeader('Prefer', 'outlook.allow-unsafe-html');

        system.debug('req—–>>>>'+request);

        HttpResponse response = http.send(request);

        system.debug('*****response*******'+response.getBody());

        JsonParser getName = (JsonParser)JSON.deserialize(response.getBody(),JsonParser.class);

        system.debug('getName::::'+getName.EmailAddress);

        Email = getName.EmailAddress;
        
        FullName = getName.DisplayName;
        
        UserId = getName.userid;

        System.debug(response);

        if (response.getStatusCode() != 201) {

            System.debug('The status code returned was not expected: '+response.getStatusCode() +' - '  + response.getStatus());   

        } else { 

            System.debug(response.getBody());

        }   

        return null; 

    }  

    public class getAccessToken {

        public String access_token {get; set;}

        public String token_type {get; set;}

        public String expires_in {get; set;}

        public String scope {get; set;}
        
    }
    public class JsonParser{
        public String EmailAddress{get;set;}
        public String DisplayName{get;set;}
        public String Id{get;set;}
        public String Alias{get;set;}
        public String userid{get;set;}
        public String MailboxGuid{get;set;}
        public String context{get;set;}
    }
}