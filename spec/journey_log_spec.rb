require 'journey_log'

describe Journey_log do

  it "sets the journey_arr to empty by default" do
    expect(subject.journey_arr).to eq([])
  end

end
