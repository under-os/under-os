class String
  def underscore
    gsub(/([a-z\d])([A-Z]+)/, '\1_\2').gsub('-', '_').downcase
  end

  def camelize
    gsub(/(\-|_)+([a-z])?/){|m| $2 ? $2.upcase : ''}
  end

  def dasherize
    underscore.gsub('_', '-')
  end

  def capitalize
    self[0].upcase + slice(1, size)
  end

  def starts_with?(substr)
    index(substr) == 0
  end

  def ends_with?(substr)
    rindex(substr)  == size - substr.size
  end

  def blank?
    self !~ /[^[:space:]]/
  end

  def constantize
    names = self.split('::')
    names.shift if names.empty? || names.first.empty?

    constant = Object
    names.each do |name|
      constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
    end
    constant
  end

  def to_data(encoding=nil)
    dataUsingEncoding ENCODINGS[encoding] || NSUTF8StringEncoding
  end

  ENCODINGS = {
    'utf-8'  => NSUTF8StringEncoding,
    'utf-16' => NSUTF16StringEncoding,
    'utf-32' => NSUTF32StringEncoding,
    'ascii'  => NSASCIIStringEncoding,
    'latin1' => NSISOLatin1StringEncoding,
    'latin2' => NSISOLatin2StringEncoding,
    'cp1250' => NSWindowsCP1250StringEncoding,
    'cp1251' => NSWindowsCP1251StringEncoding,
    'cp1252' => NSWindowsCP1252StringEncoding,
    'cp1253' => NSWindowsCP1253StringEncoding,
    'cp1254' => NSWindowsCP1254StringEncoding,


    # NSNEXTSTEPStringEncoding = 2,
    # NSJapaneseEUCStringEncoding = 3,
    # NSSymbolStringEncoding = 6,
    # NSNonLossyASCIIStringEncoding = 7,
    # NSShiftJISStringEncoding = 8,
    # NSISO2022JPStringEncoding = 21,
    # NSMacOSRomanStringEncoding = 30,
    # NSUTF16BigEndianStringEncoding = 0x90000100,
    # NSUTF16LittleEndianStringEncoding = 0x94000100,
    # NSUTF32BigEndianStringEncoding = 0x98000100,
    # NSUTF32LittleEndianStringEncoding = 0x9c000100,
    # NSProprietaryStringEncoding = 65536
  }
end
