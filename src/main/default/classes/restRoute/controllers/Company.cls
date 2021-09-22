public with sharing class Company extends RestRoute {
	public override String getMapping() {
		return 'companies';
	}

	protected override Object doGet() {
		if (String.isEmpty(this.resourceId)) {
			throw new RestRouteError.RestException(
					'Company Id is not provided',
					'NO_ID_PROVIDED',
					HttpUtil.HttpCodes.get(HttpUtil.StatusCode.BAD_REQUEST)
			);
		}
		return new Map<String, Object> {
				'name' => 'Ascendix',
				'site' => 'https://ascendix.com/'
		};
	}

	protected override Map<String, RestRoute> getNextRouteMap() {
		return new Map<String, RestRoute>{
				'employees' => new Employee(this.resourceId)
		};
	}
}
