public with sharing class ContactService {
	private static Boolean stopRecursive = false;
	private static Map<String, Set<Integer>> stopRecursiveMap = new Map<String, Set<Integer>>{
			'INSERT' => new Set<Integer>()
	};

	public static void updateContactAvoidRecursiveIncorrect(List<Contact> contacts) {
		if (stopRecursive) {
			return;
		}

		for (Contact contact : contacts) {
			Log.debug('Incorrect. New Contact has been created. Record Id: {0}', new List<String>{ contact.Id });
		}

		stopRecursive = true;
	}

	public static void updateContactAvoidRecursiveCorrect(List<Contact> contacts) {
		if (stopRecursiveMap.get('INSERT').contains(Trigger.new.hashCode())) {
			return;
		}

		for (Contact contact : contacts) {
			Log.debug('Correct. New Contact has been created. Record Id: {0}', new List<String>{ contact.Id });
		}

		stopRecursiveMap.get('INSERT').add(Trigger.new.hashCode());
	}
}
