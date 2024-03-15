import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InternetBloc{
    Connectivity _connectivity=Connectivity();
    StreamSubscription? connectivitySubscription;

    checkStatus(BuildContext context) {
      connectivitySubscription =_connectivity.onConnectivityChanged.listen((result) {
        if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile){
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              content:Image.asset('assets/images/gained_internet.gif',fit: BoxFit.fill),
            );
          });
        }else{
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              content:Image.asset('assets/images/lost_internet.gif',fit: BoxFit.fill),
            );
          });

        }
      });
    }
}
