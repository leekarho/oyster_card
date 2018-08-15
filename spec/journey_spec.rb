require 'journey'

describe Journey do
  it 'responds to fare' do
    expect(subject).to respond_to(:fare)
  end

end
