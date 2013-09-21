module UnderOs::UI::Traversing
  def parent
    UnderOs::UI::View.instance_for(@_.superview)
  end

  def children
    @_.subviews.map{|v| UnderOs::UI::View.instance_for(v)}
  end
end
