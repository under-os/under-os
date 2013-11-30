#
# This is a bridge to the iOS native functionality
# please do not use it in your code
#
class UnderOs::UI::Collection::Cell < UICollectionViewCell

  def self.classes
    @classes ||= {}
  end

  def uos_view_for(collection)
    @uos_view ||= self.class.classes[collection].for(collection).tap do |view|
      contentView.addSubview(view._)
    end
  end

  def prepareForReuse
    super
    @uos_view.cleanup if @uos_view
  end
end
