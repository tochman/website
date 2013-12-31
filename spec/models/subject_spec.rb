require 'spec_helper'

describe Subject do
  it "has a valid factory" do
    expect(create(:subject)).to be_valid
  end

  it "is valid with name" do
    subject = build(:subject, name: 'Pair programming')
    expect(subject).to be_valid
  end

  it "is invalid without a name" do
    subject = build(:subject, name: nil)
    subject.should_not be_valid
    expect(subject).to have(1).errors_on(:name)
  end

  it "is invalid with a duplicate name" do
    create(:subject, name: 'Pair programming')
    subject = build(:subject, name: 'Pair programming')
    subject.should_not be_valid
    expect(subject).to have(1).errors_on(:name)
  end
end