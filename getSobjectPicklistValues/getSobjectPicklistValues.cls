public static List<SelectOption> getSobjectPicklistValues(String sObjectName, String fieldName) {
  List<Schema.PicklistEntry> picklistValues = Utils.getSobjectPicklist(sObjectName, fieldName);

  return Utils.createOptionList(picklistValues);
}

private static List<Schema.PicklistEntry> getSobjectPicklist(String sObjectName, String fieldName) {
  Schema.DescribeSObjectResult sObjectDescription = Schema.getGlobalDescribe().get(sObjectName).getDescribe();
  Schema.DescribeFieldResult sObjectField = sObjectDescription.fields.getMap().get(fieldName).getDescribe();

  return sObjectField.getPickListValues();
}

private static List<SelectOption> createOptionList(List<Schema.PicklistEntry> picklistValues) {
  List<SelectOption> options = new List<SelectOption>();

  for (Schema.PicklistEntry picklistValue : picklistValues) {
    if (!picklistValue.isActive()) {
      continue;
    }

    options.add(new SelectOption(picklistValue.getValue(), picklistValue.getLabel()));
  }

  return options;
}
