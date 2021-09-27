public with sharing class Bindings2 extends di_Module {
	public override void configure() {
		bind(ServiceDI.class).to(ServiceDiImpl2.class);
		bind(DataDI.class).to(DataDiImpl2.class);
		bind(IntegrationDI.class).to(IntegrationDiImpl2.class);
		bind(BusinessCalculatorDI.class).to(BusinessCalculationDiImpl2.class);
	}
}
