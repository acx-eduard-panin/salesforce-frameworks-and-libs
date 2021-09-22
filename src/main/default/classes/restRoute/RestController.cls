@RestResource(UrlMapping='/*')
global class RestController {
	private static List<RestRoute> services = new List<RestRoute>{
			new Calculator(),
			new Company()
	};
	@HttpPost
	global static void doPost() {
		executeRequest();
	}

	@HttpPatch
	global static void doPatch() {
		executeRequest();
	}

	@HttpDelete
	global static void doDelete() {
		executeRequest();
	}

	@HttpGet
	global static void doGet() {
		executeRequest();
	}

	private static void executeRequest() {
		Boolean hasMapping = false;
		String mapping = getMainMapping(RestContext.request.requestURI);
		for (RestRoute service : services) {
			if (service.getMapping() == mapping) {
				service.setBaseMapping('/' + service.getMapping());
				service.execute();
				hasMapping = true;
			}
		}

		if (!hasMapping) {
			handleException(RestContext.response, 'Could not find route', HttpUtil.StatusCode.NOT_FOUND);
		}
	}

	public static String getMainMapping(String url) {
		if (String.isBlank(url)) {
			return null;
		}
		List<String> pathValues = url.split('\\/');
		return (pathValues.size() >= 2 ? pathValues[1] : null);
	}

	public static void handleException(RestResponse response, String message, HttpUtil.StatusCode statusCode) {
		response.statusCode = HttpUtil.HttpCodes.get(statusCode);
		Object responseBody = new Map<String, Object>{
				'success' => false,
				'message' => message
		};
		response.responseBody = Blob.valueOf(JSON.serialize(responseBody));
	}
}
