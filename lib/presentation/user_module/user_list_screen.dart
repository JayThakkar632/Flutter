import 'dart:convert';
import 'package:first_flutter_demo_app/Model/user_details.dart';
import 'package:first_flutter_demo_app/presentation/user_module/user_details_screen.dart';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../common_widget/appbar.dart';
import '../../common_widget/snack_bar.dart';


class UserListScreen extends StatelessWidget{
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:appBar(title: "User List", context: context),body: const UserList(),);
  }
}

class UserList extends StatefulWidget{
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<UserDetails> _userList = [];
  List<UserDetails> _searchedList = [];
  var searchText="";
  var _isLoading=false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    getData(searchText);
  }

  Future<void> getData(String searchText) async {
    try{
      var response= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        setState(() {
          List<dynamic> decodedData = json.decode(response.body);
          List<UserDetails> parsedBeers = List<UserDetails>.from(decodedData.map((data) => UserDetails.fromJson(data)));
          _userList.addAll(parsedBeers);
          _searchedList.addAll(_userList);
          _isLoading=false;
        });
      } else {
        showSnackBar("Invalid",context);
      }
    } on Exception catch(e){
      setState(() {
        _isLoading=false;
      });
      showSnackBar(e.toString(), context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: editText("Search here...", 20, false),
              onChanged: (value){
                setState(() {
                  _searchedList = _userList
                      .where(
                        (user) => ((user.title??"").toLowerCase().contains(
                      value.toLowerCase(),
                    )),
                  ).toList();
                }
                );
              },
            ),
          ),
          _isLoading ? Align(alignment: Alignment.center,child: CircularProgressIndicator()):SizedBox(),
          const SizedBox(height: 5,),
          Container(
            height: MediaQuery.sizeOf(context).height,
            child: Stack(
              children: [
                ListView.separated(itemBuilder: (context,index){
                    return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetailsScreen(userDetails:_searchedList[index])));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(_searchedList[index].title!),
                        leading: Text(_searchedList[index].id.toString()),
                        trailing: const Icon(Icons.person),
                      )
                    ),
                  );
                },itemCount: _searchedList.length, separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    thickness: 1.0,
                    color: Colors.grey,
                    height: 1,
                  );
                },),

              ],
            ),
          ),
        ],
      ),
    );
  }
}