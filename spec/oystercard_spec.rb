require 'oystercard'

describe Oystercard do
  it 'sets default value to 0' do
    expect(subject.balance).to eq 0
  end

  it 'adds money to the oystercard' do
    expect(subject).to respond_to(:add_money).with(1).argument
  end

  it 'adds £50 to oystercard' do
    expect(subject.add_money(50)).to eq subject.balance
  end

end
