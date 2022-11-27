public class getMessage{
    
    public list<value> value{get;set;}
    
    public class value{
        
        public String InferenceClassification{get;set;}
        
        public String WebLink{get;set;}
        
        public Body Body{get;set;}
        
        public Boolean IsDraft{get;set;}
        
        public String ConversationIndex{get;set;}
        
        public String ConversationId{get;set;}
        
        public String IsDeliveryReceiptRequested{get;set;}
        
        public String ParentFolderId{get;set;}
        
        public Boolean IsReadReceiptRequested{get;set;}
        
        public String Importance{get;set;}
        
        public Boolean IsRead{get;set;}
        
        public String BodyPreview{get;set;}
        
        public String InternetMessageId{get;set;}
        
        public Boolean HasAttachments{get;set;}
        
        public String Subject{get;set;}
        
        public String SentDateTime{get;set;}
        
        public Sender Sender{get;set;}
        
        public String ReceivedDateTime{get;set;}
        
        public list<String> Categories{get;set;}
        
        public String ChangeKey{get;set;}
        
        public list<ToRecipients> ToRecipients{get;set;}
        
        public String LastModifiedDateTime{get;set;}
        
        public list<String> CcRecipients{get;set;}
        
        public String CreatedDateTime{get;set;}
        
        public list<String> BccRecipients{get;set;}
        
        public String Id{get;set;}
        
        public list<ReplyTo> ReplyTo{get;set;}
        
        public Flag Flag{get;set;}
        
    }
    
    public class ToRecipients{
        
        public EmailAddress EmailAddress{get;set;}
        
    }
    
    public class Sender{
        
        public EmailAddress EmailAddress{get;set;}
        
    }
    
    public class ReplyTo{
        
        public EmailAddress EmailAddress{get;set;}
        
    }
    
    public class Flag{
        
        public String FlagStatus{get;set;}
        
    }
    
    public class EmailAddress{
        
        public String Name{get;set;}
        
        public String Address{get;set;}
        
    }
    
    public class Body{
        
        public String ContentType{get;set;}
        
        public String Content{get;set;}
        
    }
    
}