@regression @login
Feature: User Login

  As a user
  I want to log in with my credentials
  So that I can access my account and use the application

  Background: The user is on the login page
    Given the user is on the login page

  # ✅ Trường hợp: Đăng nhập thành công bằng "email" hoặc "username"
  Scenario Outline: Login successfully with valid credentials
    When the user enters "<email_or_username>" into the email/username field
    And enters "<password>" into the password field
    And clicks the "Submit" button
    Then the user should be redirected to the home page
    And the user should see a message "Login successfully!"

    Examples:
      | email_or_username         | password       |
      | ductandev                 | Ductan123@     |
      | nguyenductan998@gmail.com | Ductan123@     |


  # ❌ Trường hợp: Đăng nhập không thành công bắt validate input ở FE
  #    (Do email/username chung 1 ô input nên ko bắt dc định dạng email và username bên FE)
  Scenario Outline: Login fails with empty and invalid credentials
    When the user enters "<email_or_username>" into the email/username field
    And enters "<password>" into the password field
    And clicks the "Submit" button
    Then the user should see an error validate message 1 "<message1>"
    And the user should see an error validate message 2 "<message2>"
    And the user remains on the login page

    Examples:
      | email_or_username         | password       | message1                                  | message2                                                                                                                                 |
      |                           |                | Please enter your email or username.      | Password must be at least 8 to 30 characters long and include an uppercase letter, a lowercase letter, a number, and a special character.|
      | nguyenductan998@gmail.com |                |                                           | Password must be at least 8 to 30 characters long and include an uppercase letter, a lowercase letter, a number, and a special character.|
      |                           | 123456         | Please enter your email or username.      | Password must be at least 8 to 30 characters long and include an uppercase letter, a lowercase letter, a number, and a special character.|
      | nguyenductan998@gmail.com | 123456         |                                           | Password must be at least 8 to 30 characters long and include an uppercase letter, a lowercase letter, a number, and a special character.|


  # ❌ Trường hợp: Đăng nhập không thành công bắt validate ở phía BE trả về FE
  Scenario Outline: Login fails with invalid credentials
    When the user enters "<email_or_username>" into the email/username field
    And enters "<password>" into the password field
    And clicks the "Submit" button
    Then the user should see an error message "<message>"
    And the user remains on the login page

    Examples:
      | email_or_username         | password       | message                                                            |
      | emailchuadangky@gmail.com | SaiMatKhau123@ | The email or username you entered is incorrect. Please try again ! |
      | userchuadangky            | SaiMatKhau123@ | The email or username you entered is incorrect. Please try again ! |
      | nguyenductan998@gmail.com | SaiMatKhau123@ | The password you entered is incorrect. Please try again !          |
      | ductandev                 | SaiMatKhau123@ | The password you entered is incorrect. Please try again !          |


  # ❌ Trường hợp: Đăng nhập không thành công khi tài khoản bị khóa
  Scenario: Login fails when the account is locked
    When the user enters "nguyenductan998@gmail.com" into the email/username field
    And enters "Ductan123@" into the password field
    And clicks the "Submit" button
    Then the user should see an error message "Your account is locked. Please contact support !"
    And the user remains on the login page


  # ❌ Trường hợp: Tài khoản chưa được xác minh tránh spam account
  Scenario: Login fails with unverified account
    When the user enters "unverifieduser@gmail.com" into the email/username field
    And enters "Ductan123@" into the password field
    And clicks the "Submit" button
    Then the user should see an error message "Your account has not been verified. Please check your email to verify your account."
    And the user remains on the login page


#  # ❌ Trường hợp: Đăng nhập không thành công khi nhập quá số lần giới hạn
#  Scenario: Login fails after too many attempts
#    Given the user has entered invalid credentials more than 5 times
#    When the user enters "nguyenductan998@gmail.com" into the email/username field
#    And enters "SaiMatKhau123@" into the password field
#    And clicks the "Submit" button
#    Then the user should see an error message "Too many failed attempts. Please try again later."
#    And the user remains on the login page
#
#
#  # ❌ Trường hợp: Xác thực hai yếu tố (2FA)
#  Scenario Outline: Login requires two-factor authentication
#    When the user enters "<email_or_username>" into the email/username field
#    And enters "<password>" into the password field
#    And clicks the "Submit" button
#    Then the user should be prompted to enter a 2FA code
#    When the user enters "<2fa_code>" into the 2FA field
#    Then the user should see "<result_message>"
#
#    Examples:
#      | email_or_username         | password       | 2fa_code   | result_message                           |
#      | ductandev                 | Ductan123@     | 123456     | Login successfully!                      |
#      | nguyenductan998@gmail.com | Ductan123@     | 000000     | Invalid 2FA code. Please try again.      |
#      | ductandev                 | Ductan123@     |            | 2FA code is required. Please try again.  |
#
#
#  # ❌ Trường hợp: Đăng nhập từ thiết bị mới
#  Scenario: Login requires additional verification for new device
#    When the user enters "nguyenductan998@gmail.com" into the email/username field
#    And enters "Ductan123@" into the password field
#    And clicks the "Submit" button
#    Then the user should see a message "New device detected. Please verify your login via email."
#    And the user remains on the login page
