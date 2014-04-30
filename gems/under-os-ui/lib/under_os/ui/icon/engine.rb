module UnderOs::UI::IconEngine
  def self.included(base)
    base.instance_eval do
      def self.engine(engine=nil)
        @engine ||= engine
      end
    end
  end
end
