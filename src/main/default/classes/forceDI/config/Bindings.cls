public with sharing class Bindings extends di_Module {
	public override void configure() {
		bind(ServiceDI.class).to(ServiceDiImpl.class);
		bind(DataDI.class).to(DataDiImpl.class);
		bind(IntegrationDI.class).to(IntegrationDiImpl.class);
		bind(BusinessCalculatorDI.class).to(BusinessCalculationDiImpl.class);
	}
}
