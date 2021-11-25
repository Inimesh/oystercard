require 'station'

describe Station do
  it 'returns @name' do
    expect(subject.name).to eq subject.name
  end

  it 'returns @zone' do
    expect(subject.zone).to eq subject.zone
  end
end