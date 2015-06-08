# shared_context "User signed in" do
#   user = create(:user, level: :normal)
#   login_as user, scope: :user
# end
# shared_context "Admin signed in" do
#   user = create(:user, level: :admin)
#   login_as user, scope: :user
# end