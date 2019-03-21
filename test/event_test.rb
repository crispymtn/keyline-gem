require "test_helper"

class EventTest < Minitest::Test
  def test_correcty_verifies_the_checksum
    secret = 'ABCDEFG12345'
    checksum = 'sha1=c88eb6c9ec06cab071c4cea282af9e4b959c5e16'

    assert Keyline::Event.new(
      raw_data: '{"event":{"data": "test"}}',
      secret: secret,
      checksum: checksum
    )
  end
end
