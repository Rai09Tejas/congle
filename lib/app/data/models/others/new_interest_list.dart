class InterestCategory {
  final String category;
  final String interest;

  InterestCategory({
    required this.category,
    required this.interest,
  });

  factory InterestCategory.fromJson(Map<String, dynamic> json) {
    return InterestCategory(
      category: json['category'] ?? '',
      interest: json['interest'] ?? '',
    );
  }

  
  factory InterestCategory.fromMap(Map<String, dynamic> map) {
    return InterestCategory(
      interest: map['interest'],
      category: map['category'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'interest': interest,
    };
  }
}
