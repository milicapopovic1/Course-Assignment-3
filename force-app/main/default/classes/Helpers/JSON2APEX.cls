public with sharing class JSON2APEX {

        public List<Items> items;
     
        public class Items {
            public Integer Error;
            public String Description;
            public String Cause;
            public String Resolution;

            public String PhoneNumber;
            public Boolean RequestProcessed;
            public String IsValid;
            public String NetworkCode;
            public String NetworkName;
            public String NetworkCountry;
            public String NationalFormat;
            public Integer CountryPrefix;
            public String NumberType;
        }
     
         
        public static JSON2Apex parse(String json) {
            return (JSON2Apex) System.JSON.deserialize(json, JSON2Apex.class);
        }

}