public with sharing class HttpUtil {
	public enum StatusCode {
		OK, UNAUTHORIZED, NOT_FOUND, CREATED, BAD_REQUEST, INTERNAL_SERVER_ERROR, UNSUPPORTED_MEDIA_TYPE, METHOD_NOT_ALLOWED, NO_CONTENT
	}

	public static Map<HttpUtil.StatusCode, Integer> HttpCodes = new Map<HttpUtil.StatusCode, Integer>{
			StatusCode.OK => 200,
			StatusCode.CREATED => 201,
			StatusCode.UNAUTHORIZED => 401,
			StatusCode.NOT_FOUND => 404,
			StatusCode.BAD_REQUEST => 400,
			StatusCode.METHOD_NOT_ALLOWED => 405,
			StatusCode.INTERNAL_SERVER_ERROR => 500,
			StatusCode.UNSUPPORTED_MEDIA_TYPE => 415,
			StatusCode.NO_CONTENT => 204
	};
}
