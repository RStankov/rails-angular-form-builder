module AngularForm
  module InputRender
    class StringRender < BaseRender
      def render_input
        @view.text_field model_name, attribute, input_html_attributes
      end

      private

      def input_html_attributes
        attributes = @options[:control_html] || {}
        attributes[:class] = "#{attributes[:class]} #{@configuration[:control_class]}".strip
        attributes['ng-model'] = field_binding
        attributes['type'] = options[:as] unless options[:as] == 'string'
        attributes
      end
    end
  end
end

