class CalculatorPage < UnderOs::Page

  def initialize
    @label = first('#result')

    find('button').each do |b|
      b.on(:tap){|e| handle_tap(e)}
    end
  end

  def handle_tap(event)
    case event.target.text
    when '0','1','2','3','4','5','6','7','8','9','.'
      @label.text  = '' if ['0', @first_value].include?(@label.text)
      @label.text += event.target.text if @label.text.size < 18
    when '÷','×','-','+'
      @first_value = @label.text
      @operator    = {'÷'=>'/','×'=>'*','-'=>'-','+'=>'+'}[event.target.text]
    when 'C'
      @first_value = nil
      @label.text  = '0'
    when '='
      calculate
    end
  end

  def calculate
    return if ! @first_value

    values = [@first_value, @label.text]
    values = values.any?{|v| v.include?('.')} ? values.map(&:to_f) : values.map(&:to_i)

    @label.text = values[0].send(@operator, values[1]).to_s
  end

end
