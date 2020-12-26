import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import "package:http/http.dart" as http;

class FeedbackForm {
  String title;
  String value;
  String category;
  String member;
  String payment;

  FeedbackForm(this.title, this.value, this.category, this.member, this.payment);

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm("${json['title']}", "${json['value']}",
        "${json['category']}", "${json['member']}", "${json['payment']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
    'title': title,
    'value': value,
    'category': category,
    'member': member,
    'payment': payment
  };
}

class FormController {

  // Google App Script Web URL.
  static const String URL = "https://script.google.com/macros/s/AKfycbwEQ8yJ62oCarsrAEB3NRdp2usieK7l_VwWNrdxDIuUZi-8ck88/exec";

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(
      FeedbackForm feedbackForm, void Function(String) callback) async {
    try {

      await http.post(URL, body: feedbackForm.toJson()).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(url).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}