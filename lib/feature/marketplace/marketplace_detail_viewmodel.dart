import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/core/state_management/a_base_change_notifier.dart';
import 'package:mithub_app/data/dto_content_detail_marketplace_response.dart';
import 'package:mithub_app/data/repository/auth_repository.dart';
import 'package:mithub_app/utils/result.dart';

class MarketplaceDetailViewModel extends ABaseChangeNotifier {
  final AuthRepository _authRepository = serviceLocator.get();
  final ResultState<ContentDetailMarketPlace?> data = ResultState(
    useLastDataOnError: true,
  );
  late int id;

  onViewLoaded(int id) {
    this.id = id;
    getDetailProduct();
  }

  void getDetailProduct() {
    Result.call(
        future: _authRepository.getContentDetailMarketPlace(id),
        onResult: (result) {
          if (result.isSuccess) {
            data.setResult(result);
          } else {
            data.setResult(Result.error('Maaf terjadi kesalahan'));
          }
          notifyListeners();
        });
  }
}
