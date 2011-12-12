# -*- encoding : utf-8 -*-
module GlobalCollect::LogParsing::PaymentReport
  class ReportFile
    attr_reader :path, :account_id, :date, :environment, :data

    # RG - Ch2 => Technical aspects => File name
    # 4 chars numeric account id, 1 char numeric year, 3 char numeric day-of-year,
    # extension /wrt/ if test, /wr\d/ if production (usually wr1).
    FILENAME_FORMAT = /^(\d{4})(\d{1})(\d{3})\.wr(.)$/
    YEAR_BASE_ADJUSTED = ( Date.today.year * 10 ) / 10
    TEST_ENV_BYTE = 't'
    def initialize(path)
      @path = path
      if File.basename(path) =~ FILENAME_FORMAT
        @account_id = $1
        @date = Date.ordinal(YEAR_BASE_ADJUSTED + $2.to_i, $3.to_i)
        @environment = (TEST_ENV_BYTE == $4) ? :test : :production
      else
        raise ArgumentError.new("Unparseable path '#{path}'!")
      end
    end

    def parse
      begin
        file = File.open(@path, "r")
        @data = GlobalCollect::LogParsing::PaymentReport::Parser.parse(file)
      ensure
        file.close
      end
    end
  end
end
