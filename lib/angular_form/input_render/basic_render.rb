module AngularForm
  module InputRender
    class BasicRender < BaseRender
      def render_input
        @view.public_send input_helper_method, model_name, attribute, class: 'control', 'ng-model' => field_binding
      end

      private

      def input_helper_method
        raise NotImplementedError
      end
    end
  end
end
