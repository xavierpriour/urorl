require 'rails_helper'

RSpec.describe "urls/index", type: :view do
  before(:each) do
    assign(:urls, [
      Url.create!(
        :long => "Long1"
      ),
      Url.create!(
        :long => "Long2"
      )
    ])
  end

  it "renders a list of urls" do
    render
    assert_select "tr>td", :text => "Long1".to_s, :count => 1
    assert_select "tr>td", :text => "Long2".to_s, :count => 1
    assert_select "tbody>tr", :count => 2
    # assert_select "tr>td", :text => "Short".to_s, :count => 2
  end
end
