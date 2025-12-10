enum Environment { dev, stag, prod }

class EnvironmentConstants {
  static late String baseUrl = '';
  static late String supabaseUrl = '';
  static late String supabaseAnonKey = '';

  static void setEnvVariables(Environment env) {
    switch (env) {
      /*Currently value for all environments are same but if we have different 
      supabase project or database endpoint we can use that one according to env. */
      case Environment.dev:
        baseUrl = 'https://dev-app.referral.com';
        supabaseUrl = 'https://dvtdjhugyjvkjbzhhxgk.supabase.co';
        supabaseAnonKey =
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR2dGRqaHVneWp2a2piemhoeGdrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjUzNDg4NTgsImV4cCI6MjA4MDkyNDg1OH0.k9ghwuf02Tr88s1bixcldsn76QAjJRPr0QCsmGkmo2A';
        break;
      case Environment.prod:
        baseUrl = 'https://api.referral.com/';
        supabaseUrl = 'https://dvtdjhugyjvkjbzhhxgk.supabase.co';
        supabaseAnonKey =
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR2dGRqaHVneWp2a2piemhoeGdrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjUzNDg4NTgsImV4cCI6MjA4MDkyNDg1OH0.k9ghwuf02Tr88s1bixcldsn76QAjJRPr0QCsmGkmo2A';
        break;
      case Environment.stag:
        baseUrl = 'https://api.referral.com/';
        supabaseUrl = 'https://dvtdjhugyjvkjbzhhxgk.supabase.co';
        supabaseAnonKey =
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR2dGRqaHVneWp2a2piemhoeGdrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjUzNDg4NTgsImV4cCI6MjA4MDkyNDg1OH0.k9ghwuf02Tr88s1bixcldsn76QAjJRPr0QCsmGkmo2A';
        break;
    }
  }
}
