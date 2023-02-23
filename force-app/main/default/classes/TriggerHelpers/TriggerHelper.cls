public with sharing class TriggerHelper {
    public static Boolean disabled = false;
    public static void triggerDispatcher(System.TriggerOperation operation){

        if (disabled == false) {
            switch on operation{
                when AFTER_INSERT{
                    PersonValidationService.validatePhone(Trigger.newMap, Trigger.oldMap);
                }
                when AFTER_UPDATE{
                    PersonValidationService.validatePhone(Trigger.newMap, Trigger.oldMap);
                }
            }
        }
        
    }
}