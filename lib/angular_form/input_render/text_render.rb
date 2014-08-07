module AngularForm
  module InputRender
    class TextRender < StringRender
      def render_input
        @view.text_area model_name, attribute, input_html_attributes
      end
    end
  end
end
