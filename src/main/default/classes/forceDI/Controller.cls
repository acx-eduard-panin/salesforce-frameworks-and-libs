public with sharing class Controller {
	@AuraEnabled
	public static String getCalculatedData() {
		Service.getData();
		return null;
	}

}
