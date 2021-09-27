@IsTest
private class Log_Test {
    @IsTest
    private static void debug() {
        enableLogEvents(null);
        String message = '{0}=={1}:{2}';
        List<Object> values = new List<Object>{ 1, '2', false };
        Log.debug(message, values);
        Log__e log = Log.currentEvent;

        System.assertEquals('1==2:false', log.Message__c);
        System.assertEquals(LoggingLevel.DEBUG.name(), log.Level__c);
        System.assertEquals(Request.getCurrent().getRequestId() + '/' + Request.getCurrent().getQuiddity(), log.Context__c);
        System.assertEquals(thisClassName(), log.Class__c);
        System.assertEquals('debug', log.Method__c);
        System.assertEquals(8, log.Line__c);
    }

    @IsTest
    private static void error() {
        enableLogEvents(null);
        Log.error('');

        System.assertEquals(LoggingLevel.ERROR.name(), Log.currentEvent.Level__c);
    }

    @IsTest
    private static void timestampWhenNoContextId() {
        enableLogEvents(null);
        Log.debug('');

        System.assertNotEquals(null, Log.currentEvent.Context__c);
    }

    @IsTest
    private static void noEventsSendWhenDisabled() {
        Log.debug('');

        System.assertEquals(null, Log.currentEvent);
    }

    @IsTest
    private static void noEventsWhenExpired() {
        enableLogEvents(yesterday());
        Log.debug('');

        System.assertEquals(null, Log.currentEvent);
    }

    private static Date yesterday() {
        return System.today().addDays(-1);
    }

    private static String thisClassName() {
        String ns = [SELECT NamespacePrefix FROM Organization].NamespacePrefix + '.';
        return Log_Test.class.getName().removeStart(ns);
    }

    public static void enableLogEvents(Date day) {
        day = day == null ? System.today() : day;
        insert new SystemSettings__c(LogFrom__c = day, LogTo__c = day);
    }
}
