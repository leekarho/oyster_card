require 'station'

describe Station do
  it "initializes with name and zone" do
    st = Station.new(:AE, 1)
    expect([st.name, st.zone]).to eq [:AE, 1]
  end

end
