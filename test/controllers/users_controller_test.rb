require "test_helper"

describe UsersController do
  describe "auth_callback" do
      it "logs in an existing user and redirects to the root route" do
        # Count the users, to make sure we're not (for example) creating
        # a new user every time we get a login request
        start_count = User.count

        # Get a user from the fixtures
        user = users(:grace)

        login(user)

        must_redirect_to root_path

        # Since we can read the session, check that the user ID was set as expected
        session[:user_id].must_equal user.id

        # Should *not* have created a new user
        User.count.must_equal start_count
      end

      it "creates an account for a new user and redirects to the root route" do
        start_count = User.count
        user = User.new(provider: "github", uid: 99999, username: "test_user", email: "test@user.com")

        login(user)

        must_redirect_to root_path

        # Should have created a new user
        User.count.must_equal start_count + 1

        # The new user's ID should be set in the session
        session[:user_id].must_equal User.last.id
      end
      #
      # it "redirects to the login route if given invalid user data" do
      # end
    end
end
