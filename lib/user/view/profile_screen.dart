import 'package:code_factory2_bloc/user/bloc/auth/auth_bloc.dart';
import 'package:code_factory2_bloc/user/bloc/user_model/user_model_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          context.read<UserModelBloc>().add(UserModelLogout());
        },
        child: Text('로그아웃'),
      ),
    );
  }
}
