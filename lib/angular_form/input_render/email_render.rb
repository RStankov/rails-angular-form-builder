module AngularForm
  module InputRender
    class EmailRender < BasicRender
      def input_helper_method
        :email_field
      end
    end
  end
end
