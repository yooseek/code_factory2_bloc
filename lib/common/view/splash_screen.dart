import 'package:code_factory2_bloc/common/const/color.dart';
import 'package:code_factory2_bloc/common/const/data.dart';
import 'package:code_factory2_bloc/common/layout/default_layout.dart';
import 'package:code_factory2_bloc/common/secure_storage/secure_storage_bloc.dart';
import 'package:code_factory2_bloc/common/view/root_tab.dart';
import 'package:code_factory2_bloc/user/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: PRIMARY_COLOR,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('스플래쉬 스크린 !'),
            SizedBox(
              height: 16.0,
            ),
            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   checkToken();
  // }
  //
  // void checkToken() async {
  //     final storage = context.read<SecureStorageBloc>().state;
  //
  //     // 토큰이 저장되어 있는지 확인
  //     final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
  //     final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
  //
  //     final dio = Dio();
  //
  //     // 토큰이 저장되어 있고 유효하면 페이지 이동
  //     try{
  //       // refresh 토큰을 보내서 제대로 200 OK 가 넘어오면
  //       final response = await dio.post(
  //         'http://$ip/auth/token',
  //         options: Options(headers: {
  //           'authorization': 'Bearer $refreshToken',
  //         }),
  //       );
  //
  //       // accessToken 업데이트
  //       await storage.write(key: ACCESS_TOKEN_KEY, value: response.data['accessToken']);
  //
  //       // 루트페이지로 이동
  //       Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(
  //           builder: (_) => RootTab(),
  //         ),
  //             (route) => false,
  //       );
  //     }catch(error){
  //       // 에러가 반환되면 로그인 페이지로 이동
  //       Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(
  //           builder: (_) => LoginScreen(),
  //         ),
  //             (route) => false,
  //       );
  //     }
  //   }
}
