import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/core/state_management/a_base_change_notifier.dart';
import 'package:mithub_app/data/dto_content_marketplace.dart';
import 'package:mithub_app/data/repository/auth_repository.dart';
import 'package:mithub_app/utils/result.dart';

class MarketplaceViewModel extends ABaseChangeNotifier{
  final AuthRepository _authRepository = serviceLocator.get();
  final ResultState<List<ContentMarketPlaceResponse>> listData = ResultState(
    useLastDataOnError: true,
  );

  void onViewLoaded(){
    fetchData();
  }

  void fetchData({String keyword = ''}) {
    Result.call(
        future: _authRepository.getContentMarketPlace(keyword),
        onResult: (result) {
          if(result.isSuccess){
            listData.setResult(Result.success(result.dataOrNull ?? []));
          }else{
            listData.setResult(Result.error('Maaf terjadi kesalahan'));
          }
          notifyListeners();
        }
    );
  }

}