// Simple env constant that don't need to be injected
enum ApiEnv {
  dev(
    aplusUrl: 'api-aplus-dev.amartha.id/v1/api/',
    localHost: '20.20.24.134:3000/api/v1.0/apps/',
    localHostApp: '20.20.24.134:3000/api/v1.0/apps/'
  ),
  prod(
    aplusUrl: 'api.amartha.net/v1/api/',
    localHost: '20.20.24.123:3000/api/v1.0/apps/',
    localHostApp: '20.20.24.123:3000/api/v1.0/apps/'
  );

  final String aplusUrl;
  final String localHost;
  final String localHostApp;

  const ApiEnv({
    required this.aplusUrl,
    required this.localHost,
    required this.localHostApp
  });
}
