import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mplanner/healthCal/model/gender.dart';

const naturalLOG = 0.4342944819032518;

double calculateBMI({int height, int weight}) =>
    weight / _heightSquared(height);

double calculateMinNormalWeight({int height}) => 18.5 * _heightSquared(height);

double calculateMaxNormalWeight({int height}) => 25 * _heightSquared(height);

double _heightSquared(int height) => pow(height / 100, 2);

double bmrCalculator({weight = 0, height = 0, age = 0, Gender gender}) =>
    gender == Gender.male
        ? (13.397 * weight) + (4.799 * height) - (5.677 * age) + 88.362
        : (9.247 * weight) + (3.098 * height) - (4.330 * age) + 447.593;

double leanMassCalculator({weight = 0, height = 0, @required Gender gender}) {
  print(gender);
  return gender == Gender.male
      ? (0.32810 * weight) + (0.33929 * height) - 29.5336
      : (0.29569 * weight) + (0.41813 * height) - 43.2933;
}

bodyFatCalculator(
    {weight = 0, height = 0, int age = 0, @required Gender gender}) {
try {
    
  if (gender == Gender.male && age >= 18) {
    ///Body fat percentage [BFP] formula for [adult males]:
    return 1.20 * calculateBMI(height: height, weight: weight) +
        0.23 * age -
        16.2;
  } else if (gender == Gender.female && age >= 18) {
    ///Body fat percentage [BFP] formula for [adult females]:
    return 1.20 * calculateBMI(height: height, weight: weight) +
        0.23 * age -
        5.4;
  } else if (gender == Gender.male && age <= 18) {
    ///Body fat percentage [BFP] formula for [boys]:
    return 1.51 * calculateBMI(height: height, weight: weight) -
        0.70 * age -
        2.2;
  } else if (gender == Gender.male && age <= 18) {
    ///Body fat percentage [BFP] formula for [girls]:
    return 1.51 * calculateBMI(height: height, weight: weight) -
        0.70 * age +
        1.4;
  }
} catch (e) {
}
}

num log10(num m) {
  return naturalLOG;
}
