require 'spec_helper'

describe Video do
  it "has a valid factory" do
    expect(create(:video)).to be_valid
  end
end
