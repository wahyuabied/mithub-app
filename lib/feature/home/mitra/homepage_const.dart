import 'package:mithub_app/design/app_assets.dart';

enum HomePpobMenu {
  belanja(name: 'Belanja', icon: AppAssets.icBelanja),
  pulsa(name: 'Pulsa', icon: AppAssets.icPulsa),
  paketData(name: 'Paket Data', icon: AppAssets.icPaketData),
  listrik(name: 'Listrik', icon: AppAssets.icListrik),
  bpjs(name: 'BPJS', icon: AppAssets.icBpjs),
  pdam(name: 'PDAM', icon: AppAssets.icPdam),
  eWallet(name: 'E-Wallet', icon: AppAssets.icEwallet),
  topUpGame(name: 'TopUp Game', icon: AppAssets.icTopUpGame),
  cicilan(name: 'Cicilan Kredit', icon: AppAssets.icCicilan),
  other(name: 'Lainnya', icon: AppAssets.icPpobLainnya);

  const HomePpobMenu({required this.name, required this.icon});

  final String name;
  final String icon;

  static const homeDisplayMenus = [
    belanja,
    pulsa,
    paketData,
    listrik,
    bpjs,
    pdam,
    eWallet,
    topUpGame,
    cicilan,
  ];
}

class RolesConst {
  static const mitra = 'mitra';
  static const agentAmarthaOne = 'agent_amartha_one';
  static const employee = 'employee';
}

class FeatureConst {
  static const featureSaving = 'saving';
  static const featurePoket = 'poket';
  static const featureEarn = 'earn';
  static const featurePpob = 'ppob';
  static const featureCommerce = 'commerce';
  static const featureAgentAmarthaOne = 'agent amartha one';
}
