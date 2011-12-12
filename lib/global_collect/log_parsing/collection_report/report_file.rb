# -*- encoding : utf-8 -*-
module GlobalCollect::LogParsing::CollectionReport
  class ReportFile
    attr_reader :path, :account_id, :master_account_id, :date, :environment, :data

    # RG - Ch8 => Technical aspects => File name
    # 4 chars numeric account id, 4 chars numeric master account id, 
    # 1 char numeric year, 3 char numeric day-of-year,
    # extension /mt\d+/ if production, and no test equivalent.
    FILENAME_FORMAT = /^(\d{4})(\d{4})(\d{1})(\d{3})\.mt\d+$/
    YEAR_BASE_ADJUSTED = Date.today.year
    def initialize(path)
      @path = path
      if File.basename(path) =~ FILENAME_FORMAT
        @account_id = $1
        @master_account_id = $2
        @date = Date.ordinal(YEAR_BASE_ADJUSTED + $3.to_i, $4.to_i)
        @environment = :production
      else
        raise ArgumentError.new("Unparseable path '#{path}'!")
      end
    end

    def parse
      begin
        file = File.open(@path, "r")
        @data = GlobalCollect::LogParsing::CollectionReport::Parser.parse(file)
      ensure
        file.close
      end
    end
  end
end
