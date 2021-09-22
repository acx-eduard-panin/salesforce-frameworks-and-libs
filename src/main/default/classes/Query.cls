@IsTest
private class Query {
	@IsTest
	private static void selectWithSubQuery_test() {
		TestDataFactory.createSObjectList(TestDataFactory__c.getSObjectType().getDescribe().getName(), 10);

		List<Account> accounts = new QueryBuilder(Account.class)
				.addFieldsAllUpdatable()
				.addSubQuery(
						new QueryBuilder('TestDataFactories__r')
								.addField(TestDataFactory__c.Name)
								.addField(TestDataFactory__c.DateField__c)
				)
				.setCheckCRUDAndFLS()
				.toList();

		System.debug(accounts[0].TestDataFactories__r);
		System.assertEquals(1, accounts[0].TestDataFactories__r.size());
	}

	@IsTest
	private static void selectWithExtract_test() {
		TestDataFactory.createSObjectList(Account.getSObjectType().getDescribe().getName(), 10);

		List<Object> accountNames = (List<Object>) new QueryBuilder(Account.class)
				.addFieldsAllUpdatable()
				.setCheckCRUDAndFLS()
				.extractField(Account.Name);

		System.debug(accountNames);
		System.assertEquals(10, accountNames.size());
	}

	@IsTest
	private static void selectWithCondition_test() {
		TestDataFactory.createSObjectList(Account.getSObjectType().getDescribe().getName(), 10);

		QueryBuilder queryBuilder = new QueryBuilder(Account.class)
				.addField(Account.Name)
				.addConditions()
				.add(new QueryBuilder.LikeCondition(Account.Name).likeAnyBoth('test'))
				.endConditions()
				.setCheckCRUDAndFLS();
		List<Account> accounts = queryBuilder.toList();

		System.debug(accounts);
		System.assertEquals(10, accounts.size());
		System.assertEquals('SELECT Name FROM Account WHERE Name LIKE \'%test%\'', getQueryAsString(queryBuilder));
	}

	@IsTest
	private static void selectWithMock_test() {
		TestDataFactory.createSObjectList(Account.getSObjectType().getDescribe().getName(), 10);

		QueryBuilder queryBuilder = new QueryBuilder(Account.class)
				.addField(Account.Name)
				.setCheckCRUDAndFLS()
				.buildStub()
				.addStubToList(new List<Account>{ new Account(Name = 'Test')})
				.applyStub();
		List<Account> accounts = queryBuilder.toList();

		System.debug(accounts);
		System.assertEquals(1, accounts.size());
	}

	@IsTest
	private static void selectFieldSet_test() {
		TestDataFactory.createSObjectList(Account.getSObjectType().getDescribe().getName(), 10);

		QueryBuilder queryBuilder = new QueryBuilder(Account.class)
				.addFieldSet('QueryBuilder')
				.setCheckCRUDAndFLS();
		List<Account> accounts = queryBuilder.toList();

		System.debug(accounts);
		System.assertEquals(10, accounts.size());
		System.assertEquals('SELECT Site, Fax, Phone FROM Account', getQueryAsString(queryBuilder));
	}

	private static String getQueryAsString(QueryBuilder queryBuilder) {
		return queryBuilder
				.toString()
				.replaceAll('\n', '')
				.replaceAll('\t', ' ')
				.replaceAll(' ,', ',');
	}

}
