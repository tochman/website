require 'spec_helper'

describe Booking do
  it "has a valid factory" do
    expect(create(:booking)).to be_valid
  end

  it "is valid with start_time, end_time, length, subject_id, description, url" do
    sub = create(:subject)
    expect(create(:booking, subject: sub)).to be_valid    
  end

  it "is invalid without start_time" do
    booking = build(:booking, start_time: nil)
    booking.should_not be_valid
    expect(booking).to have(1).errors_on(:start_time)
  end

  it "is invalid when start_time less than 15 mins from now" do
    booking = build(:booking, start_time: DateTime.now + 14.minutes)
    booking.should_not be_valid
    expect(booking).to have(1).errors_on(:start_time)
  end

  it "is invalid without length" do
    booking = build(:booking, length: nil)
    booking.should_not be_valid
    expect(booking).to have(2).errors_on(:length)
  end

  it "is invalid when length is 0" do
    booking = build(:booking, length: 0)
    booking.should_not be_valid
    expect(booking).to have(1).errors_on(:length)
  end

  it "is invalid with length < 0" do
    booking = build(:booking, length: -5)
    booking.should_not be_valid
    expect(booking).to have(1).errors_on(:length)
  end
end