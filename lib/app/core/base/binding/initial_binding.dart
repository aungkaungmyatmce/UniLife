import 'package:blog_post_flutter/app/core/base/binding/cached_manager_binding.dart';
import 'package:blog_post_flutter/app/core/base/binding/view_controller_binding.dart';
import 'package:get/get.dart';
import 'remote_source_bindings.dart';
import 'repository_binding.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    CachedManagerBindings().dependencies();
    RepositoryBindings().dependencies();
    RemoteSourceBindings().dependencies();
    ViewControllerBinding().dependencies();
  }
}
