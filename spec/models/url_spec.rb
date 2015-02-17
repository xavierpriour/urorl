require 'rails_helper'

RSpec.describe Url, type: :model do
  it "generates short URL after saving" do
    url = Url.new
    url.long = 'testing'
    expect(url.short).to be_nil
    url.save!
    expect(url.short).not_to be_empty
  end

  it "blocks assigning short URL from params" do
    url = Url.new({long: 'ok', short:'wrong'})
    expect(url.long).to eq('ok')
    expect(url.short).to be_nil
  end
end
