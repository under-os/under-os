module UnderOs::UI::IconEngine
  def self.included(base)
    base.instance_eval do
      def self.engine(name=nil)
        @engine = UnderOs::UI.const_get("IconEngine#{name}") if name
        @engine
      end
    end
  end
end
