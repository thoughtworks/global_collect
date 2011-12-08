module GlobalCollect::LogParsing::FinancialStatement
  class ReportFile
    attr_reader :path, :account_id, :date, :environment, :data

    # This file's documentation in RG turns out to be a bit of a red-herring,
    # at least when it comes to v6.4.3. It's actually a tab-separated file with
    # the column order and file structure represented in the docs.

    # It also has a BOM sometimes, even though the contents are supposed to be
    # only ASCII.

    # RG - Ch10 => Technical aspects => File name
    # 4 chars numeric account id, 1 char numeric year, 3 char numeric day-of-year,
    # extension is .asc
    #
    # However, in practice it looks something like: FS55550127COMPANY.asc
    #
    FILENAME_FORMAT = /^FS(\d{4})(\d{1})(\d{3})[A-Z]+\.asc/
    YEAR_BASE_ADJUSTED = ( Date.today.year * 10 ) / 10
    def initialize(path)
      @path = path
      if File.basename(path) =~ FILENAME_FORMAT
        @account_id = $1
        @date = Date.ordinal(YEAR_BASE_ADJUSTED + $2.to_i, $3.to_i)
        @environment = :production
      else
        raise ArgumentError.new("Unparseable path '#{path}'!")
      end
    end

    def parse
      File.open(@path, "r") do |file|
        # Skip the BOM if it appears
        if (1..3).map{|i| file.getc.chr }.join != "\357\273\277"
          file.rewind
        end
        require 'csv'
        csv = CSV.new(file, :col_sep => "\t")
        hashes = csv.map{|l| convert_line(l) }
        @data = {
          :header  => hashes.first,
          :trailer => hashes.last ,
          :data   => hashes[1..-2]
        }
      end
    end

    private
    RECORD_TYPE = {
      "HDR" => :file_header ,
      "TRL" => :file_trailer,
      "FS"  => :data_record
    }
    CLASS = {
      1 => :collection_reports ,
      2 => :settlement_deposits,
      3 => :settlement_invoices,
      4 => :settlement_others
    }
    STRIP_LAMBDA = lambda {|x| x.strip }
    TO_I_LAMBDA = lambda{|x| x.to_i }
    HEADER_FIELDS = [
      [:record_type       , lambda{|x| RECORD_TYPE[x] }             ],
      [:relation_number   , STRIP_LAMBDA                            ],
      [:filename          , STRIP_LAMBDA                            ],
      [:filename_extension, STRIP_LAMBDA                            ],
      [:date_production   , lambda {|x| Date.strptime(x, "%Y%m%d") }]
    ]
    TRAILER_FIELDS = (HEADER_FIELDS + [[:number_of_records, TO_I_LAMBDA]])
    DATA_FIELDS = [
      [:record_type          , lambda{|x| RECORD_TYPE[x] }],
      [:reference_number_week, STRIP_LAMBDA               ],
      [:reference_number_year, TO_I_LAMBDA                ],
      [:class                , lambda{|x| CLASS[x.to_i] } ],
      [:account_id           , TO_I_LAMBDA                ],
      [:description          , STRIP_LAMBDA               ],
      [:currency             , STRIP_LAMBDA               ],
      [:amount               , TO_I_LAMBDA                ],
      [:amount_sign          , STRIP_LAMBDA               ]
    ]

    def convert_line(line)
      out = {}
      case RECORD_TYPE[line.first]
      when :file_header then HEADER_FIELDS
      when :file_trailer then TRAILER_FIELDS
      when :data_record then DATA_FIELDS
      end.each_with_index do |pair,i|
        out[pair.first] = pair.last.call(line[i])
      end
      out
    end
  end
end
