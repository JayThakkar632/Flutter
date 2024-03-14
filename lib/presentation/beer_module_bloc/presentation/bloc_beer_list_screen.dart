import 'package:first_flutter_demo_app/common_widget/top_widget.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/bloc/post_bloc.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/bloc/post_event.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/data/model/beer_details.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/data/repository/beer_repository.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/presentation/beer_details_screen.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/presentation/widget/beer_card.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/presentation/widget/filter/filter_dialog.dart';
import 'package:first_flutter_demo_app/ui_helper/common_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/post_state.dart';

class BlocBeerListScreen extends StatefulWidget {
  const BlocBeerListScreen({super.key});

  @override
  State<BlocBeerListScreen> createState() => _BlocBeerListScreenState();
}

class _BlocBeerListScreenState extends State<BlocBeerListScreen> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => BeerListRepository(),
        child: const BlocBeerDetailsScreen());
  }
}

class BlocBeerDetailsScreen extends StatefulWidget {
  const BlocBeerDetailsScreen({super.key});

  @override
  State<BlocBeerDetailsScreen> createState() => _BlocBeerDetailsState();
}

class _BlocBeerDetailsState extends State<BlocBeerDetailsScreen> {
  final _textFiledSearch = TextEditingController();
  late PostBloc bloc;
  bool isLoadingForSearch = false;
  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.amberAccent,
    Colors.green,
    Colors.deepOrange
  ];

  @override
  void initState() {
    bloc=PostBloc(context.read<BeerListRepository>());
    super.initState();
  }

  void searching(String searchText){
    isLoadingForSearch = true;
    bloc.add(LoadedEvent(searchedText: searchText));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
        create: (context) =>
            bloc..add(LoadedEvent()),
        child: TopWidget(
          title: "Beer List",
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.filter_alt),
            onPressed: () {
              showFilterDialog(context);
            },
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
                          onChanged: (value) {
                            searching(value);

                          },
                        ),
                        isLoadingForSearch
                            ? const Positioned(
                          right: 10,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: CircularProgressIndicator(),
                          ),
                        )
                            : Container(),
                      ],
                    ),
                    Expanded(
                      child: BlocBuilder<PostBloc, PostState>(
                        builder: (context, state) {
                          if (state is LoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is SuccessState) {
                            return ListView.builder(
                              controller:context.read<PostBloc>().scrollController,
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.only(left: 0, top: 20),
                              itemCount: state.posts.length + (context.read<PostBloc>().isLoadingMore ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index > state.posts.length-1) {
                                  return const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(child: CircularProgressIndicator()),
                                  );
                                } else {
                                  var colorIndex = index % colors.length;
                                  return buildGestureDetector(context, index,
                                      colors, colorIndex, state.posts);
                                }
                              },
                            );
                          }
                          if (state is FailureState) {
                            return Center(
                              child: Text(state.error),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                    //LastOrder()
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  GestureDetector buildGestureDetector(BuildContext context, int index,
      List<Color> colors, int colorIndex, List<BeerDetails> beers) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BeerDetailsScreen(
                      beerModel: beers[index],
                      index: index,
                      color: colors[colorIndex])));
        },
        child: BeerCard(beerDetails: beers, color: colors[colorIndex], index: index));
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: const Center(child: Text('Choose your Filter')),
            content: FilterDialog(
              onOkayCallback: (foodSearch, brewedBefore, brewedAfter) {
                bloc.add(LoadedEvent(foodSearch: foodSearch,brewedBefore: brewedBefore,brewedAfter: brewedAfter));
                // _page=0;
                // beers.clear();
                // foodName = foodSearch;
                // this.brewedBefore = brewedBefore;
                // this.brewedAfter = brewedAfter;
                // getData();
                Navigator.pop(context);
              },
              onResetCallBack: () {
                // beers.clear();
                // _page=0;
                // foodName = '';
                // brewedBefore = '';
                // brewedAfter = '';
                // getData();
                Navigator.pop(context);
              },
              // foodSearch: foodName,
              // brewedAfter: brewedAfter,
              // brewedBefore: brewedBefore,
            ));
      },
    );
  }
}
