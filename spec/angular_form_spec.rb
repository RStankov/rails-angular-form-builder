require 'spec_helper'

describe AngularForm do
  let(:builder) { AngularForm::Builder.new :product, helper, AngularForm.default_configuration }

  describe "#input" do
    specify "class names are globally configured" do
      configuration = {
        wrapper_class:  'form-group',
        control_class:  'form-control',
        label_class:    'control-label',
        hint_class:     'help-block',
      }

      input_html = AngularForm::Builder.new(:product, helper, configuration).input(:name, hint: 'text')

      expect(input_html).to have_selector 'div.form-group'
      expect(input_html).to have_selector 'input.form-control'
      expect(input_html).to have_selector 'label.control-label'
      expect(input_html).to have_selector 'p.help-block'
    end

    context "options" do
      specify "(default)" do
        expect(builder.input(:name)).to have_tag :div, with: {class: 'input string'} do
          with_tag :label, for: 'product_name', text: 'Name:'
          with_tag :input, type: 'text', class: 'control', id: 'product_name', 'ng-model' => 'product.name'
          with_tag :label, for: 'product_name', class: 'error', text: '{{product.errors.name[0]}}'
        end
      end

      specify "required" do
        expect(builder.input(:name, required: true)).to have_tag :div, with: {class: 'input string'} do
          with_tag :label, for: 'product_name', html: 'Name: <abbr>*</abbr>'
          with_tag :input, type: 'text', class: 'control', id: 'product_name', 'ng-model' => 'product.name'
          with_tag :label, for: 'product_name', class: 'error', text: '{{product.errors.name[0]}}'
        end
      end

      describe "label" do
        it "renders label when is specified" do
          expect(builder.input(:name, label: 'LABEL TEXT')).to have_tag :div, with: {class: 'input string'} do
            with_tag :label, for: 'product_name', text: 'LABEL TEXT:'
            with_tag :input, type: 'text', class: 'control', id: 'product_name', 'ng-model' => 'product.name'
            with_tag :label, for: 'product_name', class: 'error', text: '{{product.errors.name[0]}}'
          end
        end

        it "renders label as humanized attribute when not specified" do
          expect(builder.input(:name)).to have_tag :label, for: 'product_name', text: 'Name:'
        end

        it "doesn't render label when label is 'false'" do
          expect(builder.input(:name, label: false)).not_to have_tag :label, for: 'product_name', text: 'Name:'
        end
      end

      describe "hint" do
        it "renders hint when hint is specified" do
          expect(builder.input(:name, hint: 'HINT')).to have_tag :p, class: 'hint', text: 'HINT'
        end

        it "doesn't render hint when hint isn't specified (default)" do
          expect(builder.input(:name, hint: false)).not_to have_tag :p, class: 'hint'
        end
      end

      describe "control_html" do
        it "adds html attribute to the input tag" do
          expect(builder.input(:name, control_html: {'ng-click' => 'method()'})).to have_selector %Q(input[ng-click="method()"])
        end

        it "adds up css classes" do
          expect(builder.input(:name, control_html: {class: 'custom'})).to have_selector %Q(input.control.custom)
        end
      end

      describe "label_class" do
        it "adds additional label class" do
          expect(builder.input(:name, label_class: 'custom')).to have_selector %Q(label.custom)
        end
      end

      describe "ng-options" do
        it "adds ng-options to selects" do
          expect(builder.input(:size, as: :select, 'ng-options' => 'size for size in sizes')).to have_selector %Q(select[ng-options="size for size in sizes"])
        end
      end
    end

    context "types" do
      specify "as string (default)" do
        expect(builder.input(:name, as: :string)).to have_tag :div, with: {class: 'input string'} do
          with_tag :label, for: 'product_name', text: 'Name:'
          with_tag :input, type: 'text', class: 'control', id: 'product_name', 'ng-model' => 'product.name'
          with_tag :label, for: 'product_name', class: 'error', text: '{{product.errors.name[0]}}'
        end
      end

      specify "as email" do
        expect(builder.input(:email, as: :email)).to have_tag :div, with: {class: 'input email'} do
          with_tag :label, for: 'product_email', text: 'Email:'
          with_tag :input, type: 'email', class: 'control', id: 'product_email', 'ng-model' => 'product.email'
          with_tag :label, for: 'product_email', class: 'error', text: '{{product.errors.email[0]}}'
        end
      end

      specify "as password" do
        expect(builder.input(:pass, as: :password)).to have_tag :div, with: {class: 'input password'} do
          with_tag :label, for: 'product_pass', text: 'Pass:'
          with_tag :input, type: 'password', class: 'control', id: 'product_pass', 'ng-model' => 'product.pass'
          with_tag :label, for: 'product_pass', class: 'error', text: '{{product.errors.pass[0]}}'
        end
      end

      specify "as text" do
        expect(builder.input(:description, as: :text)).to have_tag :div, with: {class: 'input text'} do
          with_tag :label, for: 'product_description', text: 'Description:'
          with_tag :textarea, class: 'control', id: 'product_description', 'ng-model' => 'product.description'
          with_tag :label, for: 'product_description', class: 'error', text: '{{product.errors.description[0]}}'
        end
      end

      specify "as file" do
        expect(builder.input(:picture, as: :file)).to have_tag :div, with: {class: 'input file'} do
          with_tag :label, for: 'product_picture', text: 'Picture:'
          with_tag :input, type: 'file', class: 'control', id: 'product_picture', 'ng-model' => 'product.picture'
          with_tag :label, for: 'product_picture', class: 'error', text: '{{product.errors.picture[0]}}'
        end
      end

      specify "as boolean" do
        expect(builder.input(:promoted, as: :boolean)).to have_tag :div, with: {class: 'input boolean'} do
          with_tag :label, for: 'product_promoted', text: 'Promoted'
          with_tag :input, type: 'checkbox', id: 'product_promoted', 'ng-model' => 'product.name'
        end
      end

      specify "as select" do
        expect(builder.input(:size, as: :select)).to have_tag :div, with: {class: 'input select'} do
          with_tag :label, for: 'product_size', text: 'Size:'
          with_tag :select, class: 'control', id: 'product_size', 'ng-model' => 'product.size'
          with_tag :label, for: 'product_size', class: 'error', text: '{{product.errors.size[0]}}'
        end
      end

      specify "invalid type" do
        expect { builder.input :some, as: :not_existing_type }.to raise_error AngularForm::InvalidInputTypeError
      end
    end
  end

  describe "#submit" do
    it "renders submit button" do
      expect(builder.submit).to have_tag :input, type: :submit, value: 'Save'
    end

    it "accepts button value" do
      expect(builder.submit('Change')).to have_tag :input, type: :submit, value: 'Change'
    end

    it "accepts html tag options" do
      expect(builder.submit('Change', class: 'bnt-danger')).to have_tag :input, class: 'btn-danger'
    end

    it "class names are globally configured" do
      builder = AngularForm::Builder.new :product, helper, submit_class: 'btn btn-primary'

      expect(builder.submit('Change')).to have_selector 'input.btn.btn-primary'
    end
  end

  describe "#saved_message" do
    it "renders simple span with simple message" do
      expect(builder.saved_message).to have_tag :span, class: 'saved', 'ng-show' => 'saved', text: 'Saved!'
    end
  end

  class HtmlHelper
    include ActionView::Helpers

    def output_buffer=(content)
      @content = content
    end

    def output_buffer
      @content
    end
  end

  def helper
    @helper ||= HtmlHelper.new
  end
end

