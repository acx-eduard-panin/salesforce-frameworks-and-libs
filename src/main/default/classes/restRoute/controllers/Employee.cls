public with sharing class Employee extends RestRoute {
	private String companyId;
	public Employee(String companyId) {
		this.companyId = companyId;
	}

	protected override Object doGet() {
		if (String.isEmpty(this.resourceId)) {
			throw new RestRouteError.RestException(
					'Employee Id is not provided',
					'NO_ID_PROVIDED',
					HttpUtil.HttpCodes.get(HttpUtil.StatusCode.BAD_REQUEST)
			);
		}
		return new Map<String, Object> {
				'name' => 'John',
				'age' => 25
		};
	}
}
