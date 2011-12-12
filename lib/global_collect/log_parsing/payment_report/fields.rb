# -*- encoding : utf-8 -*-
module GlobalCollect::LogParsing::PaymentReport
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
      :length   =>"8",
      :position =>"0008-0015",
      :name     =>"filename",
      :field    =>"022"
    },
    {
      :type     =>"AN",
      :length   =>"3",
      :position =>"0016-0018",
      :name     =>"filename_extension",
      :field    =>"023"
    },
    {
      :type     =>"D",
      :length   =>"8",
      :position =>"0019-0026",
      :name     =>"date_production",
      :field    =>"024"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0027-0034",
      :name     =>"serial_number",
      :field    =>"025"
    },
    {
      :type     =>"D",
      :length   =>"8",
      :position =>"0035-0042",
      :name     =>"period_from",
      :field    =>"026"
    },
    {
      :type     =>"D",
      :length   =>"8",
      :position =>"0043-0050",
      :name     =>"period_to",
      :field    =>"027"
    },
    {
      :type     =>"AN",
      :length   =>"350",
      :position =>"0051-0400",
      :name     =>"filler",
      :field    =>"999"
    }
  ]

  DATA_FIELDS = [
    {
      :type     =>"AN",
      :length   =>"12",
      :position =>"0004-0015",
      :name     =>"reserved",
      :field    =>"099"
    },
    {
      :type     =>"AN",
      :length   =>"30",
      :position =>"0016-0045",
      :name     =>"order_number",
      :field    =>"602"
    },
    {
      :type     =>"AN",
      :length   =>"15",
      :position =>"0046-0060",
      :name     =>"customer_id",
      :field    =>"603"
    },
    {
      :type     =>"AN",
      :length   =>"1",
      :position =>"0061-0061",
      :name     =>"reserved",
      :field    =>"099"
    },
    {
      :type     =>"AN",
      :length   =>"30",
      :position =>"0062-0091",
      :name     =>"reference_original_payment",
      :field    =>"704"
    },
    {
      :type     =>"AN",
      :length   =>"4",
      :position =>"0092-0095",
      :name     =>"transaction_currency",
      :field    =>"606"
    },
    {
      :type     =>"AN",
      :length   =>"6",
      :position =>"0096-0101",
      :name     =>"reserved",
      :field    =>"099"
    },
    {
      :type     =>"N",
      :length   =>"12",
      :position =>"0102-0113",
      :name     =>"transaction_amount",
      :field    =>"607"
    },
    {
      :type     =>"AN",
      :length   =>"1",
      :position =>"0114-0114",
      :name     =>"transaction_amount_sign",
      :field    =>"910"
    },
    {
      :type     =>"AN",
      :length   =>"17",
      :position =>"0115-0131",
      :name     =>"reserved",
      :field    =>"099"
    },
    {
      :type     =>"D",
      :length   =>"8",
      :position =>"0132-0139",
      :name     =>"date_authorised",
      :field    =>"621"
    },
    {
      :type     =>"AN",
      :length   =>"3",
      :position =>"0140-0142",
      :name     =>"declined_reason_code",
      :field    =>"622"
    },
    {
      :type     =>"AN",
      :length   =>"25",
      :position =>"0143-0167",
      :name     =>"declined_reason_description",
      :field    =>"623"
    },
    {
      :type     =>"AN",
      :length   =>"19",
      :position =>"0168-0186",
      :name     =>"card_number",
      :field    =>"631"
    },
    {
      :type     =>"AN",
      :length   =>"4",
      :position =>"0187-0190",
      :name     =>"reserved",
      :field    =>"099"
    },
    {
      :type     =>"N",
      :length   =>"4",
      :position =>"0191-0194",
      :name     =>"expiry_date",
      :field    =>"632"
    },
    {
      :type     =>"N",
      :length   =>"2",
      :position =>"0195-0196",
      :name     =>"issue_number",
      :field    =>"633"
    },
    {
      :type     =>"AN",
      :length   =>"4",
      :position =>"0197-0200",
      :name     =>"source_id",
      :field    =>"641"
    },
    {
      :type     =>"AN",
      :length   =>"8",
      :position =>"0201-0208",
      :name     =>"authorisation_code",
      :field    =>"661"
    },
    {
      :type     =>"N",
      :length   =>"2",
      :position =>"0209-0210",
      :name     =>"payment_method_id",
      :field    =>"801"
    },
    {
      :type     =>"N",
      :length   =>"4",
      :position =>"0211-0214",
      :name     =>"payment_product_id",
      :field    =>"802"
    },
    {
      :type     =>"AN",
      :length   =>"6",
      :position =>"0215-0220",
      :name     =>"reserved",
      :field    =>"099"
    },
    {
      :type     =>"AN",
      :length   =>"2",
      :position =>"0221-0222",
      :name     =>"payment_method",
      :field    =>"255"
    },
    {
      :type     =>"AN",
      :length   =>"4",
      :position =>"0223-0226",
      :name     =>"credit_card_company",
      :field    =>"257"
    },
    {
      :type     =>"AN",
      :length   =>"1",
      :position =>"0227-0227",
      :name     =>"unclean_indicator",
      :field    =>"258"
    },
    {
      :type     =>"AN",
      :length   =>"4",
      :position =>"0228-0231",
      :name     =>"payment_currency",
      :field    =>"608"
    },
    {
      :type     =>"N",
      :length   =>"12",
      :position =>"0232-0243",
      :name     =>"payment_amount",
      :field    =>"609"
    },
    {
      :type     =>"AN",
      :length   =>"1",
      :position =>"0244-0244",
      :name     =>"payment_amount_sign",
      :field    =>"910"
    },
    {
      :type     =>"AN",
      :length   =>"4",
      :position =>"0245-0248",
      :name     =>"currency_due",
      :field    =>"267"
    },
    {
      :type     =>"N",
      :length   =>"12",
      :position =>"0249-0260",
      :name     =>"amount_due",
      :field    =>"268"
    },
    {
      :type     =>"AN",
      :length   =>"1",
      :position =>"0261-0261",
      :name     =>"amount_due_sign",
      :field    =>"910"
    },
    {
      :type     =>"D",
      :length   =>"8",
      :position =>"0262-0269",
      :name     =>"date_due",
      :field    =>"663"
    },
    {
      :type     =>"AN",
      :length   =>"1",
      :position =>"0270-0270",
      :name     =>"authorisation_indicator",
      :field    =>"659"
    },
    {
      :type     =>"AN",
      :length   =>"8",
      :position =>"0271-0278",
      :name     =>"authorisation_code",
      :field    =>"661"
    },
    {
      :type     =>"AN",
      :length   =>"42",
      :position =>"0279-0320",
      :name     =>"filler",
      :field    =>"999"
    },
    {
      :type     =>"AN",
      :length   =>"4",
      :position =>"0321-0324",
      :name     =>"currency_original_payment",
      :field    =>"701"
    },
    {
      :type     =>"N",
      :length   =>"12",
      :position =>"0325-0336",
      :name     =>"amount_original_payment",
      :field    =>"702"
    },
    {
      :type     =>"AN",
      :length   =>"1",
      :position =>"0337-0337",
      :name     =>"amount_original_payment_sign",
      :field    =>"910"
    },
    {
      :type     =>"AN",
      :length   =>"12",
      :position =>"0338-0349",
      :name     =>"reserved",
      :field    =>"099"
    },
    {
      :type     =>"AN",
      :length   =>"20",
      :position =>"0350-0369",
      :name     =>"order_number_original_payment",
      :field    =>"707"
    },
    {
      :type     =>"AN",
      :length   =>"15",
      :position =>"0370-0384",
      :name     =>"customer_id_original_payment",
      :field    =>"708"
    },
    {
      :type     =>"AN",
      :length   =>"2",
      :position =>"0385-0386",
      :name     =>"charge_back_reason_id",
      :field    =>"767"
    },
    {
      :type     =>"AN",
      :length   =>"25",
      :position =>"0387-0411",
      :name     =>"charge_back_reason_desc",
      :field    =>"768"
    },
    {
      :type     =>"D",
      :length   =>"8",
      :position =>"0412-0419",
      :name     =>"date_collected_original_payment",
      :field    =>"756"
    },
    {
      :type     =>"AN",
      :length   =>"1",
      :position =>"0420-0420",
      :name     =>"filler",
      :field    =>"999"
    },
    {
      :type     =>"AN",
      :length   =>"4",
      :position =>"0321-0324",
      :name     =>"currency_original_payment",
      :field    =>"701"
    },
    {
      :type     =>"N",
      :length   =>"12",
      :position =>"0325-0336",
      :name     =>"amount_original_payment",
      :field    =>"702"
    },
    {
      :type     =>"AN",
      :length   =>"1",
      :position =>"0337-0337",
      :name     =>"amount_original_payment_sign",
      :field    =>"910"
    },
    {
      :type     =>"AN",
      :length   =>"12",
      :position =>"0338-0349",
      :name     =>"reserved",
      :field    =>"099"
    },
    {
      :type     =>"AN",
      :length   =>"20",
      :position =>"0350-0369",
      :name     =>"order_number_original_payment",
      :field    =>"707"
    },
    {
      :type     =>"AN",
      :length   =>"15",
      :position =>"0370-0384",
      :name     =>"customer_id_original_payment",
      :field    =>"706"
    },
    {
      :type     =>"AN",
      :length   =>"36",
      :position =>"0385-0420",
      :name     =>"filler",
      :field    =>"999"
    }
  ]

  BATCH_HEADER_FIELDS = [
    {
      :type     =>"N",
      :length   =>"4",
      :position =>"0004-0007",
      :name     =>"merchant_id",
      :field    =>"050"
    },
    {
      :type     =>"AN",
      :length   =>"27",
      :position =>"0008-0034",
      :name     =>"reserved",
      :field    =>"099"
    },
    {
      :type     =>"D",
      :length   =>"8",
      :position =>"0035-0042",
      :name     =>"period_from",
      :field    =>"826"
    },
    {
      :type     =>"D",
      :length   =>"8",
      :position =>"0043-0050",
      :name     =>"period_to",
      :field    =>"827"
    },
    {
      :type     =>"AN",
      :length   =>"350",
      :position =>"0051-0400",
      :name     =>"filler",
      :field    =>"999"
    }
  ]

  BATCH_TRAILER_FIELDS = [
    {
      :type     =>"N",
      :length   =>"4",
      :position =>"0004-0007",
      :name     =>"merchant_id",
      :field    =>"050"
    },
    {
      :type     =>"AN",
      :length   =>"27",
      :position =>"0008-0034",
      :name     =>"reserved",
      :field    =>"099"
    },
    {
      :type     =>"D",
      :length   =>"8",
      :position =>"0035-0042",
      :name     =>"period_from",
      :field    =>"826"
    },
    {
      :type     =>"D",
      :length   =>"8",
      :position =>"0043-0050",
      :name     =>"period_to",
      :field    =>"827"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0051-0058",
      :name     =>"number_of_records",
      :field    =>"828"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0059-0066",
      :name     =>"number_of_sent_invoices",
      :field    =>"829"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0067-0074",
      :name     =>"number_of_rejected_invoices",
      :field    =>"830"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0075-0082",
      :name     =>"number_of_invoice_payments",
      :field    =>"831"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0083-0090",
      :name     =>"number_of_conv_invoice_payment",
      :field    =>"832"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0091-0098",
      :name     =>"number_of_corrections_on_payments",
      :field    =>"833"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0099-0106",
      :name     =>"number_of_reversals",
      :field    =>"834"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0107-0114",
      :name     =>"number_of_corrections_on_reversals",
      :field    =>"835"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0115-0122",
      :name     =>"number_of_rejected_card_payments",
      :field    =>"836"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0123-0130",
      :name     =>"number_of_card_refunds",
      :field    =>"837"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0131-0138",
      :name     =>"number_of_corrections_card_refunds",
      :field    =>"838"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0139-0146",
      :name     =>"number_of_collected_card_on_line",
      :field    =>"839"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0147-0154",
      :name     =>"number_of_collected_card_off_line",
      :field    =>"840"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0155-0162",
      :name     =>"number_of_collected_card_refunds",
      :field    =>"841"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0163-0170",
      :name     =>"number_of_collected_card_charge_backs",
      :field    =>"842"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0171-0178",
      :name     =>"number_of_rejected_card_on_line",
      :field    =>"843"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0179-0186",
      :name     =>"number_of_rejected_card_off_line",
      :field    =>"844"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0187-0194",
      :name     =>"number_of_direct_debit_orders_rejected",
      :field    =>"845"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0195-0202",
      :name     =>"number_of_direct_debit_orders_rejected_by_bank",
      :field    =>"846"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0203-0210",
      :name     =>"number_of_collected_direct_debit_payments",
      :field    =>"847"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0211-0218",
      :name     =>"number_of_reversed_direct_debit_payments",
      :field    =>"848"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0219-0226",
      :name     =>"filler",
      :field    =>"849"
    },
    {
      :type     =>"N",
      :length   =>"8",
      :position =>"0227-0234",
      :name     =>"number_of_withdrawn_chargebacks",
      :field    =>"850"
    },
    {
      :type     =>"AN",
      :length   =>"166",
      :position =>"0235-0400",
      :name     =>"filler",
      :field    =>"999"
    }
  ]

  INFORMATION_FIELDS = [
    {
      :type=>"N",
      :length=>"4",
      :position=>"0004-0007",
      :name=>"merchant_id",
      :field=>"050"
    },
    {
      :type=>"AN",
      :length=>"217",
      :position=>"0008-0224",
      :name=>"reserved",
      :field=>"099"
    },
    {
      :type=>"AN",
      :length=>"4",
      :position=>"0225-0228",
      :name=>"currency_due",
      :field=>"267"
    },
    {
      :type=>"N",
      :length=>"12",
      :position=>"0229-0240",
      :name=>"total_amount_due",
      :field=>"868"
    },
    {
      :type=>"AN",
      :length=>"1",
      :position=>"0241-0241",
      :name=>"total_amount_due_sign",
      :field=>"910"
    },
    {
      :type=>"AN",
      :length=>"159",
      :position=>"0242-0400",
      :name=>"filler",
      :field=>"999"
    }
  ]
end
