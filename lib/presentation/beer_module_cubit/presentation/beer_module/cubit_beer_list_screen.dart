import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common_widget/top_widget.dart';
import '../../logic/post_cubit.dart';
import '../../logic/post_state.dart';

class CubitBeerListScreen extends StatefulWidget {
  const CubitBeerListScreen({super.key});

  @override
  State<CubitBeerListScreen> createState() => _CubitBeerListScreenState();
}

class _CubitBeerListScreenState extends State<CubitBeerListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=> PostCubit(),child: const CubitBeerDetailsList());
  }
}

class CubitBeerDetailsList extends StatefulWidget {
  const CubitBeerDetailsList({super.key});

  @override
  State<CubitBeerDetailsList> createState() => _CubitBeerDetailsListState();
}

class _CubitBeerDetailsListState extends State<CubitBeerDetailsList> {
  final _textFiledSearch = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(scrolling);
  }

  void scrolling() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
    }
  }
  @override
  Widget build(BuildContext context) {
    return TopWidget(
      title: "Beer List",
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.filter_alt),
        onPressed: () {},
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    TextField(
                      controller: _textFiledSearch,
                      decoration: editText("Search here", 10.0, false),
                    ),
                  ],
                ),
                Expanded(
                  child: BlocBuilder<PostCubit,PostState>(
                    builder: (context,state){
                      if(state is PostLoadingState){
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      if(state is PostLoadedState){
                        return ListView.builder(itemCount: state.beerList.length,
                          itemBuilder: (context,index){
                          return ListTile(title: Text(state.beerList[index].tagline?? ""),);
                          },
                        );
                      }
                      return const Center(child: Text('no data found'),);
                    },
                  ),
                ),
                //LastOrder()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
