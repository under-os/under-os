class UnderOs::UI::Form < UnderOs::UI::View
  tag :form

  def elements
    find('*').select do |view|
      view.is_a?(UnderOs::UI::Input) || view._.is_a?(UIButton)
    end
  end

  def inputs
    find('*').select do |view|
      view.is_a?(UnderOs::UI::Input)
    end
  end

  def values
    {}.tap do |values|
      inputs.each do |input|
        next if input.disabled || ! input.name || (input.is_a?(UnderOs::UI::Switch) && !input.checked)

        hash = values; key = nil
        keys = input.name.scan(/[^\[]+/)

        # getting throught the smth[smth][smth][] in the name
        while keys.size > 1
          key = keys.shift
          key = key.slice(0, key.size-1) if key.ends_with?(']')

          hash[key] = keys[0] == ']' ? [] : {} if ! hash[key]
          hash = hash[key]
        end

        key = keys.shift
        key = key.slice(0, key.size-1) if key.ends_with?(']')

        if hash.is_a?(Array)
          hash << input.value
        else
          hash[key] = input.value
        end
      end
    end
  end

  def disable
    elements.each(&:disable)
    self
  end

  def enable
    elements.each(&:enable)
    self
  end

  def focus
    if input = inputs.first
      input.focus
    end
  end
end
