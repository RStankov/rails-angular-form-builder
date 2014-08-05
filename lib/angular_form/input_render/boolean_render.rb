module AngularForm
  module InputRender
    class BooleanRender < BaseRender
      def render_input
        @view.check_box model_name, attribute, {'ng-model' => field_binding}, true, false
      end

      def render_components
        render_input + render_label
      end

      def label_text
        "#{options[:label] || attribute.to_s.humanize}#{' <abbr>*</abbr>' if options[:required]}".html_safe
      end
    end
  end
end
