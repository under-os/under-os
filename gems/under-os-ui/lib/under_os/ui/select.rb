class UnderOs::UI::Select < UnderOs::UI::Input
  wraps UIPickerView, tag: :select

  def initialize(options={})
    super

    self.options = options.delete(:options) if options[:options]
    @_.showsSelectionIndicator = true       if options[:lense]

    @_.dataSource = self
  end

  def optgroups
    @optgroups ||= [{}]
  end

  def optgroups=(list)
    @optgroups = list.map do |hash|
      {}.tap do |clean_hash|
        hash.each do |key, value|
          clean_hash[key.to_s] = value if key && value
        end
      end
    end
  end

  def options
    optgroups.size == 1 ? optgroups[0] : optgroups
  end

  def options=(value)
    self.optgroups = value.is_a?(Array) ? value : [value]
    @_.reloadAllComponents
  end

  def value
    @value ||= []
    optgroups.size == 1 ? @value[0] : @value
  end

  def value=(value)
    prev_val = @value
    @value = Array(value).map(&:to_s)
    handle_change if @value != prev_val

    @value.each_with_index do |value, group|
      i = 0;
      optgroups[group].each do |v, label|
        if value == v
          @_.selectRow i, inComponent: group, animated: false
        else
          i += 1
        end
      end
    end
  end

  def show
    page.find('select').each do |select|
      select.hide if select.visible && select != self
    end

    self.style = {bottom: -size.y, display: :block}

    animate bottom: 0
  end

  def hide
    animate bottom: -size.y, complete: -> {
      style.display = :none
    }
  end


  # UIPickerView delegate

  def numberOfComponentsInPickerView(picker)
    optgroups.size
  end

  def pickerView(picker, numberOfRowsInComponent: group)
    optgroups[group].size
  end

  def pickerView(picker, titleForRow:index, forComponent:group)
    optgroups[group].to_a[index][1]
  end

  def pickerView(picker, didSelectRow:index, inComponent:group)
    value = (@value || []).dup
    value[group] = optgroups[group].to_a[index][0]

    self.value = value
  end
end
