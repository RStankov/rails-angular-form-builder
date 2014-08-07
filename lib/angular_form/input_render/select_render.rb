module AngularForm
  module InputRender
    class SelectRender < BaseRender
      def render_input
        @view.select model_name, attribute, [], {}, input_html_attributes
      end

      private

      def input_html_attributes
        attributes = @options[:control_html] || {}
        attributes[:class] = "#{attributes[:class]} #{@configuration[:control_class]}".strip
        attributes['ng-model'] = field_binding
        attributes['ng-options'] = options['ng-options'] if options['ng-options'].present?
        attributes
      end
    end
  end
end
