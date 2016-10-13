public static String getSObjectKeyPrefix(String objectApiName) {
  SObjectType objectSchema = Schema.getGlobalDescribe().get(objectApiName);
  Schema.DescribeSObjectResult objectDescription = objectSchema.getDescribe();
  
  return objectDescription.getKeyPrefix();
}
