require 'omniauth/strategies/oauth2'
require 'base64'
require 'rack/utils'

module OmniAuth
  module Strategies
    class Reddit < OmniAuth::Strategies::OAuth2
      option :name, "reddit"
      option :authorize_options, [:scope, :duration]

      option :client_options, {
        site: 'https://www.reddit.com',
        authorize_url: '/api/v1/authorize',
        token_url: '/api/v1/access_token'
      }

      uid { raw_info['id'] }

      info do
        {
          nickname: raw_info['name'],
          email: raw_info['email'],
          image: raw_info['icon_img'],
          verified: raw_info['verified']
        }
      end

      extra do
        {
          raw_info: raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/me').parsed
      end

    end
  end
end
