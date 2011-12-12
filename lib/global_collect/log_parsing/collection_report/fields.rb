# -*- encoding : utf-8 -*-
module GlobalCollect::LogParsing::CollectionReport
  HEADER_TRAILER_FIELDS = [
    {
      :type     =>"N",
      :length   =>"4",
      :position =>"0004-0007",
      :name     =>"account_id",
      :field    =>"021"
    },
    {
      :type     =>"AN",
      :length   =>"12",
      :position =>"0008-0019",
      :name     =>"filename",
      :field    =>"022"
    },
    {
      :type     =>"AN",
      :length   =>"3",
      :position =>"0020-0022",
      :name     =>"filename_extension",
      :field    =>"023"
    },
    {
      :type     =>"D",
      :length   =>"8",
      :position =>"0023-0030",
      :name     =>"date_production",
      :field    =>"024"
    },
    {
      :type     =>"D",
      :length   =>"8",
      :position =>"0031-0038",
      :name     =>"period_from",
      :field    =>"025"
    },
    {
      :type     =>"D",
      :length   =>"8",
      :position =>"0039-0046",
      :name     =>"period_to",
      :field    =>"026"
    }
  ]

  DATA_FIELDS = [
    {
      :type     =>"N",
      :length   =>"4",
      :position =>"0004-0007",
      :name     =>"merchant_id",
      :field    =>"051"
    },
    {
      :type     =>"D",
      :length   =>"8",
      :position =>"0008-0015",
      :name     =>"match_date",
      :field    =>"062"
    },
    {
      :type     =>"N",
      :length   =>"4",
      :position =>"0016-0019",
      :name     =>"report_year",
      :field    =>"053"
    },
    {
      :type     =>"N",
      :length   =>"3",
      :position =>"0020-0022",
      :name     =>"report_serial_number",
      :field    =>"054"
    },
    {
      :type     =>"D",
      :length   =>"8",
      :position =>"0023-0030",
      :name     =>"report_date_from",
      :field    =>"055"
    },
    {
      :type     =>"D",
      :length   =>"8",
      :position =>"0031-0038",
      :name     =>"report_date_to",
      :field    =>"056"
    },
    {
      :type     =>"AN",
      :length   =>"4",
      :position =>"0039-0042",
      :name     =>"currency_due",
      :field    =>"057"
    },
    {
      :type     =>"N",
      :length   =>"12",
      :position =>"0043-0054",
      :name     =>"amount_due",
      :field    =>"058"
    },
    {
      :type     =>"AN",
      :length   =>"1",
      :position =>"0055-0055",
      :name     =>"amount_due_sign",
      :field    =>"910"
    },
    {
      :type     =>"AN",
      :length   =>"4",
      :position =>"0056-0059",
      :name     =>"currency_paid",
      :field    =>"059"
    },
    {
      :type     =>"N",
      :length   =>"12",
      :position =>"0060-0071",
      :name     =>"amount_paid",
      :field    =>"060"
    },
    {
      :type     =>"AN",
      :length   =>"1",
      :position =>"0072-0072",
      :name     =>"amount_paid_sign",
      :field    =>"910"
    },
    {
      :type     =>"XR",
      :length   =>"16",
      :position =>"0073-0088",
      :name     =>"exchange_rate",
      :field    =>"061"
    },
    {
      :type     =>"N",
      :length   =>"5",
      :position =>"0089-0093",
      :name     =>"rate_units",
      :field    =>"063"
    },
    {
      :type     =>"N",
      :length   =>"6",
      :position =>"0094-0099",
      :name     =>"number_of_transactions",
      :field    =>"062"
    },
    {
      :type     =>"AN",
      :length   =>"301",
      :position =>"0100-0400",
      :name     =>"filler",
      :field    =>"999"
    }
  ]
end
