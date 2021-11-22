class StudentOffer {
  String id;
  String title;
  String companyName;
  String description;
  String beginningDate;
  String endingDate;
  String limitDateToApply;
  double minSalary;
  double maxSalary;
  bool hasAlreadyApplied;

  StudentOffer(
      this.id,
      this.title,
      this.companyName,
      this.description,
      this.beginningDate,
      this.endingDate,
      this.limitDateToApply,
      this.minSalary,
      this.maxSalary,
      this.hasAlreadyApplied);

  factory StudentOffer.fromJson(dynamic json) {
    return StudentOffer(
      json['id'] as String,
      json['title'] as String,
      json['companyName'] as String,
      json['description'],
      json['beginningDate'] as String,
      json['endingDate'] as String,
      json['limitDateToApply'] as String,
      json['minSalary'] as double,
      json['maxSalary'] as double,
      json['hasAlreadyApplied'] as bool,
    );
  }

  @override
  String toString() {
    return '{ $companyName, }';
  }

  String getId() {
    return id;
  }

  String getTitle() {
    return getFixedTitle();
  }

  String getFixedTitle() {
    if (title.contains('Ã©')) {
      title = title.replaceAll('Ã©', 'é');
    }
    return title;
  }

  String getCompanyName() {
    return companyName;
  }

  String getBeginningDate() {
    return beginningDate;
  }

  String getEndingDate() {
    return endingDate;
  }

  String getMinSalary() {
    return minSalary.toString();
  }

  String getMaxSalary() {
    return maxSalary.toString();
  }

  String getDescription() {
    return description;
  }

  bool getListEmailInterestedStudents() {
    return hasAlreadyApplied;
  }
}
