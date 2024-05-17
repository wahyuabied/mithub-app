import 'package:mithub_app/core/state_management/a_base_change_notifier.dart';

class QrScannerProvider extends ABaseChangeNotifier {
  final isScannerOpenMoreThanOnceKey = 'isScannerOpenMoreThanOnceKey';
  final Function(QrScannerState) onResulted;

  /// Services
  // final _withdrawalRepository = serviceLocator.get<WithdrawalRepository>();

  /// State
  var state = QrScannerState();

  QrScannerProvider({
    required this.onResulted,
  });

// Future<void> submitQrCode(String code) async {
//   await Result.call<JsonResponse<TransactionScanQR>>(
//     future: _withdrawalRepository.getWithdrawalDraft(code),
//     onResult: (result) async {
//       if (result is Success) {
//         if (result.data.isSuccess) {
//           state.transactionData = result.data.data;
//           await fetchEwalletAccountData();
//         } else {
//           if (result.data.statMsg == 'data_not_found' &&
//               result.data.statusCode == 400) {
//             state.isErrorQrCode = true;
//           } else {
//             state.isErrorQrExpired = true;
//           }
//           state.isLoading = false;
//           notifyListeners();
//           onResulted(state);
//         }
//       } else if (result is ResultError) {
//         if (result.data.statMsg == 'data_not_found' &&
//             result.data.statusCode == 400) {
//           state.isErrorQrCode = true;
//         } else {
//           state.isErrorQrExpired = true;
//         }
//         state.isLoading = false;
//         notifyListeners();
//         onResulted(state);
//       } else if (result is Loading) {
//         state.isLoading = true;
//         notifyListeners();
//       }
//     },
//   );
// }
}

class QrScannerState {
  bool isLoading;
  bool isSuccess;
  bool isErrorQrCode;
  double balance;
  String phoneNo;

  QrScannerState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isErrorQrCode = false,
    this.balance = 0,
    this.phoneNo = '',
  });
}

class QrScannerExtra {
  final Function(String)? onScanned;
  final bool isTransaction;

  QrScannerExtra({
    this.onScanned,
    this.isTransaction = false,
  });
}

class QrPaymentExtra {
  final String productId;
  final String customerNumber;

  QrPaymentExtra({
    required this.productId,
    required this.customerNumber,
  });
}
