import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as DIO;
import 'package:dio/io.dart';
import 'package:get/get.dart';
import '../utils/CommonWidget.dart';
import '../utils/injection.dart';
import 'WebService.dart';

class ApiService extends GetxService {
  final DIO.Dio dio = DIO.Dio();
  final int timeoutInSeconds = 30;
  final DIO.LogInterceptor loggingInterceptor = DIO.LogInterceptor();

  //For getMethod
  Future<dynamic> getMethod(String endPoint,{Map<String, dynamic>? header}) async {
    DIO.Response? response;

    try {
      print("baseUrl --- ${DI<WebService>().BASE_URL + endPoint} ");

      response = await dio.get(DI<WebService>().BASE_URL + endPoint,
          options: DIO.Options(
          headers:header?? {
            "Content-Type": "application/json", // Ensure it's sent as raw JSON
          },
          ),);
      return returnResponse(response);
    } catch (e) {
      if (e is DIO.DioException) {
        if (e.response != null) {
          response = e.response;
          return returnResponse(e.response!);
        }
      } else {
        log("NO Dio Error: $e");
      }
    }
    return returnResponse(response!);
  }

  Future<dynamic> getMethodWithBody(String endPoint,{Map<String, dynamic>? header,Map<String,dynamic>? body}) async {
    DIO.Response? response;

    var data = json.encode(body);

    try {
      print("baseUrl --- ${DI<WebService>().BASE_URL + endPoint} ");
      response = await dio.get(DI<WebService>().BASE_URL + endPoint,
          options: DIO.Options(
            headers:header?? {
              "Content-Type": "application/json", // Ensure it's sent as raw JSON
            },
          ),
          data: data);
      return returnResponse(response);
    } catch (e) {
      if (e is DIO.DioException) {
        if (e.response != null) {
          response = e.response;
          return returnResponse(e.response!);
        }
      } else {
        log("NO Dio Error: $e");
      }
    }
    return returnResponse(response!);
  }

  //For postMethod
  Future<dynamic> postMethod(
      String endPoint, Map<String, dynamic>? body,
      {Map<String, dynamic>? header}) async
  {
    DIO.Response? response;
    try {
      print("baseUrl post--- ${DI<WebService>().BASE_URL}$endPoint");
      print("header--- $header");

      response = await dio.post(
        "${DI<WebService>().BASE_URL}$endPoint",
        data: body,
        options: DIO.Options(
          headers: {
            "Content-Type": "application/json",
            ...?header,
          },
        ),
      );
      return returnResponse(response);
    } catch (e) {
      if (e is DIO.DioException) {
        if (e.response != null) {
          response = e.response;
          return returnResponse(e.response!);
        } else {
          log("Error:-- ${e.message}");
        }
      } else {
        log("NO Dio Error: $e");
      }
    }
    return returnResponse(response!);
  }

  //For multipart method
  Future<dynamic> multipartPostMethod(String endPoint, String profileKeyName,
      String filePath, Map<String, dynamic> body, header)
  async {
    print("filePath2 : $profileKeyName");
    DIO.FormData? formData;

    formData = DIO.FormData.fromMap({
      ...body, // Spread operator to add existing map data
      if (filePath.isNotEmpty)
        profileKeyName: await DIO.MultipartFile.fromFile(filePath,
            filename: filePath.split('/').last.toString(),
            contentType: DIO.DioMediaType(
                'image', filePath.split('/').last.split('.').last.toString())),
    });

    var response;

    try {
      response = await dio.post(
        DI<WebService>().BASE_URL + endPoint,
        data: formData,
        options: DIO.Options(headers: header),
      );
    } catch (e) {
      if (e is DIO.DioException) {
        if (e.response != null) {
          response = e.response;
          return returnResponse(e.response!);
        } else {
          log("Error: ${e.message}");
        }
      } else {
        log("NO Dio Error: $e");
      }
    }
    return returnResponse(response);
  }

  //For Multiple multipart method
  Future<dynamic> multipartMultiplePostMethod(String endPoint, String mainImageKey,
      String mainImageFilePath,String galleryImageKey, List<File> galleryImagePaths, Map<String, dynamic> body, header)
  async {
    print("mainImageKey : $mainImageKey");
    DIO.FormData? formData;

    formData = DIO.FormData.fromMap({
      ...body, // Spread operator to add existing map data
    });
    if (mainImageFilePath.isNotEmpty) {
      formData.files.add(
        MapEntry(
          mainImageKey,
          await DIO.MultipartFile.fromFile(
            mainImageFilePath,
            filename: mainImageFilePath.split('/').last,
            contentType: DIO.DioMediaType(
              'image',
              mainImageFilePath.split('.').last,
            ),
          ),
        ),
      );
    }



    /// ✅ Add gallery images (multiple)
    for (final file in galleryImagePaths) {
      if (file.path.isNotEmpty) {
        formData.files.add(
          MapEntry(
            galleryImageKey, // SAME key every time
            await DIO.MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
              contentType: DIO.DioMediaType(
                'image',
                file.path.split('.').last,
              ),
            ),
          ),
        );
      }
    }
    var response;

    try {
      response = await dio.post(
        DI<WebService>().BASE_URL + endPoint,
        data: formData,
        options: DIO.Options(headers: header),
      );
    } catch (e) {
      if (e is DIO.DioException) {
        if (e.response != null) {
          response = e.response;
          return returnResponse(e.response!);
        } else {
          log("Error: ${e.message}");
        }
      } else {
        log("NO Dio Error: $e");
      }
    }
    return returnResponse(response);
  }

  // Multipart method for dynamic single-file keys.
  Future<dynamic> multipartMultiFieldPostMethod(
      String endPoint,
      Map<String, dynamic> body,
      Map<String, String> files,
      Map<String, dynamic> header) async {
    final formData = DIO.FormData.fromMap({...body});

    for (final entry in files.entries) {
      final filePath = entry.value;
      if (filePath.isEmpty) continue;
      formData.files.add(
        MapEntry(
          entry.key,
          await DIO.MultipartFile.fromFile(
            filePath,
            filename: filePath.split('/').last,
          ),
        ),
      );
    }

    DIO.Response? response;
    try {
      response = await dio.post(
        DI<WebService>().BASE_URL + endPoint,
        data: formData,
        options: DIO.Options(headers: header),
      );
      return returnResponse(response);
    } catch (e) {
      if (e is DIO.DioException) {
        if (e.response != null) {
          response = e.response;
          return returnResponse(e.response!);
        } else {
          log("Error: ${e.message}");
        }
      } else {
        log("NO Dio Error: $e");
      }
    }
    return returnResponse(response!);
  }


  Future<DIO.Response> returnResponse(DIO.Response response) async {
    final responseData = _normalizeResponseData(response.data);

    if (_isFailureResponse(responseData)) {
      DI<CommonWidget>().errorDialog(
        (responseData["message"] ?? "Something went wrong").toString(),
        () {
        Get.back();
        },
      );

      return response;
    }

    if (response.statusCode != 200) {
      final errorData = responseData["error"];
      if (errorData is Map<String, dynamic>) {
        print("response code:-- ${errorData["code"]}");
        print("response :-- ${errorData["message"]}");

        DI<CommonWidget>().errorDialog((errorData["message"] ?? "Something went wrong").toString(), () {
          Get.back();
        });
      } else {
        DI<CommonWidget>().errorDialog(
          (responseData["message"] ?? "Something went wrong").toString(),
          () {
            Get.back();
          },
        );
      }

      return response;
    }
    return response;
  }

  Map<String, dynamic> _normalizeResponseData(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    }

    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }

    if (data is String) {
      try {
        final decodedData = jsonDecode(data);
        if (decodedData is Map<String, dynamic>) {
          return decodedData;
        }
        if (decodedData is Map) {
          return Map<String, dynamic>.from(decodedData);
        }
      } catch (_) {}
    }

    return {};
  }

  bool _isFailureResponse(Map<String, dynamic> responseData) {
    if (responseData.isEmpty) {
      return false;
    }

    if (responseData.containsKey("success")) {
      return responseData["success"] == false;
    }

    if (responseData.containsKey("status")) {
      return responseData["status"] == false;
    }

    return false;
  }
}

DIO.Dio getDio() {
  final dio = DIO.Dio();

  // Bypass SSL error
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };

  return dio;
}