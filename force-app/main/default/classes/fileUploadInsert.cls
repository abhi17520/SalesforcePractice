public with sharing class fileUploadInsert {
    @AuraEnabled
    public static void insertFile(Id recordId, String base64Data, String filename){
        try {
            ContentVersion cv = new ContentVersion();
            cv.title = 'testFile_'+recordId;
            cv.pathOnClient = filename;
            cv.VersionData = Blob.ValueOf(base64Data);
            cv.ContentLocation = 'S';
            cv.IsMajorVersion = true;
            cv.Origin = 'C';
            Database.Insert(cv);

            ContentDocumentLink cdl = New ContentDocumentLink();
            cdl.LinkedEntityId = recordId;
            cdl.ContentDocumentId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cv.Id].ContentDocumentId;
            cdl.shareType = 'I';
            cdl.Visibility = 'AllUsers';
            Database.Insert(cdl);
        } catch (Exception e) {
            System.debug('Error : '+ e.getMessage() + ' Stack Trace : '+ e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }
}