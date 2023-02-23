@isTest
private class PhoneValidationServiceTest {
    @isTest static void PhoneValidationServiceTest_Insert_Phone_Is_Valid() {
        TriggerHelper.disabled = true;
        Person__c newPerson = new Person__c(Email__c = 'example@gmail.com', First_Name__c = 'name', Last_Name__c = 'lastname', Phone__c = '+381654699581');
        string body = '{"Items":[{"PhoneNumber":"+381654699581","RequestProcessed":true,"IsValid":"Yes","NetworkCode":"03","NetworkName":"Telekom Srbija ad Beograd (mts)","NetworkCountry":"RS","NationalFormat":"065 4699581","CountryPrefix":381,"NumberType":"Mobile"}]}';
        HttpMockFactory mock = new HttpMockFactory(200, 'OK', body, new Map<String,String>());
        Test.setMock(HttpCalloutMock.class, mock);
      
        Test.startTest();
        insert newPerson;
        PersonValidationService.validatePhone( new Map<Id, SObject>{newPerson.Id => (SObject) newPerson}, null);
        Test.stopTest();
        List<Phone_Validation_Result__c> lastPVR = [select Id, PhoneNumber__c, RequestProcessed__c, IsValid__c, NetworkCode__c, NetworkName__c,NetworkCountry__c, NationalFormat__c, CountryPrefix__c, NumberType__c from Phone_Validation_Result__c ];
        System.debug(lastPVR);
        System.assertEquals(lastPVR[0].PhoneNumber__c, '+381654699581');
        System.assertEquals(lastPVR[0].RequestProcessed__c, true);
        System.assertEquals(lastPVR[0].IsValid__c, 'Yes');
        System.assertEquals(lastPVR[0].NetworkCode__c, '03');
        System.assertEquals(lastPVR[0].NetworkName__c, 'Telekom Srbija ad Beograd (mts)');
        System.assertEquals(lastPVR[0].NetworkCountry__c, 'RS');
        System.assertEquals(lastPVR[0].NationalFormat__c, '065 4699581');
        System.assertEquals(lastPVR[0].CountryPrefix__c, 381);
        System.assertEquals(lastPVR[0].NumberType__c, 'Mobile');
    }
    // @isTest static void PhoneValidationServiceTest_Insert_Phone_Null() {
    //     TriggerHelper.disabled = true;
    //     Person__c newPerson = new Person__c(Email__c = 'example@gmail.com', First_Name__c = 'name', Last_Name__c = 'lastname', Phone__c = '');
    //     Test.startTest();
    //     PersonValidationService.validatePhone(newPerson, null);
    //     Test.stopTest();
    //     Integer count = [select count() from Phone_Validation_Result__c where Person__c = :newPerson.Id];
    
    //     System.assertEquals(count, 0);
    // }
    // @isTest static void PhoneValidationServiceTest_Insert_Phone_Error() {
    //     TriggerHelper.disabled = true;
    //     Person__c newPerson = new Person__c(Email__c = 'example@gmail.com', First_Name__c = 'name', Last_Name__c = 'lastname', Phone__c = '+381654699581');
    //     string body = '{"Items":[{"Error":"1001","Description":"Number Required","Cause":"The phone numbers is required.","Resolution":"Please ensure that you supply a phone number and try again."}]}';
    //     HttpMockFactory mock = new HttpMockFactory(200, 'OK', body, new Map<String,String>());
    //     Test.setMock(HttpCalloutMock.class, mock);
    //     Test.startTest();
    //     PersonValidationService.validatePhone(newPerson, null);
    //     Test.stopTest();
    //     Phone_Validation_Result__c lastPVR = [select Id, Person__c, Id__c, Error__c, Cause__c, Resolution__c from Phone_Validation_Result__c order by CreatedDate desc limit 1];
    
    //     System.assertEquals(lastPVR.Person__c, newPerson.Id); 
    //     System.assertEquals(lastPVR.Id__c, 1001); 
    //     System.assertEquals(lastPVR.Error__c, 'Number Required');
    //     System.assertEquals(lastPVR.Cause__c, 'The phone numbers is required.');
    //     System.assertEquals(lastPVR.Resolution__c, 'Please ensure that you supply a phone number and try again.');

    // }
    // @isTest static void PhoneValidationServiceTest_Update_Phone_Is_Valid() {
    //     TriggerHelper.disabled = true;
    //     Person__c oldPerson = new Person__c(Email__c = 'example@gmail.com', First_Name__c = 'name', Last_Name__c = 'lastname', Phone__c = '+381654699581');
    //     Person__c newPerson = new Person__c(Email__c = 'example@gmail.com', First_Name__c = 'name', Last_Name__c = 'lastname', Phone__c = '+381654699582');
    //     string body = '{"Items":[{"PhoneNumber":"+381654699581","RequestProcessed":true,"IsValid":"Yes","NetworkCode":"03","NetworkName":"Telekom Srbija ad Beograd (mts)","NetworkCountry":"RS","NationalFormat":"065 4699581","CountryPrefix":381,"NumberType":"Mobile"}]}';
    //     HttpMockFactory mock = new HttpMockFactory(200, 'OK', body, new Map<String,String>());
    //     Test.setMock(HttpCalloutMock.class, mock);
    //     Test.startTest();
    //     PersonValidationService.validatePhone(newPerson, oldPerson);
    //     Test.stopTest();
    //     Phone_Validation_Result__c lastPVR = [select Id, PhoneNumber__c, RequestProcessed__c, IsValid__c, NetworkCode__c, NetworkName__c,NetworkCountry__c, NationalFormat__c, CountryPrefix__c, NumberType__c from Phone_Validation_Result__c order by CreatedDate desc limit 1];
        
    //     System.assertEquals(lastPVR.PhoneNumber__c, '+381654699581');
    //     System.assertEquals(lastPVR.RequestProcessed__c, true);
    //     System.assertEquals(lastPVR.IsValid__c, 'Yes');
    //     System.assertEquals(lastPVR.NetworkCode__c, '03');
    //     System.assertEquals(lastPVR.NetworkName__c, 'Telekom Srbija ad Beograd (mts)');
    //     System.assertEquals(lastPVR.NetworkCountry__c, 'RS');
    //     System.assertEquals(lastPVR.NationalFormat__c, '065 4699581');
    //     System.assertEquals(lastPVR.CountryPrefix__c, 381);
    //     System.assertEquals(lastPVR.NumberType__c, 'Mobile');
    // }
    // @isTest static void PhoneValidationServiceTest_Update_Workphone_Is_Valid() {
    //     TriggerHelper.disabled = true;
    //     Person__c oldPerson = new Person__c(Email__c = 'example@gmail.com', First_Name__c = 'name', Last_Name__c = 'lastname', WorkPhone__c = '+381654699581');
    //     Person__c newPerson = new Person__c(Email__c = 'example@gmail.com', First_Name__c = 'name', Last_Name__c = 'lastname', WorkPhone__c = '+381654699582');
    //     string body = '{"Items":[{"PhoneNumber":"+381654699582","RequestProcessed":true,"IsValid":"Yes","NetworkCode":"03","NetworkName":"Telekom Srbija ad Beograd (mts)","NetworkCountry":"RS","NationalFormat":"065 4699582","CountryPrefix":381,"NumberType":"Mobile"}]}';
    //     HttpMockFactory mock = new HttpMockFactory(200, 'OK', body, new Map<String,String>());
    //     Test.setMock(HttpCalloutMock.class, mock);
    //     Test.startTest();
    //     PersonValidationService.validatePhone(newPerson, oldPerson);
    //     Test.stopTest();
    //     Phone_Validation_Result__c lastPVR = [select Id, PhoneNumber__c, RequestProcessed__c, IsValid__c, NetworkCode__c, NetworkName__c,NetworkCountry__c, NationalFormat__c, CountryPrefix__c, NumberType__c from Phone_Validation_Result__c order by CreatedDate desc limit 1];
        
    //     System.assertEquals(lastPVR.PhoneNumber__c, '+381654699581');
    //     System.assertEquals(lastPVR.RequestProcessed__c, true);
    //     System.assertEquals(lastPVR.IsValid__c, 'Yes');
    //     System.assertEquals(lastPVR.NetworkCode__c, '03');
    //     System.assertEquals(lastPVR.NetworkName__c, 'Telekom Srbija ad Beograd (mts)');
    //     System.assertEquals(lastPVR.NetworkCountry__c, 'RS');
    //     System.assertEquals(lastPVR.NationalFormat__c, '065 4699581');
    //     System.assertEquals(lastPVR.CountryPrefix__c, 381);
    //     System.assertEquals(lastPVR.NumberType__c, 'Mobile');
    // }
}