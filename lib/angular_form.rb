require_relative 'angular_form/version'
require_relative 'angular_form/errors'
require_relative 'angular_form/input_render'
require_relative 'angular_form/builder'

module AngularForm
  def self.configuration
    @configuration ||= default_configuration
  end

  def self.configure(configration)
    @configuration = default_configuration.merge configration
  end

  def self.default_configuration
    @default_configuration ||= {
      wrapper_class:  'input',
      control_class:  'control',
      label_class:    nil,
      hint_class:     'hit',
      submit_class:   nil,
    }
  end
end

