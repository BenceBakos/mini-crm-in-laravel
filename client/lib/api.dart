part of "main.dart";

class Api {
  static Dio dio = Dio();
  static String token = "";

  static Future<bool> login(String email, String password) {
    return dio.post(API_BASE + "login", data: {
      "email": email,
      "password": password,
    }).then((r) {
      if (r.data.containsKey('token')) {
        token = r.data['token'];
        return Future<bool>.value(true);
      } else {
        token = "";
        return Future<bool>.value(false);
      }
    }, onError: (e) {
      token = "";
      return false;
      //check for what kind of error?
    });
  }

  static Future<bool> logout() {
    return dio
        .post(API_BASE + "logout", data: {}, options: _getAuthHeaders())
        .then((r) {
      token = "";
      return Future<bool>.value(true);
    }, onError: (e) {
      return Future<bool>.value(false);
    });
  }

  static Options _getAuthHeaders() {
    return Options(headers: {"Authorization": "Bearer " + token});
  }

  static bool isAuthenticated() {
    return token.isNotEmpty;
  }

  static Future getCompanies() async {
    return dio.get(API_BASE + "company");
  }

  static Future getCompany(int id) async {
    return dio.get(API_BASE + "company/" + id.toString());
  }

  static Future createCompany(Map<String, dynamic> data) async {
    return dio.post(API_BASE + "company",
        queryParameters: data, options: _getAuthHeaders());
  }

  static Future deleteCompany(int id) async {
    return dio.delete(API_BASE + "company/" + id.toString(),
        options: _getAuthHeaders());
  }

  static Future updateCompany(int id, Map data) async {
    return dio.put(API_BASE + "company/" + id.toString(),
        data: data, options: _getAuthHeaders());
  }

  static Future uploadCompanyLogo(file, int id) async {
    final formData = FormData.fromMap({
      'logo':
          MultipartFile.fromBytes(file.bytes as List<int>, filename: "logo"),
    });

    return dio.post(API_BASE + "company/upload_logo/" + id.toString(),
        data: formData,options: _getAuthHeaders());
  }

  static Future getEmployees() async {
    return dio.get(API_BASE + "employee");
  }

  static Future getEmployee(int id) async {
    return dio.get(API_BASE + "employee/" + id.toString());
  }

  static Future updateEmployee(int id, Map data) async {
    return dio.put(API_BASE + "employee/" + id.toString(),
        data: data, options: _getAuthHeaders());
  }

  static Future createEmployee(Map<String, dynamic> data) async {
    return dio.post(API_BASE + "employee",
        queryParameters: data, options: _getAuthHeaders());
  }

  static Future deletEmployee(int id) async {
    return dio.delete(API_BASE + "employee/" + id.toString(),
        options: _getAuthHeaders());
  }
}
