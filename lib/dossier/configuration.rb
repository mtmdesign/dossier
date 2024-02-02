require 'erb'
require 'yaml'

module Dossier
  class Configuration

    DB_KEY = 'DATABASE_URL'.freeze

    attr_accessor :client

    def initialize
      setup_client!
    end

    def connection_options
      dburl_config.presence || {}
    end

    def dburl_config
      Dossier::ConnectionUrl.new.to_hash if ENV.has_key? DB_KEY
    end

    private

    def setup_client!
      @client = Dossier::Client.new(connection_options)
    end

  end

  class ConfigurationMissingError < StandardError ; end
end
