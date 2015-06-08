require "set"

shared_examples "GET index without permission" do
  it "render" do
    get :index
    is_expected.to redirect_to root_url
  end
end   

shared_examples "GET new without permission" do
  it "render" do
    get :new
    is_expected.to redirect_to root_url
  end
end

shared_examples "GET index with permission" do
  it "render" do
    get :index
    expect(response).to render_template :index
  end
end   

shared_examples "GET new with permission" do
  it "render" do
    get :new
    expect(response).to render_template :new
  end
end
