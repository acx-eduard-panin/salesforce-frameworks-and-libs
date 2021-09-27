public with sharing class ControllerDI {
	private static ServiceDI serviceDI = (ServiceDI) di_Injector.Org.getInstance(ServiceDI.class);

	@AuraEnabled
	public static String getCalculatedData() {
		serviceDI.getData();
		return null;
	}
}
