abstract class BaseApiServices {
  Future<dynamic> getApi(String url);
  Future<dynamic> postApi(String url, var data, {required String authToken});
  Future<dynamic> putApi(String url, var data);
  Future<dynamic> patchApi(String url, var data);
}
