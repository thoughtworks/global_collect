# -*- encoding : utf-8 -*-
module GlobalCollect::Const
  module PaymentProduct
    def self.from_sym(sym)
      info(sym)
    end
    
    def self.from_code(code)
      sym = PRODUCTS.detect{|k,v| v.first == code.to_i }.first
      from_sym(sym)
    end
    
    private
    def self.info(sym)
      raise ArgumentError.new("Invalid payment product symbol ''!") unless PRODUCTS[sym]
      Product.new(sym, *PRODUCTS[sym])
    end
    class Product < Struct.new(:symbol, :code, :description)
      def to_s
        symbol.to_s
      end
    end
    
    PRODUCTS = {
       :visa          => [1  , "Visa Online"            ],
       :amex          => [2  , "American Express Online"],
       :mc            => [3  , "MasterCard Online"      ],
       :offline_bank  => [11 , "Offline Bank Transfer"  ],
       :visa_delta    => [111, "Visa Delta"             ],
       :maestro       => [117, "Maestro"                ],
       :solo          => [118, "Solo"                   ],
       :visa_electron => [122, "Visa Electron"          ],
       :dankort       => [123, "Dankort"                ],
       :laser         => [124, "Laser"                  ],
       :jcb           => [125, "JCB"                    ],
       :discover      => [128, "Discover"               ],
       :carte_bleue   => [130, "Carte Bleue Online"     ],
       :paypal        => [840, "PayPal"                 ]
    }
  end
end
