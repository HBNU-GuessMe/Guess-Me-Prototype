import 'package:guessme/kakao_login_sub.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'auth_service.dart';
//import 'shared_data.dart';

class KakaoLogin implements SocialLogin {
  @override
  Future<bool> login() async {
    await AuthApi.instance.hasToken();
    try {
      AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
      print('토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}');
    } catch (error) {
      if (error is KakaoException && error.isInvalidTokenError()) {
        print('토큰 만료 $error');
      } else {
        print('토큰 정보 조회 실패 $error');
      }
    }

    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
          print('카카오톡으로 로그인 성공 ${token.accessToken}');
          await AuthService.saveAccessToken(token.accessToken);
          return true;
        } catch (e) {
          print('카카오톡으로 로그인 실패 $e');
          return false;
        }
      } else {
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print('카카오톡으로 로그인 성공 ${token.accessToken}');
          await AuthService.saveAccessToken(token.accessToken);
          return true;
        } catch (e) {
          print('카카오계정으로 로그인 실패 $e');
          return false;
        }
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.unlink();
      await AuthService.clearAccessToken();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
