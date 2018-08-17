require 'journey'

describe Journey do
  it 'responds to fare' do
    expect(subject).to respond_to(:fare)
  end

  it 'calculates fare' do
    subject.start(nil)
    expect(subject.fare).to eq (Journey::PEN_CHARGE)
  end

end
