import 'dart:convert';

import 'package:first_flutter_demo_app/common_widget/top_widget.dart';
import 'package:first_flutter_demo_app/presentation/retrofit/bloc/user_bloc.dart';
import 'package:first_flutter_demo_app/presentation/retrofit/data/model/user_model.dart';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../bloc/user_state.dart';
import '../data/service/api_service.dart';

class UserListScreenWithBlocRetrofit extends StatelessWidget {
  const UserListScreenWithBlocRetrofit({super.key});

  @override
  Widget build(BuildContext context) {
    return TopWidget(child: UserListWithBlocRetrofit(), title: 'User List Retrofit');
  }
}

class UserListWithBlocRetrofit extends StatefulWidget {
  const UserListWithBlocRetrofit({super.key});

  @override
  State<UserListWithBlocRetrofit> createState() => _UserListWithBlocRetrofitState();
}

class _UserListWithBlocRetrofitState extends State<UserListWithBlocRetrofit> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) => UserBloc(apiService:ApiService(Dio())..getData()),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: editText("Search here...", 20, false),
                    onChanged: (value) {
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(child: BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                  if (state is UserLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is UserSuccessState) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title:
                                    Text(state.userDetailsList[index].title),
                                leading: Text(
                                    state.userDetailsList[index].id.toString()),
                                trailing: const Icon(Icons.person),
                              )),
                        );
                      },
                      itemCount: state.userDetailsList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 1.0,
                          color: Colors.grey,
                          height: 1,
                        );
                      },
                    );
                  }
                  if (state is UserErrorState) {
                    return Center(child: Text(state.error));
                  }
                  return const SizedBox();
                })),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
