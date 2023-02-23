public with sharing class PersonValidationService {

    public static void validatePhone(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        Person__c newPerson = (Person__c) newItems.values()[0];
        Person__c oldPerson = null;

        if (oldItems != null) {
            oldPerson = (Person__c) oldItems.get(newPerson.Id);
        }
    
        if (!String.isBlank(newPerson.Phone__c)) {
            
            PhoneValidator.validate(newPerson.Id, newPerson.Name, newPerson.Phone__c, 'Phone__c', newPerson.Country__c);
            
        }

        // if (!String.isBlank(newPerson.WorkPhone__c)) {
        //     if (oldPerson == null || newPerson.WorkPhone__c != oldPerson.WorkPhone__c){
        //         PhoneValidator.validate(newPerson.Id, newPerson.Name, newPerson.WorkPhone__c, 'WorkPhone__c', newPerson.Country__c);
        //     }
        // }
        
    }

}