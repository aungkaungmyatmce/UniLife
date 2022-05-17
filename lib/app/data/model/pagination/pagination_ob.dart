/// total_pages : 2
/// current_page : 2
/// next_page : null
/// previous_page : 1

class Pagination {
  Pagination({
    int? totalPages,
    int? currentPage,
    dynamic nextPage,
    int? previousPage,}){
    _totalPages = totalPages;
    _currentPage = currentPage;
    _nextPage = nextPage;
    _previousPage = previousPage;
  }

  Pagination.fromJson(dynamic json) {
    _totalPages = json['total_pages'];
    _currentPage = json['current_page'];
    _nextPage = json['next_page'];
    _previousPage = json['previous_page'];
  }
  int? _totalPages;
  int? _currentPage;
  dynamic _nextPage;
  int? _previousPage;
  Pagination copyWith({  int? totalPages,
    int? currentPage,
    dynamic nextPage,
    int? previousPage,
  }) => Pagination(  totalPages: totalPages ?? _totalPages,
    currentPage: currentPage ?? _currentPage,
    nextPage: nextPage ?? _nextPage,
    previousPage: previousPage ?? _previousPage,
  );
  int? get totalPages => _totalPages;
  int? get currentPage => _currentPage;
  dynamic get nextPage => _nextPage;
  int? get previousPage => _previousPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_pages'] = _totalPages;
    map['current_page'] = _currentPage;
    map['next_page'] = _nextPage;
    map['previous_page'] = _previousPage;
    return map;
  }

}