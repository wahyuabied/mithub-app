// Simple env constant that don't need to be injected
enum ApiEnv {
  dev(
    aplusUrl: 'api-aplus-dev.amartha.id/v1/api/',
    aplusCustomerUrl: 'api-dev.amartha.id/go-customer/api/v1/',
    aplusDigitalLedgerUserUrl:
    'api-aplus-dev.amartha.id/api-digital-ledger/v1/apiUser/',
    aplusDigitalLedgerUserUrlKrakend:
    'api-dev.amartha.id/api-digital-ledger/v1/apiUser/',
    aplusPpobUrl: 'api-aplus-dev.amartha.id/ppob/v1/api/',
    aplusPpobUrlKrakend: 'api-dev.amartha.id/api-ppob/v1/api/',
    aplusRepaymentUrl: 'api-aplus-dev.amartha.id/v1/api-mitra-loan/',
    aplusPaylaterUrl: 'api-aplus-dev.amartha.id/api-pay-later/',
    aplusBuyingUrl: 'api-aplus-dev.amartha.id/',
    aplusDigitalLedgerUrl: 'api-aplus-dev.amartha.id/api-digital-ledger/',
    aplusDigitalLedgerUrlKrakend:
    'api-dev.amartha.id/api-digital-ledger/v1/',
    aplusCsrUrl: 'dev-legacy.amartha.id/',
    aplusNeobankUrl: 'api-aplus-dev.amartha.id/api-neobank/v1/',
    aplusNeobankUrlKrakend: 'api-dev.amartha.id/api-neobank/v1/',
    aplusLoanUrl: 'api-dev.amartha.id/go-borrower/api/',
    aplusLoanDisbUrl: 'api-dev.amartha.id/go-disb/api/',
    aplusPointUrl: 'api-dev.amartha.id/go-point/api/',
    aplusSavingUrl: 'api-aplus-dev.amartha.id/v2/api-saving/',
    aplusEwalletUrl: 'api-aplus-dev.amartha.id/api-wallet/v1.0/apps/',
    aplusEwalletUrlKrakend: 'api-dev.amartha.id/api-wallet/v1.0/apps/',
    aplusMicroInvestmentUrl: 'api-aplus-dev.amartha.id/v1/api-earn/apps/',
    webviewInvestmentUrl: 'dev-flip.amartha.id/apluss/',
    webviewInvestmentEarnTopUpUrl:
    'https://dev-flip.amartha.id/apluss/investment-earn',
    agentVideoTutorialUrl:
    'https://admin-aplus-dev.amartha.id/microsite/onboarding-video',
    oauthAuthorizationUri:
    'https://auth-dev.amartha.id/realms/amartha/protocol/openid-connect/auth',
    oauthRegistrationUri:
    'https://auth-dev.amartha.id/realms/amartha/protocol/openid-connect/registrations',
    oauthTokenUri:
    'https://auth-dev.amartha.id/realms/amartha/protocol/openid-connect/token',
    oauthDiscoveryUri:
    'https://auth-dev.amartha.id/realms/amartha/.well-known/openid-configuration',
    oauthEndSessionUri:
    'https://auth-dev.amartha.id/realms/amartha/protocol/openid-connect/logout',
    oauthRedirectUri: 'amarthaplus.app://aplus.amartha.com/oauth2redirect',
    oauthClientId: 'afin-dev-cCjZ53o2W9lLrpbD',
    aplusAutoDebitUrl: 'dev-wallet.amartha.id/api-auto-debit/',
    aplusAutoDebitUrlKrakend: 'api-dev.amartha.id/api-auto-debit/',
    ascoreUrl: 'ascore-gw-dev.amartha.id/',
    ascoreKeycloakUrl: 'sso-dev.amartha.id/',
    aplusModalUrl: 'api-dev.amartha.id/go-modal/api/v1/',
    aplusModalUrlService: 'go-modal.dev.amartha.id/api/v1/',
    goCustomerUrl: 'api-dev.amartha.id/api/v1/',
  ),
  prod(
    aplusUrl: 'api.amartha.net/v1/api/',
    aplusCustomerUrl: 'api.amartha.id/go-customer/api/v1/',
    aplusDigitalLedgerUserUrl: 'api.amartha.net/api-digital-ledger/v1/apiUser/',
    aplusDigitalLedgerUserUrlKrakend:
    'api.amartha.id/api-digital-ledger/v1/apiUser/',
    aplusPpobUrl: 'api.amartha.net/ppob/v1/api/',
    aplusPpobUrlKrakend: 'api.amartha.id/api-ppob/v1/api/',
    aplusRepaymentUrl: 'api.amartha.net/v1/api-mitra-loan/',
    aplusPaylaterUrl: 'api.amartha.net/api-pay-later/',
    aplusBuyingUrl: 'api.amartha.net/',
    aplusDigitalLedgerUrl: 'api.amartha.net/api-digital-ledger/',
    aplusDigitalLedgerUrlKrakend:
    'api.amartha.id/api-digital-ledger/v1/',
    aplusCsrUrl: 'amartha.id/',
    aplusNeobankUrl: 'api.amartha.net/api-neobank/v1/',
    aplusNeobankUrlKrakend: 'api.amartha.id/api-neobank/v1/',
    aplusLoanUrl: 'amartha.id/go-borrower/api/',
    aplusLoanDisbUrl: 'amartha.id/go-disb/api/',
    aplusPointUrl: 'amartha.id/go-point/api/',
    aplusSavingUrl: 'api.amartha.net/v2/api-saving/',
    aplusEwalletUrl: 'api.amartha.net/api-wallet/v1.0/apps/',
    aplusEwalletUrlKrakend: 'api.amartha.id/api-wallet/v1.0/apps/',
    aplusMicroInvestmentUrl: 'api.amartha.net/v1/api-earn/apps/',
    oauthRegistrationUri:
    'https://auth.amartha.id/realms/amartha/protocol/openid-connect/registrations',
    webviewInvestmentUrl: 'flip.amartha.id/apluss/',
    webviewInvestmentEarnTopUpUrl:
    'https://flip.amartha.id/apluss/investment-earn',
    agentVideoTutorialUrl:
    'https://admin.amartha.net/microsite/onboarding-video',
    oauthAuthorizationUri:
    'https://auth.amartha.id/realms/amartha/protocol/openid-connect/auth',
    oauthTokenUri:
    'https://auth.amartha.id/realms/amartha/protocol/openid-connect/token',
    oauthDiscoveryUri:
    'https://auth.amartha.id/realms/amartha/.well-known/openid-configuration',
    oauthEndSessionUri:
    'https://auth.amartha.id/realms/amartha/protocol/openid-connect/logout',
    oauthRedirectUri: 'amarthaplus.app://aplus.amartha.com/oauth2redirect',
    oauthClientId: 'afin',
    aplusAutoDebitUrl: 'wallet.amartha.id/api-auto-debit/',
    aplusAutoDebitUrlKrakend: 'api.amartha.id/api-auto-debit/',
    ascoreUrl: 'ascore-gw.amartha.id/',
    ascoreKeycloakUrl: 'sso.amartha.id/',
    aplusModalUrl: 'api.amartha.id/go-modal/api/v1/',
    aplusModalUrlService: 'go-modal.amartha.id/api/v1/',
    goCustomerUrl: 'api.amartha.id/api/v1/',
  );

  final String aplusUrl;
  final String aplusCustomerUrl;
  final String aplusDigitalLedgerUserUrl;
  final String aplusDigitalLedgerUserUrlKrakend;
  final String aplusPpobUrl;
  final String aplusPpobUrlKrakend;
  final String aplusRepaymentUrl;
  final String aplusPaylaterUrl;
  final String aplusBuyingUrl;
  final String aplusDigitalLedgerUrl;
  final String aplusDigitalLedgerUrlKrakend;
  final String aplusCsrUrl;
  final String aplusLoanUrl;
  final String aplusLoanDisbUrl;
  final String aplusPointUrl;
  final String aplusNeobankUrl;
  final String aplusNeobankUrlKrakend;
  final String aplusSavingUrl;
  final String aplusEwalletUrl;
  final String aplusEwalletUrlKrakend;
  final String aplusMicroInvestmentUrl;
  final String webviewInvestmentUrl;
  final String webviewInvestmentEarnTopUpUrl;
  final String agentVideoTutorialUrl;
  final String oauthClientId;
  final String oauthRedirectUri;
  final String oauthAuthorizationUri;
  final String oauthRegistrationUri;
  final String oauthTokenUri;
  final String oauthDiscoveryUri;
  final String oauthEndSessionUri;
  final String aplusAutoDebitUrl;
  final String aplusAutoDebitUrlKrakend;
  final String ascoreUrl;
  final String ascoreKeycloakUrl;
  final String aplusModalUrl;
  final String aplusModalUrlService;
  final String goCustomerUrl;

  const ApiEnv({
    required this.aplusUrl,
    required this.aplusCustomerUrl,
    required this.aplusDigitalLedgerUserUrl,
    required this.aplusDigitalLedgerUserUrlKrakend,
    required this.aplusPpobUrl,
    required this.aplusPpobUrlKrakend,
    required this.aplusRepaymentUrl,
    required this.aplusPaylaterUrl,
    required this.aplusBuyingUrl,
    required this.aplusDigitalLedgerUrl,
    required this.aplusDigitalLedgerUrlKrakend,
    required this.aplusCsrUrl,
    required this.aplusLoanUrl,
    required this.aplusLoanDisbUrl,
    required this.aplusPointUrl,
    required this.aplusNeobankUrl,
    required this.aplusNeobankUrlKrakend,
    required this.aplusSavingUrl,
    required this.aplusEwalletUrl,
    required this.aplusEwalletUrlKrakend,
    required this.aplusMicroInvestmentUrl,
    required this.webviewInvestmentUrl,
    required this.webviewInvestmentEarnTopUpUrl,
    required this.agentVideoTutorialUrl,
    required this.oauthClientId,
    required this.oauthRedirectUri,
    required this.oauthAuthorizationUri,
    required this.oauthRegistrationUri,
    required this.oauthTokenUri,
    required this.oauthDiscoveryUri,
    required this.oauthEndSessionUri,
    required this.aplusAutoDebitUrl,
    required this.aplusAutoDebitUrlKrakend,
    required this.ascoreUrl,
    required this.ascoreKeycloakUrl,
    required this.aplusModalUrl,
    required this.aplusModalUrlService,
    required this.goCustomerUrl,
  });
}
