import 'package:first_flutter_demo_app/common_widget/top_widget.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/bloc/post_bloc.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/bloc/post_event.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/data/model/beer_details.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/data/repository/beer_repository.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/presentation/beer_details_screen.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_bloc/presentation/widget/beer_card.dart';
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
    return RepositoryProvider(create: (context)=> BeerListRepository(),child: const BlocBeerDetailsScreen());
  }
}

class BlocBeerDetailsScreen extends StatefulWidget {
  const BlocBeerDetailsScreen({super.key});

  @override
  State<BlocBeerDetailsScreen> createState() => _BlocBeerDetailsState();
}

class _BlocBeerDetailsState extends State<BlocBeerDetailsScreen> {
  final _textFiledSearch = TextEditingController();
  List<Color> colors = [Colors.blue, Colors.red, Colors.amberAccent, Colors.green, Colors.deepOrange];
  final ScrollController _scrollController = ScrollController();
  var _page=1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(scrolling);
  }

  void scrolling() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _page++;
        PostBloc(RepositoryProvider.of<BeerListRepository>(context))
          ..add(LoadedEvent(_page));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
        create: (context) =>
            PostBloc(RepositoryProvider.of<BeerListRepository>(context))
              ..add(LoadedEvent(_page)),
        child: TopWidget(
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
                      child: BlocBuilder<PostBloc, PostState>(
                        builder: (context, state) {
                          if (state is LoadingState) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is SuccessState) {
                            return ListView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.only(left: 0, top: 20),
                              itemCount: state.beerList.length,
                              itemBuilder: (context, index) {
                                var colorIndex = index % colors.length;
                                return buildGestureDetector(
                                    context, index, colors, colorIndex,state.beerList);
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

  GestureDetector buildGestureDetector(BuildContext context, int index, List<Color> colors, int colorIndex, List<BeerDetails> beers) {
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
        child:BeerCard(beerDetails: beers, color: colors[colorIndex],index:index)
    );
  }
}
