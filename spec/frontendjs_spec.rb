require 'serverspec'

describe file('/usr/local/bin/woff2_compress') do
  it 'should exist' do
    expect(described_class).to exist
  end
end

describe file('/usr/local/bin/woff2_compress') do
  it 'should exist' do
    expect(described_class).to exist
  end
end

describe command('/usr/local/bin/woff2_compress') do
  it 'should execute' do
    expect(described_class.stderr).to match('One argument, the input filename, must be provided.')
  end
end

describe command('/usr/local/bin/woff2_decompress') do
  it 'should execute' do
    expect(described_class.stderr).to match('One argument, the input filename, must be provided.')
  end
end

