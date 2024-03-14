import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:first_flutter_demo_app/common_widget/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InternetBloc{
    Connectivity _connectivity=Connectivity();
    StreamSubscription? connectivitySubscription;

    checkStatus(BuildContext context) {
      connectivitySubscription =_connectivity.onConnectivityChanged.listen((result) {
        if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile){
          showSnackBar('Internet Gained', context);
        }else{
          showSnackBar('Internet Lost', context);
        }
      });
    }
}
