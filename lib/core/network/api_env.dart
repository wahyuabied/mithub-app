// Simple env constant that don't need to be injected
enum ApiEnv {
  dev(
    aplusUrl: 'api-aplus-dev.amartha.id/v1/api/',
    localHost: '172.16.4.242:3000/api/v1.0/mobile/'
  ),
  prod(
    aplusUrl: 'api.amartha.net/v1/api/',
    localHost: '172.16.4.242:3000/api/v1.0/mobile/'
  );

  final String aplusUrl;
  final String localHost;

  const ApiEnv({
    required this.aplusUrl,
    required this.localHost
  });
}
