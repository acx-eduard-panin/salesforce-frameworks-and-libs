public with sharing class TriggerDemo {
	public static void doRecursiveTrigger() {
		Contact contact = new Contact(FirstName='Test', LastName='1');
		insert contact;

		contact.LastName = '2';
		update contact;
		update contact;

		contact.LastName = '3';
		update contact;
	}
}
