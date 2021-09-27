public with sharing class Service {
	public static void getData() {
		Data.selectData();
		BusinessCalculation.calculate1();
		BusinessCalculation.calculate2();
		Data.createData();
		Integration.sendRequest();
	}
}
