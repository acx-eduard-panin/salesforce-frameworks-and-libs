public with sharing class LogService {
	public List<LogRecord__c> search(Datetime fromDate, Datetime toDate) {
		if (fromDate == null || toDate == null) {
			return new List<LogRecord__c>();
		}

		return [
				SELECT
						Class__c,
						Context__c,
						Level__c,
						Line__c,
						Message__c,
						Method__c,
						User__c,
						CreatedDate
				FROM LogRecord__c
				WHERE CreatedDate >= :fromDate AND CreatedDate <= :toDate.addDays(1)
				ORDER BY CreatedDate
		];
	}

	public void create(List<Log__e> events) {
		if (!Log.LOG_VIA_EVENTS || events == null) {
			return;
		}
		List<LogRecord__c> records = new List<LogRecord__c>();
		for (Log__e event : events) {
			LogRecord__c record = new LogRecord__c();
			record.Class__c = event.Class__c;
			record.Context__c = event.Context__c;
			record.Level__c = event.Level__c;
			record.Line__c = event.Line__c;
			record.Message__c = event.Message__c;
			record.Method__c = event.Method__c;
			record.User__c = event.User__c;

			records.add(record);
		}

		insert records;
	}
}
