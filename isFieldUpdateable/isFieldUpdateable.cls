public static Boolean isFieldUpdateable(String objectApiName, String fieldName) {
  Schema.DescribeSObjectResult objectDescription  = Schema.getGlobalDescribe().get(objectApiName).getDescribe();
  Schema.DescribeFieldResult field = objectDescription.fields.getMap().get(fieldName).getDescribe();
  
  return field != null && field.isUpdateable();
}
