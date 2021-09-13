import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:app_qldt/enums/http/http_status.dart';
import 'package:app_qldt/models/http/response.dart';
import 'package:app_qldt/models/sign_up/sign_up_user.dart';

class SignUpService {
  final ApiUrl apiUrl;

  SignUpService(this.apiUrl);

  Future<HttpResponseModel> signUp(SignUpUser signUpUser) async {
    await Future.delayed(const Duration(seconds: 3));
    return HttpResponseModel(
      status: HttpResponseStatus.successfully,
      data: 'OK --- sign_up_service.dart',
    );
  }
}
