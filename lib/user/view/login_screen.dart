import 'package:code_factory2_bloc/common/component/text_form_field.dart';
import 'package:code_factory2_bloc/common/const/color.dart';
import 'package:code_factory2_bloc/common/layout/default_layout.dart';
import 'package:code_factory2_bloc/user/bloc/user_model/user_model_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(userMeProvider);
    final state = context.watch<UserModelBloc>().state.userModel;

    return DefaultLayout(
      child: SafeArea(
        top: true,
        child: SingleChildScrollView(
          keyboardDismissBehavior:
          ScrollViewKeyboardDismissBehavior.onDrag, // 드래그를 했을 때 키보드가 사라진다.
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                const SizedBox(
                  height: 16.0,
                ),
                _SubTitle(),
                // Image.asset(
                //   'asset/img/misc/logo.png',
                //   width: MediaQuery.of(context).size.width / 3,
                // ),
                Text('로그인 스크린임다'),
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요',
                  onChanged: (String value) {
                    username = value;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요',
                  onChanged: (String value) {
                    password = value;
                  },
                  obscureText: true,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  // 로그인 중에는 버튼을 누를 수 없음
                  onPressed: state is UserModelLoading
                      ? null
                      : () async {
                    context.read<UserModelBloc>().add(UserModelLogin(username: username,password: password));
                    // 아래 내용들을 repository와 riverpod으로 대체

                    //
                    // // 아이디 비번
                    // final rowString = '$username:$password';
                    //
                    // // 아이디 비번 인코딩
                    // Codec<String, String> stringToBase64 =
                    //     utf8.fuse(base64); // 일반스트링을 base64로 인코딩
                    //
                    // // 토큰으로 생성
                    // String token = stringToBase64.encode(rowString);
                    //
                    // // 헤더에 토큰 달고 api 요청
                    // final response = await dio.post(
                    //   'http://$ip/auth/login',
                    //   options: Options(headers: {
                    //     'authorization': 'Basic $token',
                    //   }),
                    // );
                    //
                    // // refreshToken과 accessToken 받음
                    // final refreshToken = response.data['refreshToken'];
                    // final accessToken = response.data['accessToken'];
                    //
                    // final storage = ref.read(secureStorageProvider);
                    //
                    // // 토큰 저장
                    // await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
                    // await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

                    // Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(builder: (_) => RootTab()),
                    // );
                  },
                  child: Text('로그인'),
                  style: ElevatedButton.styleFrom(
                    primary: PRIMARY_COLOR,
                  ),
                ),
                TextButton(
                  onPressed: () async {},
                  child: Text('회원가입'),
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다.',
      style: TextStyle(
          fontSize: 34, fontWeight: FontWeight.w600, color: Colors.black),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(fontSize: 16, color: BODY_TEXT_COLOR),
    );
  }
}