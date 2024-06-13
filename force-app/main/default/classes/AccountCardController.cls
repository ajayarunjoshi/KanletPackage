/* Purpose:-
 * Created By:
 * User story:
 * Date:-
 * */

public class AccountCardController {

    @AuraEnabled(cacheable=true)
    public static List <K_Processed_Contact__c> kProcessedContact(string accountId){
        
       List<K_Processed_Contact__c> kpc= [SELECT Id,K_Contact__r.Contact__r.AccountId,Contact_Status__c
                                          FROM K_Processed_Contact__c
                                          WHERE K_Contact__r.Contact__r.AccountId=:accountId AND Action_Taken__c != 'No Action Taken'  ];
       
       return kpc;
        
    }
}