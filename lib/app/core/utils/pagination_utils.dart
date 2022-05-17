class PaginationUtils {
  int _currentPage = 1;
  int? _totalPage;

  PaginationUtils();

  int get currentPage => _currentPage;

  setCurrentPage({required int? totalPage}) {
    print("Last Page is $totalPage");
    _totalPage = totalPage;
    _currentPage = _currentPage + 1;
  }

  bool isPageAvailable() {
    if(_totalPage == null) {
      return true;
    } else {
      return _currentPage <= _totalPage!;
    }
  }
}
