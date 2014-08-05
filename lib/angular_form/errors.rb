module AngularForm
  class InvalidInputTypeError < RuntimeError
    def initialize(type)
      super "Invalid type - #{type}"
    end
  end
end
