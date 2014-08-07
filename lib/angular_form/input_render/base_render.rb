module AngularForm
  module InputRender
    class BaseRender
      attr_reader :model_name, :attribute, :options

      def initialize(model_name, attribute, options, view, configuration)
        @model_name    = model_name
        @attribute     = attribute
        @options       = options
        @view          = view
        @configuration = configuration
      end

      def render_input
        raise NotImplementedError
      end

      def render_error_message
        @view.label_tag field_name, "{{#{error_binding}[0]}}", class: 'error'
      end

      def render_label
        @view.label_tag field_name, label_text, class: "#{@configuration[:label_class]} #{@options[:label_class]}".strip if options[:label] != false
      end

      def render_wrapper(&block)
        @view.content_tag :div, class: "#{@configuration[:wrapper_class]} #{options[:as]}", 'ng-class' => "{'has-error': #{error_binding}}", &block
      end

      def render_hint
        @view.content_tag :p, options[:hint], class: @configuration[:hint_class] if options[:hint]
      end

      def render_components
        [render_label, render_input, render_error_message, render_hint].compact.join.html_safe
      end

      def render
        render_wrapper do
          render_components
        end
      end

      private

      def field_binding
        "#{model_name}.#{attribute}"
      end

      def field_name
        "#{model_name}_#{attribute}"
      end

      def error_binding
        "#{model_name}.errors.#{attribute}"
      end

      def label_text
        "#{options[:label] || attribute.to_s.humanize}:#{' <abbr>*</abbr>' if options[:required]}".html_safe
      end
    end
  end
end
