require 'spec_helper'

describe Project do
  it "has a valid factory" do
    expect(create(:project)).to be_valid
    end
end
