public with sharing class Calculator extends RestRoute {
	public override String getMapping() {
		return 'calculator';
	}

	protected override Object doPost() {
		Map<String, Object> request = buildRequestBodyAsMap(this.request.requestBody);
		//do something
		return new Map<String, Object>{
				'status' => 'success',
				'amount' => 5000
		};
	}

	public static Map<String, Object> buildRequestBodyAsMap(Blob requestBody) {
		if (requestBody == null) {
			return null;
		}
		try {
			return (Map<String, Object>) JSON.deserializeUntyped(requestBody.toString());
		} catch (Exception ex) {
			return null;
		}
	}
}
