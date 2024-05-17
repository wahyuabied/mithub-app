import 'package:mithub_app/core/state_management/a_base_change_notifier.dart';
import 'package:mithub_app/feature/scanner/qr_scanner_provider.dart';

class PaymentProvider extends ABaseChangeNotifier {
  var productId = '';
  var customerNumber = '';
  var quantity = 1;

  PaymentProvider(QrPaymentExtra? extra) {
    productId = extra?.productId ?? '';
    customerNumber = extra?.customerNumber ?? '';
  }

  plusQuantity() {
    quantity++;
    notifyListeners();
  }

  minusQuantity() {
    quantity--;
    notifyListeners();
  }

  searchWallet() {}

  searchProduct() {}
}
