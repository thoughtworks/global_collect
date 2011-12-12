# -*- encoding : utf-8 -*-
module GlobalCollect::LogParsing::CollectionReport
  class AppendixReportFile
    attr_reader :path, :account_id, :date, :data, :environment

    # RG - Ch9 => Technical aspects => File name
    # 4 chars numeric account id, 8 chars date in YYYMMDD
    FILENAME_FORMAT = /^(\d{4})(\d{8})\.csv$/
    def initialize(path)
      @path = path
      if File.basename(path) =~ FILENAME_FORMAT
        @account_id = $1
        @date = Date.strptime($2, "%Y%m%d")
        @environment = :production
      else
        raise ArgumentError.new("Unparseable path '#{path}'!")
      end
    end

    def parse
      require 'csv'
      File.open(@path, "r") do |file|
        csv = CSV.new(file,
          :col_sep => ";",
          :headers => FIELDS.map(&:first)
        )
        @data = {:data_records => csv.map{|l| convert_line(l) }}
      end
    end

    private
    RECORD_TYPE = {
      "ON" => :settlement   ,
      "CR" => :refund       ,
      "CB" => :chargeback
    }
    PAYMENT_METHOD = {
      "BA" => :bank_payment,
      "CC" => :credit_card,
      "CH" => :cheque,
      "DD" => :direct_debit
    }
    PAYMENT_TYPE = {
      "P" => :payment,
      "R" => :refund_or_reversal
    }
    STRIP_LAMBDA = lambda {|x| x.strip }
    FIELDS = [
      [:record_category                , STRIP_LAMBDA                           ],
      [:record_type                    , lambda{|x| RECORD_TYPE[x] }            ],
      [:merchant_id                    , lambda {|x| x.to_i }                   ],
      [:date_due                       , lambda{|x| Date.strptime(x, "%Y%m%d") }],
      [:currency_due                   , STRIP_LAMBDA                           ],
      [:amount_due                     , lambda {|x| x.to_f }                   ],
      [:order_currency                 , STRIP_LAMBDA                           ],
      [:order_amount                   , lambda {|x| x.to_f }                   ],
      [:payment_method                 , lambda{|x| PAYMENT_METHOD[x] }         ],
      [:credit_card_company            , STRIP_LAMBDA                           ],
      [:cross_border_indicator         , STRIP_LAMBDA                           ],
      [:globalcollect_payment_reference, STRIP_LAMBDA                           ],
      [:merchant_reference             , STRIP_LAMBDA                           ],
      [:invoice_number                 , STRIP_LAMBDA                           ],
      [:customer_id                    , STRIP_LAMBDA                           ],
      [:filename_data_delivery         , STRIP_LAMBDA                           ],
      [:payment_type                   , lambda{|x| PAYMENT_TYPE[x] }           ]
    ]
    def convert_line(line)
      FIELDS.inject({}) {|memo, pair| memo[pair.first] = pair.last.call(line[pair.first]); memo }
    end
  end
end
