import 'dart:convert';

import 'new_interest_list.dart';

class InterestListModel {
  final String title;
  final List<String> list;
  const InterestListModel({
    required this.title,
    required this.list,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'list': list,
    };
  }

  factory InterestListModel.fromMap(Map<String, dynamic> map) {
    return InterestListModel(
      title: map['title'],
      list: List<String>.from(map['list']),
    );
  }

  String toJson() => json.encode(toMap());

  factory InterestListModel.fromJson(String source) =>
      InterestListModel.fromMap(json.decode(source));

  @override
  String toString() => 'InterestListModel(title: $title, list: $list)';
}

List<InterestCategory> demoInterestsList = [
  InterestCategory(
      category: 'Fitness & Outdoor Activities', interest: 'Hiking'),
  InterestCategory(category: 'Fitness & Outdoor Activities', interest: 'Yoga'),
  InterestCategory(
      category: 'Fitness & Outdoor Activities', interest: 'Cycling'),
  InterestCategory(
      category: 'Fitness & Outdoor Activities', interest: 'Running'),
  InterestCategory(
      category: 'Fitness & Outdoor Activities', interest: 'Swimming'),
  InterestCategory(category: 'Sports', interest: 'Football'),
  InterestCategory(category: 'Sports', interest: 'Cricket'),
  InterestCategory(category: 'Sports', interest: 'Badminton'),
  InterestCategory(category: 'Sports', interest: 'Gym'),
  InterestCategory(category: 'Arts & Creativity', interest: 'Dancing'),
  InterestCategory(category: 'Arts & Creativity', interest: 'Photography'),
  InterestCategory(category: 'Arts & Creativity', interest: 'Painting'),
  InterestCategory(category: 'Arts & Creativity', interest: 'Songwriting'),
  InterestCategory(category: 'Arts & Creativity', interest: 'Poetry'),
  InterestCategory(category: 'Entertainment & Media', interest: 'Concerts'),
  InterestCategory(category: 'Entertainment & Media', interest: 'Video Games'),
  InterestCategory(category: 'Entertainment & Media', interest: 'Netflix'),
  InterestCategory(category: 'Entertainment & Media', interest: 'Stand-up'),
  InterestCategory(category: 'Entertainment & Media', interest: 'Youtuber'),
  InterestCategory(category: 'Food & Beverage', interest: 'Cooking'),
  InterestCategory(category: 'Food & Beverage', interest: 'Coffee'),
  InterestCategory(category: 'Social Activities', interest: 'Clubbing'),
  InterestCategory(category: 'Social Activities', interest: 'House Party'),
  InterestCategory(category: 'Fashion & Lifestyle', interest: 'Sneakerhead'),
  InterestCategory(category: 'Fashion & Lifestyle', interest: 'Streetwear'),
  InterestCategory(category: 'Reading & Writing', interest: 'Reading'),
  InterestCategory(category: 'Business & Finance', interest: 'Stock Market'),
  InterestCategory(category: 'Business & Finance', interest: 'Startups'),
];
