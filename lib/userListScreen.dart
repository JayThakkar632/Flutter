import 'dart:convert';
import 'package:first_flutter_demo_app/pojo/UserModel.dart';
import 'package:first_flutter_demo_app/userDetailsScreen.dart';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class UserListScreen extends StatelessWidget{
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        leading: InkWell(
            onTap: (){Navigator.pop(context);},
            child: const Icon(Icons.arrow_back,color: Colors.white,)),
        title: Text("User List",style: toolBarTitle(),),
        centerTitle: true,
      ),body: const UserList(),);
  }
}

class UserList extends StatefulWidget{
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<UserModel> userList = [];
  List<UserModel> searchedList = [];
  var searchText="";

  @override
  void initState() {
    super.initState();
    getData(searchText);
  }

  Future<void> getData(String searchText) async {
    var response= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      setState(() {
        List<dynamic> decodedData = json.decode(response.body);
        List<UserModel> parsedBeers = List<UserModel>.from(decodedData.map((data) => UserModel.fromJson(data)));
        userList.addAll(parsedBeers);
        searchedList.addAll(userList);
      });
    } else {
      showSnackBar("Invalid");
    }
  }

  void showSnackBar(String msg){
    var snackBar= SnackBar(
        content: Text(msg),
        action: SnackBarAction(
          label: 'OK',
          onPressed: (){
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        )

    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: editText("Search here...", 20, false),
              onChanged: (value){
                setState(() {
                  searchedList = userList
                      .where(
                        (user) => (user.title!.toLowerCase().contains(
                      value.toLowerCase(),
                    )),
                  ).toList();
                }
                );
              },
            ),
          ),
          const SizedBox(height: 5,),
          SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: ListView.separated(itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetailsScreen(userModel:searchedList[index])));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(searchedList[index].title!),
                    leading: Text(searchedList[index].id.toString()),
                    trailing: const Icon(Icons.person),
                  )
                ),
              );
            },itemCount: searchedList.length, separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                thickness: 1.0,
                color: Colors.grey,
                height: 1,
              );
            },),
          ),
        ],
      ),
    );
  }
}