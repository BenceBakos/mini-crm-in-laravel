part of "main.dart";

class Api {
  static Dio dio = Dio();

  static Future getCompanies() async {
    return dio.get(API_BASE + "company");
  }

  static Future getCompany(int id) async {
    return dio.get(API_BASE + "company/" + id.toString());
  }

  static Future createCompany(Map<String, dynamic> data) async {
    return dio.post(API_BASE + "company", queryParameters: data);
  }

  static Future deleteCompany(int id) async {
    return dio.delete(API_BASE + "company/" + id.toString());
  }

  static Future updateCompany(int id, Map data) async {
    return dio.put(API_BASE + "company/" + id.toString(), data: data);
  }

  static Future uploadCompanyLogo(file, int id) async {
    final formData = FormData.fromMap({
      'logo':
          MultipartFile.fromBytes(file.bytes as List<int>, filename: "logo"),
    });

    return dio.post(
      API_BASE + "company/upload_logo/" + id.toString(),
      data: formData,
    );
  }

  static Future getEmployees() async {
    return dio.get(API_BASE + "employee");
  }

  static Future getEmployee(int id) async {
    return dio.get(API_BASE + "employee/" + id.toString());
  }

  static Future updateEmployee(int id, Map data) async {
    return dio.put(API_BASE + "employee/" + id.toString(), data: data);
  }

  static Future createEmployee(Map<String, dynamic> data) async {
    return dio.post(API_BASE + "employee", queryParameters: data);
  }

  static Future deletEmployee(int id) async {
    return dio.delete(API_BASE + "employee/" + id.toString());
  }
}
