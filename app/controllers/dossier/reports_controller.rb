module Dossier
  class ReportsController < ApplicationController

    def show
      @report = report_class.new(params[:options] || {})
      @report.run
      render params[:report]
    rescue ActionView::MissingTemplate => e
      render
    end

    private

    def report_class
      "#{params[:report].classify}Report".constantize
    end

  end
end
