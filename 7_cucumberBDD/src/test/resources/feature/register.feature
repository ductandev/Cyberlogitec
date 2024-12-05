@regression @Register
Feature: User Registration

  Background: The user is on the registration page
    Given the user is on the registration page

  # Trường hợp: Email không hợp lệ
  Scenario Outline: Registration fails with invalid email
    When the user enters an invalid email "<email>"
    Then the user should see an error validate message "올바른 이메일 주소를 입력해주세요"

    Examples:
      | email                             |
      | plainaddress                      |
      | @missingusername.com              |
      | username@.com                     |
      | username@example..com             |
      | username@-example.com             |
      | username@example.com.             |
      | username@example,com              |
      | .username@example.com             |
      | username.@example.com             |
      | username..name@example.com        |
      | user name@example.com             |
      | username@ example.com             |
      | username@example@com              |
      | username@example                  |
      | username@example.c                |
      | username@exam_ple.com             |
      | user@exam*ple.com                 |
      | user@exámple.com                  |
      | usér@example.com                  |
      | user@@example.com                 |
      | username@ex ample.com             |
      | username@exam<ple.com             |
      | username@example>com              |
      | aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa@example.com |

  # Trường hợp: Email hợp lệ nhưng Mật khẩu không đủ mạnh
  # ⭐ Chương trình FE thiếu trường hợp ký tự đặc biệt
  Scenario: Registration fails with weak password
    When the user enters a valid email
    And I click the "인증 코드 요청" button
    And I click the "인증 확인" button to verify
    And the user enters a password that does not meet complexity requirements
    Then the user should see an error validate message "비밀번호는 최소 8자리 이상이며, 대문자, 소문자, 숫자, 특수문자 각각 하나 이상 포함해야 합니다"

#    Examples:
#      | password         | # Error description                                                       |
#      | short            | # Dưới 8 ký tự                                                            |
#      | alllowercase     | # Không có chữ viết hoa, số hoặc ký tự đặc biệt                           |
#      | ALLUPPERCASE     | # Không có chữ viết thường, số hoặc ký tự đặc biệt                        |
#      | 12345678         | # Không có chữ viết hoa, chữ viết thường hoặc ký tự đặc biệt              |
#      | password1        | # Không có chữ viết hoa hoặc ký tự đặc biệt                               |
#      | PASSWORD1        | # Không có chữ viết thường hoặc ký tự đặc biệt                            |
#      | Pass1234         | # Không có ký tự đặc biệt                                                 |
#      | pass@word        | # Không có chữ viết hoa hoặc số                                           |
#      | PASS@WORD        | # Không có chữ viết thường hoặc số                                        |
#      | Pass!            | # Dưới 8 ký tự và không có số                                             |
#      | Pass word1@      | # Có khoảng trắng, điều này thường không được chấp nhận tùy theo quy định |


  # Trường hợp: Mật khẩu không khớp
  Scenario: Registration fails when passwords do not match
    When the user enters a valid email
    And I click the "인증 코드 요청" button
    And I click the "인증 확인" button to verify
    And the user enters a password and a confirmation password that do not match
    Then the user should see an error validate message "비밀번호가 일치하지 않습니다"


  # Trường hợp: Bỏ trống các trường thông tin
  Scenario: Registration fails when required fields are empty
    When the user enters a valid email
    And I click the "인증 코드 요청" button
    And I click the "인증 확인" button to verify
    When the user leaves one or more required fields empty
    And I click the "회원가입" button
    Then the user should see an error validate message "비밀번호는 최소 8자리 이상이며, 대문자, 소문자, 숫자, 특수문자 각각 하나 이상 포함해야 합니다"
    And the user should see an error validate message "비밀번호를 입력해주세요."
    And the user should see an error validate message "연락처 이름을 입력하십시오"
    And the user should see an error validate message "숫자를 입력해야 합니다"


  # Trường hợp: Đăng ký thành công
  Scenario: Successfully register with valid details
    When the user enters a valid email
    And I click the "인증 코드 요청" button
    And I click the "인증 확인" button to verify
    And the user enters a valid password, confirms password, and contactName
    And I click the "회원가입" button
    Then the user should see a message "성공적으로 등록되었습니다!"
    And be redirected to the login page

  # Trường hợp: Email người dùng đã tồn tại
  Scenario: Registration fails when email is already taken
    When the user enters a email that already exists
    And I click the "인증 코드 요청" button
    Then the user should see an error message "이미 존재하는 이메일 입니다"





