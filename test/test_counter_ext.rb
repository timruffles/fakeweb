require 'rubygems'
require 'test_helper'

class TestFakeWebQueryString < Test::Unit::TestCase
  
  def setup
    FakeWeb.reset_call_count_for('http://blah.com')
  end
  
  def test_reset
    FakeWeb.uri_called('blah.com')
    FakeWeb.uri_called('blah.com')
    assert_equal 2, FakeWeb.call_count_for('blah.com')
    FakeWeb.reset_call_count_for('blah.com')
    assert_equal 0, FakeWeb.call_count_for('blah.com')
  end

  def test_count_nethttp_request
    
    url = 'http://blah.com'
    FakeWeb.allow_net_connect = false
    FakeWeb.register_uri(:get, url, :body => 'blah')
    Net::HTTP.start('blah.com') { |http| http.get("/") }
    
    assert_equal 1, FakeWeb.call_count_for(url)
  end
  
  def test_count_httpclient_request
    url = 'http://blah.com/'
    FakeWeb.allow_net_connect = false
    FakeWeb.register_uri(:get, url, :body => 'blah')
    client = HTTPClient.new
    client.get_content(url)
    assert_equal 1, FakeWeb.call_count_for(url)
  end
end