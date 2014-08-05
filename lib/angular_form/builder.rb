module AngularForm
  class Builder
    MAPPINGS = {
      string:   InputRender::StringRender,
      text:     InputRender::TextRender,
      email:    InputRender::EmailRender,
      password: InputRender::PasswordRender,
      boolean:  InputRender::BooleanRender,
    }

    def initialize(model_name, view)
      @model_name = model_name
      @view = view
    end

    def submit(value = 'Save', options = {})
      @view.submit_tag value, options
    end

    def saved_message
      @view.content_tag :span, 'Saved!', class: 'saved', 'ng-show' => 'saved'
    end

    def input(attribute, options = {})
      options.assert_valid_keys :as, :label, :required
      options[:as] ||= :string

      renderer = MAPPINGS[options[:as]] or raise InvalidInputTypeError, options[:as]
      renderer.new(@model_name, attribute, options, @view).render
    end
  end
end
