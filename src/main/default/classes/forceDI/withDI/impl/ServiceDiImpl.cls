public with sharing class ServiceDiImpl implements ServiceDI{
	private DataDI dataDI = (DataDI) di_Injector.Org.getInstance(DataDI.class);
	private BusinessCalculatorDI businessCalculatorDI = (BusinessCalculatorDI) di_Injector.Org.getInstance(BusinessCalculatorDI.class);
	private IntegrationDI integrationDI = (IntegrationDI) di_Injector.Org.getInstance(IntegrationDI.class);

	public void getData() {
		dataDI.selectData();
		businessCalculatorDI.calculate1();
		businessCalculatorDI.calculate2();
		dataDI.createData();
		integrationDI.sendRequest();
	}
}
