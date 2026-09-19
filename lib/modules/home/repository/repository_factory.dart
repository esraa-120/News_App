import 'package:news_app/core/network/connectivity_service.dart';
import 'package:news_app/modules/home/repository/remote_repository_imp.dart';
import 'package:news_app/modules/home/repository/repository_interface.dart';
import 'local_repository_imp.dart';

abstract class RepositoryFactory {

  RepositoryFactory._();

  static RepositoryInterface get instance {
    return ConnectivityService.isConnected
        ? RemoteRepositoryImp()
        : LocalRepositoryImp();
  }
}