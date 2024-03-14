import 'package:first_flutter_demo_app/common_widget/top_widget.dart';
import 'package:first_flutter_demo_app/presentation/user_module/user_details_screen.dart';
import 'package:first_flutter_demo_app/presentation/user_module_with_bloc/bloc/user_bloc.dart';
import 'package:first_flutter_demo_app/presentation/user_module_with_bloc/bloc/user_event.dart';
import 'package:first_flutter_demo_app/presentation/user_module_with_bloc/bloc/user_state.dart';
import 'package:first_flutter_demo_app/presentation/user_module_with_bloc/data/repository/user_repository.dart';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListScreenWithBloc extends StatelessWidget {
  const UserListScreenWithBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (BuildContext context) => UserRepository(),
      child: const TopWidget(
        title: 'User List',
        child: UserListWithBloc(),
      ),
    );
  }
}

class UserListWithBloc extends StatefulWidget {
  const UserListWithBloc({super.key});

  @override
  State<UserListWithBloc> createState() => _UserListWithBlocState();
}

class _UserListWithBlocState extends State<UserListWithBloc> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) =>
          UserBloc(context.read<UserRepository>())..add(UserLoadedEvent()),
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
                      _searchTextFromList(value);
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserDetailsScreen(
                                        userDetails:
                                            state.userDetailsList[index])));
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title:
                                    Text(state.userDetailsList[index].title!),
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
                  if (state is InternetLostState) {
                    return const Center(child: Text('Internet Lost!!'));
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

  void _searchTextFromList(String value) {
    // setState(() {
    //   _searchedList = _userList
    //       .where(
    //         (user) => ((user.title ?? "").toLowerCase().contains(
    //               value.toLowerCase(),
    //             )),
    //       )
    //       .toList();
    // });
  }
}
