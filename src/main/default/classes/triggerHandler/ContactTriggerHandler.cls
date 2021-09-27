public with sharing class ContactTriggerHandler extends TriggerHandler {
	public override void afterUpdate() {
		ContactService.updateContactAvoidRecursiveCorrect((List<Contact>) Trigger.new);
		ContactService.updateContactAvoidRecursiveIncorrect((List<Contact>) Trigger.new);
	}
}
