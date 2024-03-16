import 'package:first_flutter_demo_app/common_widget/top_widget.dart';
import 'package:first_flutter_demo_app/presentation/retrofit/data/model/user_model.dart';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';
import '../data/service/api_service.dart';

class UserListScreenWithRetrofitFutureBuilder extends StatelessWidget {
  const UserListScreenWithRetrofitFutureBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return TopWidget(child: UserListWithRetrofitFutureBuilder(), title: 'User List Retrofit');
  }
}

class UserListWithRetrofitFutureBuilder extends StatefulWidget {
  const UserListWithRetrofitFutureBuilder({super.key});

  @override
  State<UserListWithRetrofitFutureBuilder> createState() => _UserListWithRetrofitFutureBuilderState();
}

class _UserListWithRetrofitFutureBuilderState extends State<UserListWithRetrofitFutureBuilder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Expanded(child: _body())
            ],
          ),
        ],
      ),
    );
  }

  FutureBuilder _body(){
    final apiService=ApiService(Dio());
    return FutureBuilder(future: apiService.getData(), builder: (context,snapshot){
      if(snapshot.connectionState == ConnectionState.done){
        final List<UserModel> userList=snapshot.data!;
        return ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
              },
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title:
                    Text(userList[index].title),
                    leading: Text(
                        userList[index].id.toString()),
                    trailing: const Icon(Icons.person),
                  )),
            );
          },
          itemCount: userList.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              thickness: 1.0,
              color: Colors.grey,
              height: 1,
            );
          },
        );;
      }else{
        return Center(child: CircularProgressIndicator(),);
      }
    });
  }

}
