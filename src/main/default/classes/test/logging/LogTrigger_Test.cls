@IsTest
private class LogTrigger_Test {
	@IsTest
	private static void agoroLogRecord_insert_test() {
		String message = 'Test';
		Test.startTest();
		insert new SystemSettings__c(LogFrom__c = System.today().addDays(-1), LogTo__c = System.today().addDays(1));
		Log.error(message);
		Test.stopTest();

		System.assertEquals(message, [SELECT Id, Message__c FROM LogRecord__c]?.Message__c);
	}
}
