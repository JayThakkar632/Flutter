import 'dart:async';
import 'dart:convert';
import 'package:first_flutter_demo_app/model/user_details.dart';
import 'package:first_flutter_demo_app/common_widget/top_widget.dart';
import 'package:first_flutter_demo_app/presentation/user_module/user_details_screen.dart';
import 'package:first_flutter_demo_app/shared_preferences/shared_prefs_key.dart';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../../common_widget/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../router/route_const.dart';
import '../../services/remote_config_service.dart';
import 'package:go_router/go_router.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TopWidget(
      title: 'User List',
      child: UserList(),
    );
  }
}

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final List<UserDetails> _userList = [];
  List<UserDetails> _searchedList = [];
  var searchText = "";
  var _isLoading = false;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    checkLastApiTime();
  }

  Future<void> fetChDataFromTheLocalStorage() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var data =
        sharedPreferences.getStringList(SharedPreferencesKey.userDetails);
    if (data != null) {
      var list =
          data.map((item) => UserDetails.fromJson(json.decode(item))).toList();
      _isLoading = false;
      setState(() {
        _userList.clear();
        _searchedList.clear();
        _userList.addAll(list);
        _searchedList.addAll(_userList);
      });
    }
  }

  Future<void> checkLastApiTime() async {
    var dynamicTime= await RemoteConfigService().initializeConfig();
    sharedPreferences = await SharedPreferences.getInstance();
    var time =
        sharedPreferences.getString(SharedPreferencesKey.lastApiCallTime) ?? "";
    if (time.isEmpty) {
      getData();
    } else {
      var currentTime = DateTime.now();
      Duration diff = currentTime.difference(DateTime.parse(time));
      if (diff.inSeconds >= int.parse(dynamicTime)) {
        getData();
      } else {
        fetChDataFromTheLocalStorage();
      }
    }
  }

    Future<void> getData() async {
      try{
        var response= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
        if (response.statusCode == 200) {
          setState(() {
            List<dynamic> decodedData = json.decode(response.body);
            List<UserDetails> parsedBeers = List<UserDetails>.from(decodedData.map((data) => UserDetails.fromJson(data)));
            _userList.clear();
            _searchedList.clear();
            _userList.addAll(parsedBeers);
            _searchedList.addAll(_userList);
            _isLoading=false;
            saveDataInSharedPrefs();
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
                    _searchTextFromList(value);
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Stack(
                  children: [
                    ListView.separated(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context.push(RouteConstant.userDetailsWithOutBloc,extra: _userList[index]);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => UserDetailsScreen(
                            //             userDetails: _searchedList[index])));
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(_searchedList[index].title!),
                                leading:
                                    Text(_searchedList[index].id.toString()),
                                trailing: const Icon(Icons.person),
                              )),
                        );
                      },
                      itemCount: _searchedList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 1.0,
                          color: Colors.grey,
                          height: 1,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          _isLoading
              ? const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator())
              : _searchedList.isEmpty
                  ? const Center(
                      child: Text('No data found',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22)))
                  : const SizedBox(),
        ],
      ),
    );
  }

  void _searchTextFromList(String value) {
     setState(() {
      _searchedList = _userList
          .where(
            (user) =>
                ((user.title ?? "").toLowerCase().contains(
                      value.toLowerCase(),
                    )),
          )
          .toList();
    });
  }

  Future<void> saveDataInSharedPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    List<String> usrList =
        _searchedList.map((item) => jsonEncode(item.toJson())).toList();
    sharedPreferences.setStringList(SharedPreferencesKey.userDetails, usrList);
    sharedPreferences.setString(SharedPreferencesKey.lastApiCallTime, DateTime.now().toString());
  }
}
