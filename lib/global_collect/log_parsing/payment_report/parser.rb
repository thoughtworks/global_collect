# -*- encoding : utf-8 -*-
module GlobalCollect::LogParsing::PaymentReport
  class Parser
    def self.parse(file)
      FixedWidth.parse(file, :payment_report)
    end

    private

    RECORD_CATEGORY = {
      "X" => :processed  ,
      "+" => :collected  ,
      "-" => :reversed   ,
      "I" => :information
    }

    RECORD_TYPE = {
      "FH" => :file_header  ,
      "FT" => :file_trailer ,
      "BH" => :batch_header ,
      "BT" => :batch_trailer,
      "ON" => :settlement   ,
      "RS" => :refusal      ,
      "RN" => :rejection    ,
      "CR" => :refund       ,
      "CB" => :chargeback
    }

    DATA_GROUPS = {
      0..21  => :order,
      22..34 => :payment,
      35..44 => :chargeback,
      45..51 => :refund
    }
    def self.data_group(index)
      DATA_GROUPS.detect{|range, group| range.include?(index) }.last
    end

    DATE_LAMBDA = lambda {|d| Date.strptime(d, "%Y%m%d") }
    def self.options_for_format(format)
      case format
      when "N"  then { :align => :right, :parser => :to_i }
      when "AN" then { :align => :left }
      when "D"  then { :parser => DATE_LAMBDA }
      else raise ArgumentError.new("Unknown field format '#{format.inspect}'!")
      end
    end

    SPACERS = ['reserved', 'filler']
    def self.make_column(section, field, options={})
      if SPACERS.include?(field[:name])
        section.spacer(field[:length].to_i, ' ')
      else
        section.column(field[:name].to_sym, field[:length].to_i, options_for_format(field[:type]).merge(options))
      end
    end

    DEFINITION = FixedWidth.define(:payment_report, :nil_blank => true) do |pr|
      pr.template :record_info do |ri|
        ri.record_category 1, :parser => lambda{|x| RECORD_CATEGORY[x] }
        ri.record_type     2, :parser => lambda{|x| RECORD_TYPE[x]     }
      end
      pr.template :header_trailer do |hf|
        HEADER_TRAILER_FIELDS.each {|field| make_column(hf, field) }
      end

      pr.header do |h|
        h.trap { |line| line[0,3] == 'IFH' }
        h.template :record_info
        h.template :header_trailer
      end

      pr.batch_header do |bh|
        bh.trap { |line| line[0,3] == 'IBH' }
        bh.template :record_info
        BATCH_HEADER_FIELDS.each {|field| make_column(bh, field) }
      end

      pr.data_records(:optional => true) do |d|
        d.trap { |line| line =~ /^[X,-,+]/ }
        d.template :record_info
        DATA_FIELDS.each_with_index do |field, index|
          make_column(d, field, :group => data_group(index))
        end
      end

      pr.information_records(:optional => true) do |info|
        info.trap { |line| line[0,3] == 'ITM' }
        info.template :record_info
        INFORMATION_FIELDS.each {|field| make_column(info, field) }
      end

      pr.batch_trailer do |bt|
        bt.trap { |line| line[0,3] == 'IBT' }
        bt.template :record_info
        BATCH_TRAILER_FIELDS.each {|field| make_column(bt, field) }
      end

      pr.trailer do |t|
        t.trap { |line| line[0,3] == 'IFT' }
        t.template :record_info
        t.template :header_trailer
      end
    end
  end
end
