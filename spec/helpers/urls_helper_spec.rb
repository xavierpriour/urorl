require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UrlsHelper. For example:
#
# describe UrlsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UrlsHelper, type: :helper do
  it "generates proper link for short url" do
    url = Url.new
    url.short = 'a'
    expected = '<a href="http://test.host/urls/go/a" target="_blank">http://test.host/urls/go/a</a>'
    expect(link_short(url)).to eq(expected)
    # pending "add some examples to (or delete) #{__FILE__}"
  end
end
