import 'package:first_flutter_demo_app/presentation/home_screen/home_screen.dart';
import 'package:first_flutter_demo_app/presentation/login/login_screen.dart';
import 'package:first_flutter_demo_app/presentation/router_demo/first_screen.dart';
import 'package:first_flutter_demo_app/presentation/router_demo/main_screen.dart';
import 'package:first_flutter_demo_app/presentation/router_demo/second_screen.dart';
import 'package:first_flutter_demo_app/presentation/signup/signup_screen.dart';
import 'package:first_flutter_demo_app/presentation/splash/splash_screen.dart';
import 'package:first_flutter_demo_app/router/route_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/user_details.dart';
import '../../model/user_details.dart';
import '../presentation/user_module/user_details_screen.dart';
import '../presentation/user_module/user_list_screen.dart';

class MyRouter {
  GoRouter router = GoRouter(initialLocation: RouteConstant.splashScreen, routes: [
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
        })
  ]);
}
