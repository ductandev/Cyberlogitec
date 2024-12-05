# Author: your.email@your.domain.com
# Keywords Summary:
# Feature: List of scenarios.
# Scenario: Business rule through list of steps with arguments.
# Given: Some precondition step
# When: Some key actions
# Then: To observe outcomes or validation
# And, But: To enumerate more Given, When, Then steps
# Scenario Outline: List of steps for data-driven as an Examples and <placeholder>
# Examples: Container for s table
# Background: List of steps run before each of the scenarios
# """ (Doc Strings)
# | (Data Tables)
# @@ (Tags/Labels): To group Scenarios
# <> (placeholder)
# ## (Comments)

# Sample Feature Definition Template

@regression @login
Feature: [User Login]

  Background: Pre-conditions
    Given the user is on the login page

  Scenario: Login successfully with valid credentials
    When the user enters "nguyenductan998@gmail.com" into the email field
    And enters "Ductan123@" into the password field
    And clicks the "로그인" button
    Then the user should be redirected to the home page
    # And see a welcome message

  Scenario Outline: Login fails with invalid credentials
    When the user enters "<email>" into the email field
    And enters "<password>" into the password field
    And clicks the "로그인" button
    Then the user should see an error message 1 "<message1>"
    And the user should see an error message 2 "<message2>"
    And the user remains on the login page

    Examples:
      | email                     | password       | message1                                             | message2              |
      |                           |                | 이메일 아이디를 입력해주세요.                           | 비밀번호를 입력해주세요. |
      | nguyenductan998@gmail.com |                | 비밀번호를 입력해주세요.                                |                       |
      |                           | 123456         | 이메일 아이디를 입력해주세요.                            |                       |
      | emailchuadangky@gmail.com | 123456         | 이메일 또는 비밀번호가 올바르지 않습니다. 다시 확인해주세요 |                       |
      | nguyenductan998@gmail.com | SaiMatKhau123@ | 이메일 또는 비밀번호가 올바르지 않습니다. 다시 확인해주세요 |                       |

