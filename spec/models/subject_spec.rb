require 'spec_helper'

describe Subject do
  it "has a valid factory" do
    expect(create(:subject)).to be_valid
  end

  it "is valid with name" do
    sub = build(:subject, name: 'John')
    expect(sub).to be_valid
  end

  it "is invalid without a name" do
    sub = build(:subject, name: nil)
    expect(sub).to have(1).errors_on(:name)
  end

  it "is invalid with a duplicate name" do
    create(:subject, name: 'John')
    sub = build(:subject, name: 'John')
    expect(sub).to have(1).errors_on(:name)
  end
end