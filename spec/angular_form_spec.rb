require 'spec_helper'

describe AngularForm, type: :helper do
  let(:builder) { AngularForm::Builder.new :product, helper }

  describe "#input" do
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

      specify "label" do
        expect(builder.input(:name, label: 'LABEL TEXT')).to have_tag :div, with: {class: 'input string'} do
          with_tag :label, for: 'product_name', text: 'LABEL TEXT:'
          with_tag :input, type: 'text', class: 'control', id: 'product_name', 'ng-model' => 'product.name'
          with_tag :label, for: 'product_name', class: 'error', text: '{{product.errors.name[0]}}'
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

      specify "as boolean" do
        expect(builder.input(:promoted, as: :boolean)).to have_tag :div, with: {class: 'input boolean'} do
          with_tag :label, for: 'product_promoted', text: 'Promoted'
          with_tag :input, type: 'checkbox', id: 'product_promoted', 'ng-model' => 'product.name'
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
  end

  describe "#saved_messsage" do
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

