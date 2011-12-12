# -*- encoding : utf-8 -*-
module GlobalCollect
   # WDL §5 TABLE 10 specifies the tokens and their meaning
  class FieldValidator
    def initialize(token, required)
      if token =~ /([A-Z]{1,2})(\d+)?/
        @type = $1
        @size = $2.to_i
        @required = (required == "R")
      else
        raise ArgumentError.new("Invalid validation token '#{token}'!")
      end
    end
    
    def to_sym
      case @type
      when "D"  then :datetime
      when "AN" then :alphanumeric
      when "N"  then :numeric
      end
    end
    
    def inspect
      "<FieldValidator #{to_sym}[#{@size}]>"
    end
    
    def validate(value)
      return false if  @required && value.nil?
      return true  if !@required && value.nil?
      value = value.to_s
      case @type
      # Examples throughout §5 suggest this date format.
      # See §5.1.3. Example for instance.
      when "D"
        size = @size.zero? ? 14 : @size
        return !!(value =~ /^\d{#{size}}$/) && (!!Time.parse(value) rescue false)
      # This is a liberal interpretation of alphanumeric, but examples like
      # §5.3.1 (IPADDRESS), §5.28.1 (CITY) suggest that spaces and punctuation
      # are acceptable as well. This leaves us just checking max size.
      when "AN"
        return !!(value =~ /^.{0,#{@size}}$/)
      # §5.28.1 (AMOUNT) seems to allow for size <= the specifier.
      when "N"
        return !!(value =~ /^\d{1,#{@size}}$/)
      end
    end
  end
end
