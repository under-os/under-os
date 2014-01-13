class HomePage < UOS::Page
  def initialize
    first("button").on :tap do
      alert("Hello World!")
    end
  end
end
