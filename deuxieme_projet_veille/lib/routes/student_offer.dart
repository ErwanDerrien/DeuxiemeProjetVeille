import 'package:flutter/material.dart';

class StudentOffer {
  String title;
  String companyName;
  String description;
  String beginningDate;
  String endingDate;
  String limitDateToApply;
  double minSalary;
  double maxSalary;

  StudentOffer(
      this.title,
      this.companyName,
      this.description,
      this.beginningDate,
      this.endingDate,
      this.limitDateToApply,
      this.minSalary,
      this.maxSalary);

  factory StudentOffer.fromJson(dynamic json) {
    return StudentOffer(
      json['title'] as String,
      json['companyName'] as String,
      json['description'],
      json['beginningDate'] as String,
      json['endingDate'] as String,
      json['limitDateToApply'] as String,
      json['minSalary'] as double,
      json['maxSalary'] as double,
    );
  }

  @override
  String toString() {
    // return '{ $title, $companyName, $description, $beginningDate, $endingDate, $limitDateToApply, $minSalary, $maxSalary }';
    return '{ $companyName, }';
  }

  String getTitle() {
    return title;
  }
}
