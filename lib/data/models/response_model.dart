class ResponseModel {
  final String status;
  final dynamic data;
  final List<ErrorModel> errors;
  final bool isError;

  ResponseModel(
      {required this.status,
      required this.data,
      required this.errors,
      required this.isError});

  factory ResponseModel.fromJson(Map<String, dynamic> json, int statusCode) {
    return ResponseModel(
      status: json['status']!,
      data: json['data'],
      errors:
          (json['errors'] as List).map((e) => ErrorModel.fromJson(e)).toList(),
      isError: statusCode >= 400,
    );
  }
}

class ErrorModel {
  final String message;
  final String errorType;

  ErrorModel({required this.message, required this.errorType});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      message: json['message']!,
      errorType: json['errorType']!,
    );
  }
}
