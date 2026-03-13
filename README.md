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

## Quick Setup

Include the controller module in your base controller.

```ruby
class ApplicationController < ActionController::API
  include RailsReactErrors::Controller
end
```

That's it. Your Rails API will now automatically return standardized error responses.

---

## Automatic Exception Handling

The gem automatically handles common Rails exceptions and converts them into consistent JSON responses.

Supported exceptions:

* `ActiveRecord::RecordNotFound`
* `ActiveRecord::RecordInvalid`
* `ActiveRecord::RecordNotUnique`
* `ActionController::ParameterMissing`
* `JSON::ParserError`
* `StandardError`

Example:

```ruby
class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    render json: user
  end
end
```

If the record does not exist:

```json
{
  "success": false,
  "message": "Couldn't find User with 'id'=99",
  "code": "NOT_FOUND",
  "errors": {}
}
```

---

## Validation Error Example

```ruby
class UsersController < ApplicationController
  def create
    user = User.create!(user_params)
    render json: { success: true, data: user }, status: :created
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
```

Response:

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

## JSON Parsing Error

If an invalid JSON payload is sent:

```json
{ email: "test"
```

Response:

```json
{
  "success": false,
  "message": "Invalid JSON payload",
  "code": "INVALID_JSON",
  "errors": {}
}
```

---

## Available Helper Methods

You can also manually render errors if needed.

```ruby
render_validation_error(record)
render_not_found_error("User not found")
render_parameter_missing_error("param is missing")
render_conflict_error("Duplicate record")
render_server_error("Something went wrong")
render_error(message:, code:, status:, errors: {})
```

---

## Custom Exception Mapping

You can configure your own exceptions.

```ruby
RailsReactErrors.configure do |config|
  config.custom_exceptions = {
    "Pundit::NotAuthorizedError" => {
      code: "FORBIDDEN",
      status: :forbidden
    },
    "JWT::DecodeError" => {
      code: "INVALID_TOKEN",
      status: :unauthorized
    }
  }
end
```

---

## Enable Global Error Handling

To automatically handle unexpected errors:

```ruby
RailsReactErrors.configure do |config|
  config.rescue_standard_error = true
end
```

---

## License

MIT License

---

## Author

Manish Prajapati
