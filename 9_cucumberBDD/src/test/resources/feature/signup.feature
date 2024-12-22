@regression @Register
Feature: User Sign Up

  As a new user
  I want to fill out a sign-up form
  So that I can register successfully and start using the application

  Background: The user is on the sign-up page
    Given the user is on the sign-up page

  # ✅ Trường hợp: Đăng ký thành công
  Scenario: Successfully register with valid details
    When the user enters a valid "fullname" as "Duc Tan"
    And the user enters a valid "username" as "Ductandev"
    And the user enters a valid "email" as "nguyenductan998@gmail.com"
    And the user enters a valid "password" as "Ductan123@"
    And the user selects "preferred_genres" as "Pop, Rock, Jazz"
    And the user enters "interests" with "I enjoy listening to a wide range of music genres, especially Pop and Jazz. I also like exploring Rock music and its subgenres."
    And the user clicks the "Submit" button
    Then the user should see a notify message "Registration successful!"
    And the user should be redirected to the login page

  # ❌ Trường hợp: Fullname không hợp lệ
  Scenario Outline: Sign Up fails with invalid Full Name
    When the user enters an invalid "fullname" as "<fullname>"
    And  the user clicks the "Submit" button
    Then the user should see an error validate message "<error_message>"

    Examples:
      | fullname                       | error_message                                      | # Error description
      | J                              | "Full name must be at least 2 to 50 characters."   | # Quá ngắn
      | John123                        | "Full name must not contain numbers."              | # Chứa số
      | John@Doe                       | "Full name must not contain special characters."   | # Chứa ký tự đặc biệt
      |   John Doe                     | "Full name must not contain leading spaces."       | # Khoảng trắng đầu dòng
      | John Doe   Doe                 | "Full name must not contain excessive spaces."     | # Nhiều khoảng trắng giữa các từ
      | John                           | "Full name must include both first and last name." | # Chỉ có tên hoặc họ
      | John Doe John Doe John Doe John Doe John Doe John Doe | "Full name must not exceed 50 characters." | # Quá dài

      ###DANE### "Full name must not contain leading spaces."  => Này a nghĩ mình có thể trim full name ⭐
      ###DANE### "Full name must include both first and last name." => nhiều tên chỉ có 1 từ thôi á, vd: Aristocles

  # ❌ Trường hợp: Username không hợp lệ
  Scenario Outline: Sign Up fails with invalid username
    # When the user enters a valid "fullname" as "Duc Tan"
    When the user enters an invalid "username" as "<username>"
    And  the user clicks the "Submit" button
    Then the user should see an error validate message "<error_message>"

    Examples:
      | username              | error_message                                      |
      | short                 | Username must be at least 5 to 20 characters long. |
      | toooooooooooolongname | Username must be at least 5 to 20 characters long. |
      | user name             | Username must not contain spaces.                  |
      | 123username           | Username must start with a letter.                 |
      | _username             | Username must not start with special characters.   |
      | username_             | Username must not end with special characters.     |
      | user@name             | Username must only contain letters and numbers.    |
      | user#name             | Username must only contain letters and numbers.    |
      | user!name             | Username must only contain letters and numbers.    |
      | user%name             | Username must only contain letters and numbers.    |
      | user$name             | Username must only contain letters and numbers.    |

    ###DANE### "Username must be at least 5 characters long." và "Username must not exceed 20 characters." nên combine lại như fullname cho đồng bộ => "Username length must be between 5 and 20" ⭐
    ###DANE### "Username must only contain letters and numbers." [a-zA-Z0-9] rule này đã cover cho "Username must not start with special characters." và "Username must not end with special characters."


  # ❌ Trường hợp: Email không hợp lệ
  Scenario Outline: Sign Up fails with invalid email
    # When the user enters a valid "fullname" as "Duc Tan"
    # And the user enters a valid "username" as "Ductandev"
    When the user enters an invalid email "<email>"
    And  the user clicks the "Submit" button
    Then the user should see an error validate message "Please enter a valid email address."

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

  # ❌ Trường hợp: Mật khẩu không đủ mạnh
  Scenario Outline: Sign Up fails with weak password
    # When the user enters a valid "fullname" as "Duc Tan"
    # And the user enters a valid "username" as "Ductandev"
    # And the user enters a valid "email" as "nguyenductan998@gmail.com"
    When the user enters an invalid password "<password>"
    And  the user clicks the "Submit" button
    Then the user should see an error validate message "Password must be at least 8 to 30 characters long and include an uppercase letter, a lowercase letter, a number, and a special character."

    Examples:
      | password         | # Error description                                                       |
      | short            | # Dưới 8 ký tự                                                            |
      | alllowercase     | # Không có chữ viết hoa, số hoặc ký tự đặc biệt                           |
      | ALLUPPERCASE     | # Không có chữ viết thường, số hoặc ký tự đặc biệt                        |
      | 12345678         | # Không có chữ viết hoa, chữ viết thường hoặc ký tự đặc biệt              |
      | password1        | # Không có chữ viết hoa hoặc ký tự đặc biệt                               |
      | PASSWORD1        | # Không có chữ viết thường hoặc ký tự đặc biệt                            |
      | Pass1234         | # Không có ký tự đặc biệt                                                 |
      | pass@word        | # Không có chữ viết hoa hoặc số                                           |
      | PASS@WORD        | # Không có chữ viết thường hoặc số                                        |
      | Pass!            | # Dưới 8 ký tự và không có số                                             |
      | Pass word1@      | # Có khoảng trắng, điều này thường không được chấp nhận tùy theo quy định |
      | Long123@aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa            | # Trên 30 ký tự                    |

      ###DANE### Password length cần phải giới hạn lại, 30 characters ⭐
      ###DANE### "Password length must between 8 and 30. Must include an uppercase letter, a lowercase letter, a number, and a special character."


  # ❌ Trường hợp: Interests không hợp lệ
  Scenario Outline: Sign Up fails when interests length is invalid
    # When the user enters a valid "Full name" as "Duc Tan"
    # And the user enters a valid "Username" as "ductandev"
    # And the user enters a valid "Email" as "nguyenductan998@gmail.com"
    # And the user enters a valid "Password" as "Ductan123@"
    # And the user selects "Preferred genres" as "Science Fiction, Mystery"
    When the user enters "Interests" with "<interests>"
    And the user clicks the "Submit" button
    Then the user should see an error validate message "Interests must be between 50-300 characters."

    Examples:
      | interests                           |
      | Too short                           |
      | This description is way too long and exceeds the maximum character limit of three hundred characters which is not acceptable as per the validation rules. |


  # ❌ Trường hợp: Bỏ trống các trường thông tin bắt buộc
  Scenario Outline: Sign Up fails when required fields are empty
    When the user leaves the "<field>" field empty
    And the user clicks the "Submit" button
    Then the user should see an error validate message "<error_message>"

    Examples:
      | field            | error_message                        |
      | Full name        | Full name is required.               |
      | Username         | Username is required.                |
      | Email            | Email is required.                   |
      | Password         | Password is required.                |
      | Preferred genres | Preferred genres is required.        |
      | Interests        | Interests is required.               |

  # ❌ Trường hợp: Email người dùng đã tồn tại (Trường hợp bắt bên FE tất cả đều pass mới call API về phía BE để kiểm tra validate)
  Scenario: Sign Up fails when email is already taken
    When the user enters a valid "fullname" as "Duc Tan"
    And the user enters a valid "username" as "Ductandev"
    And the user enters a valid "email" as "nguyenductan998@gmail.com"
    And the user enters a valid "password" as "Ductan123@"
    And the user selects "preferred_genres" as "Pop, Rock, Jazz"
    And the user enters "interests" with "I enjoy listening to a wide range of music genres"
    And the user clicks the "Submit" button
    Then the user should see an error message "This email is already taken"

  # ❌ Trường hợp: Username người dùng đã tồn tại (Trường hợp bắt bên FE tất cả đều pass mới call API về phía BE để kiểm tra validate)
  Scenario: Sign Up fails when email is already taken
    When the user enters a valid "fullname" as "Duc Tan"
    And the user enters a valid "username" as "Ductandev"
    And the user enters a valid "email" as "nguyenductan998@gmail.com"
    And the user enters a valid "password" as "Ductan123@"
    And the user selects "preferred_genres" as "Pop, Rock, Jazz"
    And the user enters "interests" with "I enjoy listening to a wide range of music genres"
    And the user clicks the "Submit" button
    Then the user should see an error message "This username is already taken"





