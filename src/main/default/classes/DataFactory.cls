@IsTest
private class DataFactory {
	private static final String OBJECT_NAME = TestDataFactory__c.getSObjectType().getDescribe().getName();
	@IsTest
	private static void createRecordWithRequiredFields_test() {
		TestDataFactory__c testDataFactory = (TestDataFactory__c) TestDataFactory.createSObject(OBJECT_NAME);

		TestDataFactory__c result = [SELECT Id, Account__c, DateField__c FROM TestDataFactory__c WHERE Id = :testDataFactory.Id LIMIT 1];

		System.assert(result.Account__c != null, 'Required Lookup Field should be prepared');
		System.assert(result.DateField__c != null, 'Required Date Field should be prepared');
	}

	@IsTest
	private static void createRecordWithAdditionalFields_test() {
		TestDataFactory__c testDataFactory = (TestDataFactory__c) TestDataFactory.createSObject(
				OBJECT_NAME,
				new Map<String, Object>{
						'NotRequiredTextField__c' => TestDataFactory.DEFAULT_VALUE
				}
		);

		TestDataFactory__c result = [SELECT Id, NotRequiredTextField__c FROM TestDataFactory__c WHERE Id = :testDataFactory.Id LIMIT 1];

		System.assert(result.NotRequiredTextField__c != null, 'Not Required Lookup Field should be prepared');
	}

	@IsTest
	private static void createRecordWithActiveValidationRule_test() {
		String expectedExceptionType;
		try {
			TestDataFactory.createSObject(
					OBJECT_NAME,
					new Map<String, Object>{
							'FieldWithValidationRule__c' => TestDataFactory.DEFAULT_VALUE
					}
			);
		} catch (Exception ex) {
			expectedExceptionType = ex.getTypeName();
		}

		System.assertEquals('TestDataFactory.TestDataFactoryException', expectedExceptionType, 'Test Data Factory does not Support Validation Rule');
	}

	@IsTest
	private static void createUser_test() {
		String expectedExceptionType;
		try {
			TestDataFactory.createSObject('User');
		} catch (Exception ex) {
			expectedExceptionType = ex.getTypeName();
		}

		System.assertEquals('TestDataFactory.TestDataFactoryException', expectedExceptionType, 'Test Data Factory does not Support System Objects');
	}
}
