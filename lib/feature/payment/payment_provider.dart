import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/core/network/core_http_repository.dart';
import 'package:mithub_app/core/state_management/a_base_change_notifier.dart';
import 'package:mithub_app/core/storage/core_secure_storage.dart';
import 'package:mithub_app/data/dto_content_detail_marketplace_response.dart';
import 'package:mithub_app/data/dto_inquiry_transfer_response.dart';
import 'package:mithub_app/data/repository/auth_repository.dart';
import 'package:mithub_app/feature/scanner/qr_scanner_provider.dart';
import 'package:mithub_app/utils/result.dart';

class PaymentProvider extends ABaseChangeNotifier {
  final AuthRepository _authRepository = serviceLocator.get();
  final CoreSecureStorage _storage = serviceLocator.get();
  final ResultState<ContentDetailMarketPlace?> data = ResultState(
    useLastDataOnError: true,
  );

  var productId = '';
  var customerNumber = '';
  var quantity = 1;

  var accountNumber = '';
  var beneficiaryAccountNumber = '';
  var price = 0;
  var amount = 0;
  var phone = '';

  PaymentProvider(QrPaymentExtra? extra) {
    productId = extra?.productId ?? '';
    customerNumber = extra?.customerNumber ?? '';
    getDetailProduct();
  }

  void getDetailProduct() {
    Result.call(
        future:
            _authRepository.getContentDetailMarketPlace(int.parse(productId)),
        onResult: (result) {
          if (result.isSuccess) {
            price = result.dataOrNull?.price ?? 0;
            amount = price;
            data.setResult(result);
          } else {
            data.setResult(Result.error('Maaf terjadi kesalahan'));
          }
          notifyListeners();
        });
  }

  plusQuantity() {
    quantity++;
    amount = price * quantity;
    notifyListeners();
  }

  minusQuantity() {
    if (quantity > 1) {
      quantity--;
      amount = price * quantity;
      notifyListeners();
    }
  }

  Future<InquiryTransferResponse?> inquiry() async {
    price = data.lastData?.price ?? 0;
    amount = price * quantity;
    phone =
        await _storage.getString(AuthRepository.phoneNumber).then((value) {
      return value;
    });
    accountNumber = await _storage
        .getString(CoreHttpRepository.coreAccountNumber)
        .then((value) {
      return value;
    });

    final response =
        await _authRepository.getAccountNumber(customerNumber).then((value) {
      if (value != null) {
        return value;
      }
    });

    beneficiaryAccountNumber = response?.accountNumber ?? '';
    return await _authRepository.inquiryTransfer(
      accountNumber,
      response?.accountNumber ?? '',
      amount,
    );
  }

  searchProduct() {}
}
