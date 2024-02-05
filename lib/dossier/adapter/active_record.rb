module Dossier
  module Adapter
    class ActiveRecord

      attr_accessor :options

      def initialize(options = {})
        self.options    = options
      end

      def escape(value)
        connection.quote(value)
      end

      def execute(query, report_name = nil)
        results = ::ActiveRecord::Base.connection_pool.with_connection do |conn|
          # Ensure that SQL logs show name of report generating query
          conn.exec_query(*["\n#{query}", report_name].compact)
        end

        Result.new(results)
      end
    end
  end
end
