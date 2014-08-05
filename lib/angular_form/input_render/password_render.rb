module AngularForm
  module InputRender
    class PasswordRender < BasicRender
      def input_helper_method
        :password_field
      end
    end
  end
end
