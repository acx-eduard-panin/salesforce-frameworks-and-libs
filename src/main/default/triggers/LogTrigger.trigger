trigger LogTrigger on Log__e (after insert) {
	new LogService().create(Trigger.new);
}
