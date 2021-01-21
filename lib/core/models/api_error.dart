class ApiError {
  String status;

  ApiError({this.status});

  ApiError.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }
}
