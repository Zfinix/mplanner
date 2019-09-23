import 'package:flutter/material.dart';

double screenWidth(context ,{percent = 1}) => MediaQuery.of(context).size.width *percent;
double screenHeight(context, {percent = 1}) => MediaQuery.of(context).size.height* percent;
