AngularFormBuilder
==========================

Working with angular is cool, but in some areas there are some rough edges. Forms are one of those places. Especially if one is used to work with tools like [simple_form](http://github.com/plataformatec/simple_form). For several projects, now I'm slowly building up a [Rails](http://rubyonrails.org/) FormBuilder with similar API to [simple_form](http://github/com/plataformatec/simple_form).

**Project is not production ready still** (even the name isn't final yet).


Here is a little code example:

```slim
= angular_form_for :user |form|
  = form.input :first_name, required: true
  = form.input :last_name, required: true
  = form.input :email, as: :email required: true
  = form.input :bio, as: :text
  = form.input :password, as: :password, label: 'New password', required: true
  = form.input :password_confirmation, as: :password, label: 'Confirm new password', required: true
  = form.input :avatar, as: :file, control_html: {'simple-file-upload' => 'true'}

  .actions
    = form.submit
    = form.saved_message

```
