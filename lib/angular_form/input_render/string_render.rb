module AngularForm
  module InputRender
    class StringRender < BasicRender
      def input_helper_method
        :text_field
      end
    end
  end
end
