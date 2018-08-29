@RestResource(urlMapping='/v1.0/Candidate__c/*')
global with sharing class RestCallReceiver{
    @HttpGet
    global static List<Candidate__c> getRecord(){
        List<Candidate__c> lstQry = [Select Id, Name from Candidate__c Limit 10];
        List<Candidate__c> lstCandidate = new List<Candidate__c>();
        for(Candidate__c cd : lstQry){
                lstCandidate.add(cd);
        }
        return lstCandidate;
        //System.debug(lstCandidate.size());
    }
    
    @HttpPost
    global static String AddCandidate(String strF_Name, String strL_Name, String strYr_Of_Exp){
        Candidate__c objCandidate = new Candidate__c();
        if(strF_Name == '' || strL_Name == '' || strYr_Of_Exp == ''){
            objCandidate.First_Name__c = strF_Name;
            objCandidate.Last_Name__c = strL_Name;
            objCandidate.Years_of_Experience__c = decimal.valueOf(strYr_Of_Exp);
        }
        insert objCandidate;
        return objCandidate.Id;
    }
    
    @HttpDelete
    global static void deleteCandidate(){
        RestRequest req = RestContext.request;
        
        String candidateId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Candidate__c objCandidate = [Select Id from Candidate__c where Id =: candidateId ];
        delete objCandidate;
    }
}