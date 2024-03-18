import 'package:first_flutter_demo_app/presentation/beer_module_bloc/presentation/bloc_beer_list_screen.dart';
import 'package:first_flutter_demo_app/presentation/beer_module_cubit/presentation/beer_module/cubit_beer_list_screen.dart';
import 'package:first_flutter_demo_app/presentation/equatable/presentation/equatable_demo.dart';
import 'package:first_flutter_demo_app/presentation/freezed/presentation/freezed_demo.dart';
import 'package:first_flutter_demo_app/presentation/home_screen/home_screen.dart';
import 'package:first_flutter_demo_app/presentation/json_annotation/presentation/user_details_json.dart';
import 'package:first_flutter_demo_app/presentation/loggers/loggers.dart';
import 'package:first_flutter_demo_app/presentation/login/login_screen.dart';
import 'package:first_flutter_demo_app/presentation/router_demo/first_screen.dart';
import 'package:first_flutter_demo_app/presentation/router_demo/main_screen.dart';
import 'package:first_flutter_demo_app/presentation/router_demo/second_screen.dart';
import 'package:first_flutter_demo_app/presentation/signup/signup_screen.dart';
import 'package:first_flutter_demo_app/presentation/splash/splash_screen.dart';
import 'package:first_flutter_demo_app/presentation/user_module_with_bloc/presentation/bloc_user_details_screen.dart';
import 'package:first_flutter_demo_app/presentation/user_module_with_bloc/presentation/bloc_user_list_screen.dart';
import 'package:first_flutter_demo_app/presentation/web_view/camera_screen.dart';
import 'package:first_flutter_demo_app/presentation/web_view/web_view.dart';
import 'package:first_flutter_demo_app/router/route_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/user_details.dart';
import '../presentation/beer_module/beer_details_screen.dart';
import '../presentation/beer_module/beer_list_screen.dart';
import '../presentation/get_it/presentation/load_images.dart';
import '../presentation/retrofit/presentation/retrofit_bloc_user_list_screen.dart';
import '../presentation/retrofit/presentation/user_list_future_builder.dart';
import '../presentation/user_module/user_details_screen.dart';
import '../presentation/user_module/user_list_screen.dart';

class MyRouter {
  GoRouter router = GoRouter(initialLocation: RouteConstant.homeScreen, routes: [
    GoRoute(
        name: 'splash_screen',
        path: RouteConstant.splashScreen,
        builder: (context, state) {
          return const SplashScreen();
        }),
    GoRoute(
        name: 'home_screen',
        path: RouteConstant.homeScreen,
        builder: (context, state) {
          return const HomeScreen();
        }),
    GoRoute(
      builder: (context, state) {
        return const FirstScreen();
      },
      name: 'first_screen',
      path: '/first_screen',
    ),
    GoRoute(
      name: 'second_screen',
      path: '/second_screen',
      builder: (context, state) {
        return const SecondScreen();
      },
    ),
    GoRoute(
      name: 'main_screen',
      path: '/main_screen',
      builder: (context, state) {
        return const MainScreen();
      },
    ),
    GoRoute(
        name: 'signup_screen',
        path: RouteConstant.signUpScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SignUpScreenOne());
        }),
    GoRoute(
        name: 'log_in',
        path: RouteConstant.loginScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(child: LoginScreen());
        }),
    GoRoute(
        name: 'user_list_with_out_bloc',
        path: RouteConstant.userListWithOutBloc,
        pageBuilder: (context, state) {
          return const MaterialPage(child: UserListScreen());
        }),
    GoRoute(
        name: 'user_details_with_out_bloc',
        path: RouteConstant.userDetailsWithOutBloc,
        pageBuilder: (context, state) {
          UserDetails userDetails= state.extra as UserDetails;
          return MaterialPage(child: UserDetailsScreen(userDetails:userDetails));
        }),
    GoRoute(
        name: 'beer_list_with_out_bloc',
        path: RouteConstant.beerListWithOutBloc,
        pageBuilder: (context, state) {
          return const MaterialPage(child: BeerListScreen());
        }),
    GoRoute(
        name: 'beer_list_with_cubit',
        path: RouteConstant.beerListWithCubit,
        pageBuilder: (context, state) {
          return const MaterialPage(child: CubitBeerListScreen());
        }),
    GoRoute(
        name: 'beer_list_with_bloc',
        path: RouteConstant.beerListWithBloc,
        pageBuilder: (context, state) {
          return const MaterialPage(child: BlocBeerListScreen());
        }),
    GoRoute(
        name: 'user_list_with_bloc',
        path: RouteConstant.userListWithBloc,
        pageBuilder: (context, state) {
          return const MaterialPage(child: UserListScreenWithBloc());
        }),
    GoRoute(
        name: 'user_details_with_bloc',
        path: RouteConstant.userDetailsWithBloc,
        pageBuilder: (context, state) {
          UserDetails userDetails= state.extra as UserDetails;
          return  MaterialPage(child: UserDetailsScreenWithBloc(userDetails: userDetails,));
        }),
    GoRoute(
        name: 'get_it',
        path: RouteConstant.getIt,
        pageBuilder: (context, state) {
          return  MaterialPage(child: LoadImagesScreen());
        }),
    GoRoute(
        name: 'json_annotation',
        path: RouteConstant.jsonAnnotation,
        pageBuilder: (context, state) {
          return  MaterialPage(child: UserDetailsWithJson());
        }),
    GoRoute(
        name: 'equatable',
        path: RouteConstant.equatable,
        pageBuilder: (context, state) {
          return  MaterialPage(child: EquatableDemo());
        }),
    GoRoute(
        name: 'freezed',
        path: RouteConstant.freezed,
        pageBuilder: (context, state) {
          return  MaterialPage(child: FreezedDemo());
        }),
    GoRoute(
        name: 'retrofit',
        path: RouteConstant.retrofit,
        pageBuilder: (context, state) {
          return  MaterialPage(child: UserListScreenWithRetrofitFutureBuilder());
        }),
    GoRoute(
        name: 'loggers',
        path: RouteConstant.logger,
        pageBuilder: (context, state) {
          return  MaterialPage(child: Loggers());
        }),
    GoRoute(
        name: 'web_view',
        path: RouteConstant.webView,
        pageBuilder: (context, state) {
          return  MaterialPage(child: WebViewDemo());
        }),
    GoRoute(
        name: 'camera',
        path: RouteConstant.cameraScreen,
        pageBuilder: (context, state) {
          return  MaterialPage(child: CameraScreen());
        }),
  ]);
}
