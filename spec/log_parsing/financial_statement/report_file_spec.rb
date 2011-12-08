require 'spec_helper'

describe "the financial statement report file" do
  it "should sort out the metadata from the file name" do
    report = GlobalCollect::LogParsing::FinancialStatement::ReportFile.new("FS55550148COMPANY.asc")
    report.account_id.should == "5555"
    report.date.should == Date.ordinal(2010, 148)
    report.environment.should == :production
  end

  def check_report(report)
    report.data.should_not be_blank
    report.data[:header][:record_type].should == :file_header
    report.data[:header][:relation_number].should == 'R0555500'
    report.data[:header][:date_production].should == Date.ordinal(2010, 148)

    report.data[:trailer][:record_type].should == :file_trailer
    report.data[:trailer][:number_of_records].should == 12
    report.data[:trailer][:relation_number].should == 'R0555500'
    report.data[:trailer][:date_production].should == Date.ordinal(2010, 148)

    report.data[:data].size.should == 10
    report.data[:data].each{|d| d[:record_type].should == :data_record }
    data_record = report.data[:data].first
    data_record[:reference_number_week].should == "21FR"
    data_record[:reference_number_year].should == 2010
    data_record[:class                ].should == :collection_reports
    data_record[:account_id           ].should == 5555
    data_record[:description          ].should == "25-05-2010 25-05-2010"
    data_record[:currency             ].should == "USD"
    data_record[:amount               ].should == 3333333
    data_record[:amount_sign          ].should == "+"
  end

  it "should parse with BOM" do
    report = GlobalCollect::LogParsing::FinancialStatement::ReportFile.new(support_path("FS55550148COMPANY.asc"))
    report.parse
    check_report(report)
  end

  it "should parse without BOM" do
    require 'tempfile'
    tf = Tempfile.new("FS55550148COMPANY.asc")
    tf.write(File.read(support_path("FS55550148COMPANY.asc"))[1..-1]) #remove BOM
    tf.rewind
    report = GlobalCollect::LogParsing::FinancialStatement::ReportFile.new(tf.path)
    report.parse
    check_report(report)
    tf.close(true)
  end
end
