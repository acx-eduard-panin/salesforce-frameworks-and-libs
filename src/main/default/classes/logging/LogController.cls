public with sharing class LogController {
	private static LogService service = new LogService();

	@AuraEnabled
	public static List<LogRecord__c> search(Datetime fromDate, Datetime toDate) {
		return service.search(fromDate, toDate);
	}
}
