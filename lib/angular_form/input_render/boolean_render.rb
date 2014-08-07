module AngularForm
  module InputRender
    class BooleanRender < BaseRender
      def render_input
        @view.check_box model_name, attribute, input_html_attributes, true, false
      end

      def render_components
        [render_input, render_label, render_hint].compact.join.html_safe
      end

      def label_text
        "#{options[:label] || attribute.to_s.humanize}#{' <abbr>*</abbr>' if options[:required]}".html_safe
      end

      private

      def input_html_attributes
        attributes = @options[:control_html] || {}
        attributes['ng-model'] = field_binding
        attributes
      end
    end
  end
end
