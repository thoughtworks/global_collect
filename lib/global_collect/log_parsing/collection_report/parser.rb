# -*- encoding : utf-8 -*-
module GlobalCollect::LogParsing::CollectionReport
  class Parser
    def self.parse(file)
      FixedWidth.parse(file, :collection_report)
    end

    private

    RECORD_TYPE = {
      "HDR" => :file_header,
      "POV" => :data_record,
      "TRL" => :file_trailer
    }

    # RG - Ch8 => Technical aspects => Field Format
    # Exchange rates always have 8 decimal places of precision.
    EXCHANGE_RATE_LAMBDA = lambda{|x| "#{x[0..-9]}.#{x[-8..-1]}".to_f }
    DATE_LAMBDA = lambda {|d| Date.strptime(d, "%Y%m%d") }
    def self.options_for_format(format)
      case format
      when "N"  then { :align => :right, :parser => :to_i }
      when "AN" then { :align => :left }
      when "D"  then { :parser => DATE_LAMBDA }
      when "XR"  then { :parser => EXCHANGE_RATE_LAMBDA }
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

    DEFINITION = FixedWidth.define(:collection_report, :nil_blank => true) do |pr|
      pr.template :record_info do |ri|
        ri.record_type 3, :parser => lambda{|x| RECORD_TYPE[x] }
      end
      pr.template :header_trailer do |hf|
        HEADER_TRAILER_FIELDS.each {|field| make_column(hf, field) }
      end

      pr.header(:singular => true) do |h|
        h.trap { |line| line[0,3] == 'HDR' }
        h.template :record_info
        h.template :header_trailer
        h.spacer 354
      end

      pr.data_records(:optional => true) do |d|
        d.trap { |line| line[0,3] == "POV" }
        d.template :record_info
        DATA_FIELDS.each {|field| make_column(d, field) }
      end

      pr.trailer(:singular => true) do |t|
        t.trap { |line| line[0,3] == 'TRL' }
        t.template :record_info
        t.template :header_trailer
        t.column   :number_of_records, 8, :parser => :to_i
        t.spacer 346
      end
    end
  end
end
