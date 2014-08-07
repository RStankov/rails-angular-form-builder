module AngularForm
  class Builder
    MAPPINGS = {
      string:   InputRender::StringRender,
      text:     InputRender::TextRender,
      email:    InputRender::StringRender,
      password: InputRender::StringRender,
      boolean:  InputRender::BooleanRender,
      file:     InputRender::StringRender,
      select:   InputRender::SelectRender,
    }

    def initialize(model_name, view, configuration = nil)
      @model_name    = model_name
      @view          = view
      @configuration = configuration || AngularForm.configuration
    end

    def submit(value = 'Save', options = {})
      @view.submit_tag value, {class: @configuration[:submit_class]}.merge(options)
    end

    def saved_message
      @view.content_tag :span, 'Saved!', class: 'saved', 'ng-show' => 'saved'
    end

    def input(attribute, options = {})
      options.assert_valid_keys :as, :label, :required, :hint, :control_html, :label_class, 'ng-options'
      options[:as] ||= :string

      renderer = MAPPINGS[options[:as]] or raise InvalidInputTypeError, options[:as]
      renderer.new(@model_name, attribute, options, @view, @configuration).render
    end
  end
end

