
class PagingController<T> {
  List<T> listItems = [];
  int pageNumber = 1;
  bool isLoadingPage = false;
  bool endOfList = false;

  initRefresh() {
    listItems = [];
    pageNumber = 1;
    isLoadingPage = false;
    endOfList = false;
  }

  bool canLoadNextPage() {
    return !isLoadingPage && !endOfList;
  }

  appendPage(List<T> items) {
    listItems.addAll(items);
    pageNumber++;
  }

  appendLastPage(List<T> items) {
    listItems.addAll(items);
    endOfList = true;
  }
}
