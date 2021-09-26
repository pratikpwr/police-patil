class ApiConstants {
  static const String BASE_URL = 'http://pp.thesupernest.com';

  // static const String BASE_URL = "localhost:1337";

  // Methods
  static const String LOGIN = BASE_URL + '/api/user/login';
  static const String GET_USER_DATA = BASE_URL + '/api/user/';
  static const String UPDATE_USER_DATA = BASE_URL + '/api/user/';

  static const String GET_ARMS_BY_PP = BASE_URL + '/api/arms/showbyppid/';
  static const String GET_ARMS = BASE_URL + '/api/arms';
  static const String POST_ARMS_BY_PP = BASE_URL + '/api/arms';
}
