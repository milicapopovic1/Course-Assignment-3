public with sharing class PhoneValidator {
    @future(callout = true)
    public static void validate (ID personId, string personName, string personPhone, string validatedFieldName, string personCountry) {
        string country = '';
        
        if (!String.isBlank(personCountry)) {
            country = personCountry;
        }
        else country = PersonDefaults__c.getInstance(UserInfo.getUserId()).Country__c;

        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint(API_Key__c.getInstance(UserInfo.getUserId()).Api_link__c + 'Key=' + API_Key__c.getInstance(UserInfo.getUserId()).Personal_Key__c + '&Phone=' + personPhone + '&Country=' + country);
        HttpResponse httpResponse = http.send(req);
        Phone_Validation_Result__c pvr = new Phone_Validation_Result__c();
        pvr.Name = personName + ' ' + personPhone;
        pvr.Person__c = personId;
        if (httpResponse.getstatuscode() == 200){
            JSON2APEX obj = JSON2APEX.parse(httpResponse.getBody());
            if (obj.items[0].phoneNumber != null) {
                pvr.PhoneNumber__c = obj.items[0].phoneNumber;
                pvr.RequestProcessed__c = obj.items[0].requestProcessed;
                pvr.IsValid__c = obj.items[0].isValid;
                pvr.NetworkCode__c = obj.items[0].networkCode;
                pvr.NetworkName__c = obj.items[0].networkName;
                pvr.NetworkCountry__c = obj.items[0].networkCountry;
                pvr.NationalFormat__c = obj.items[0].nationalFormat;
                pvr.CountryPrefix__c = obj.items[0].countryPrefix;
                pvr.NumberType__c = obj.items[0].numberType;
                pvr.PhoneNumberToValidate__c = personPhone;
                pvr.APIName__c = validatedFieldName;
            } 
            else {
                pvr.Id__c = obj.items[0].error;
                pvr.Error__c = obj.items[0].description;
                pvr.Cause__c = obj.items[0].cause;
                pvr.Resolution__c = obj.items[0].resolution;
                pvr.PhoneNumberToValidate__c = personPhone;
                pvr.APIName__c = validatedFieldName;
            }
        }
        System.debug(pvr);
        Database.insert(pvr,false);
    }
}