require 'rails_helper'

RSpec.describe "posts/show", type: :view do
  let(:user) { create :user}
  
  before(:each) do
    @post = assign(:post, Post.create!(user: user))
  end

  it "renders attributes in <p>" do
    render
  end
end
