require 'rails_helper'

RSpec.describe "posts/edit", type: :view do
  let(:post) { create :post }

  it "renders the edit post form" do
    render
  end
end
