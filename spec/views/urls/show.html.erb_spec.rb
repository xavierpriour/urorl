require 'rails_helper'

RSpec.describe "urls/show", type: :view do
  before(:each) do
    @url = assign(:url, Url.create!(
      :long => "http://google.com",
      :short => "xxx"
    ))
  end

  it "renders long and short URL" do
    render
    # the test here is a bit light, we just want to detect if the whole
    # screen goes blank for example
    expect(rendered).to match(/google.com/)
    expect(rendered).to match(/urls\/go\//)
  end
end
