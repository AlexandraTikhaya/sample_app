include ApplicationHelper

def valid_signin(user)
  fill_in "Email",    with: user.email.upcase
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def valid_signup
  fill_in "Name",         with: "Example User"
  fill_in "Email",        with: "user@example.com"
  fill_in "Password",     with: "foobar"
  fill_in "Confirmation", with: "foobar"
end


RSpec::Matchers.define :have_error_message do |message|

  match do |page|
    expect(page).to have_selector('.alert.bg-danger', text: message)
  end
end

RSpec::Matchers.define :have_welcome_flash do |message, style_class|  # "Welcome"
  match do |page|
    expect(page).to have_selector("div.alert.#{style_class}", text: message)
  end
end


RSpec::Matchers.define :have_logo do |message|
  match do |page|
    expect(page).to have_link('sample app', text: message)
  end
end


RSpec::Matchers.define :have_image_logo do |message|
  match do |page|
    image = page.find('img#rails-logo')
    expect(image[:src]).to match(/rails-logo/)
  end
end

RSpec::Matchers.define :have_button_signup do
  match do |page|
    expect(page).to have_selector(:link_or_button, "Sign up now!")
  end
end

def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end
#
# def full_title(page_title)
#   base_title = "Ruby on Rails Tutorial Sample App"
#   if page_title.empty?
#     base_title
#   else
#     "#{base_title} | #{page_title}"
#   end
# end