enum Environment { dev, uat, prod }

class EnvironmentConstants {
  static late String baseUrl = '';

  static void setEnvVariables(Environment env) {
    switch (env) {
      case Environment.dev:
        baseUrl = 'https://dev-app.referral.com'; //just a example url
        //urls depend on dev  env
        break;
      case Environment.prod:
        baseUrl = 'https://api.referral.com/';
        //urls depend on prod env
        break;
      case Environment.uat:
        baseUrl = 'https://api.referral.com/';
        //urls depend on uat env
        break;
    }
  }
}
