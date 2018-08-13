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

  it 'tops up the balance by 1' do
    expect { subject.add_money(1) }.to change{ subject.balance }.by 1
  end

  it 'caps the oystercard limit to £90' do
    subject.add_money(90)
    expect { subject.add_money(1) }.to raise_error 'max limit reached'
  end
end
