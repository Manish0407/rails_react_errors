# rails_react_errors

Consistent error responses for **Rails APIs used by React frontends**.

`rails_react_errors` standardizes API error responses so React applications can easily handle validation errors, authentication errors, and server failures.

Instead of handling multiple Rails error formats, this gem provides a **single predictable JSON structure**.

---

## Installation

Add this line to your application's Gemfile:

```ruby
gem "rails_react_errors"
```

Then run:

```bash
bundle install
```

---

## Usage

Include the controller module in your base controller.

```ruby
class ApplicationController < ActionController::API
  include RailsReactErrors::Controller
end
```

---

## Example

Controller example:

```ruby
class UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      render json: { success: true, data: user }, status: :created
    else
      render_validation_error(user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
```

Response example:

```json
{
  "success": false,
  "message": "Validation failed",
  "code": "VALIDATION_ERROR",
  "errors": {
    "email": ["Email can't be blank"]
  }
}
```

---

## Available Helpers

```ruby
render_validation_error(record)
render_not_found_error("User not found")
render_unauthorized_error
render_forbidden_error
render_server_error
```

---

## License

MIT License

---

## Author

Manish Prajapati
