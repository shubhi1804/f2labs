global class CreateEmailActivity implements messaging.InboundEmailHandler {
    global messaging.InboundEmailresult handleInboundEmail(messaging.InboundEmail email, messaging.InboundEnvelope envelope){
        try{
            Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
            String myPlainText= '';
            List<Attachment> attachments = new List<Attachment>();
            List<Messaging.EmailFileAttachment> attachmentList = new List<Messaging.EmailFileAttachment>();
            List<string> toEmailAddresss = new List<string>();
            List<string> ccEmailAddresss = new List<string>();
            system.debug('email'+ email);
            system.debug('email-inReplyTo'+ email.inReplyTo);
            
            string senderName = email.fromname;
            String fromEmailAddress = email.fromAddress;
            toEmailAddresss = email.toAddresses;
            ccEmailAddresss = email.ccAddresses;
            system.debug('fromEmailAddress>>>>'+fromEmailAddress);
            Messaging.InboundEmail.BinaryAttachment[] binaryAttachments = email.binaryAttachments;
            
            //
            List<Project__c> contacts = new List<Project__c>();
            system.debug('emailId'+email.references);
            system.debug('emailId'+email.messageId);
            
            if(email.references != null){
                contacts = [SELECT Id,Last_Email_Sent__c FROM Project__c where  Email_Message_Id__c = :email.references order BY Last_Email_Sent__c DESC NULLS LAST ];
            }else{
                contacts = [SELECT Id,Last_Email_Sent__c FROM Project__c where  Email_Message_Id__c = :email.messageId order BY Last_Email_Sent__c DESC NULLS LAST ];
            }
            System.debug('contacts '+ contacts);
            
            string subrecid = '' ;
            if(contacts.size() > 0){
                subrecid = contacts[0].Id;    
            }
            
            //contacts = [select id from Contact where email= :fromEmailAddress LIMIT 1];
            
            String htmlBody = email.htmlBody;
            String taskSubject = email.subject;
            System.debug('htmlBody:'+ htmlBody);
            
            if(contacts.size() > 0 && email.inReplyTo != null){
                
                EmailMessage quoEmailMessage = new EmailMessage();
                quoEmailMessage.ToAddress =  String.join(email.toAddresses, ',');
                quoEmailMessage.FromAddress =  email.FromAddress;
                quoEmailMessage.FromName = email.FromName;
                quoEmailMessage.Subject = email.subject;
                quoEmailMessage.status = '2';
                quoEmailMessage.HtmlBody = email.htmlBody;
                System.debug('htmlBody:>>>> ' + email.htmlBody );
                quoEmailMessage.Incoming= True;
                quoEmailMessage.TextBody = email.plainTextBody;
                System.debug('TextBody:>>>>> ' + email.plainTextBody);
                quoEmailMessage.RelatedToId = subrecid;
                insert quoEmailMessage;
                System.debug('Reply Email: ' + quoEmailMessage );  
                
                // Add Email Message Relation for id of the sender
                EmailMessageRelation emr = new EmailMessageRelation();
                emr.EmailMessageId = quoEmailMessage.id;
                emr.RelationAddress = email.FromAddress;
                emr.RelationType = 'FromAddress';
                insert emr;
                system.debug('>>>>>=='+ emr );            
            }
            return result;
        }
        catch(Exception e){
            System.debug('Exception :' + e.getMessage());
            System.debug('Line Number :' + e.getLineNumber());
            return null;
        }
        
    }
}