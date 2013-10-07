class InputsPage < UnderOs::Page
  def initialize
    @single_select = first('#single-select').on(:change){|e| e.target.hide}
    @multi_select  = first('#multi-select' ).on(:change){|e| e.target.hide}

    first('#show-single-select').on(:tap){ @single_select.toggle }
    first('#show-multi-select' ).on(:tap){ @multi_select.toggle  }
  end
end
