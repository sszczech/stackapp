require 'spec_helper'

describe Stream do
  context "configures" do
    subject { Stream }
    before {
      redis = mock(Redis)
      Redis.should_receive(:new).with(:host => '127.0.0.1', :port => 6379).and_return(redis)
      subject.should_receive(:host=).with('127.0.0.1')
      subject.should_receive(:port=).with(6379)
      subject.should_receive(:connection=).with(redis)
    }
    it {
      subject.configure do |c|
        c.host = '127.0.0.1'
        c.port = 6379
      end
    }
  end

  context "creates new object" do
    let(:time) { Time.now }
    subject { Stream.new(:id => 123, :created_at => time, :url => '/comments/12',
                   :message => 'John Travolta has just created a comment') }
    its(:id) { should == 123 }
    its(:created_at) { should == time }
    its(:url) { should == '/comments/12' }
    its(:message) { should == 'John Travolta has just created a comment' }
  end

  context "creates and saves new object" do
    subject { Stream }
    let :attrs do
      { :id => 1, :message => 'Comment', :created_at => Time.now, :url => '/' }
    end
    before {
      stream = Stream.new(attrs)
      stream.should_receive(:save)
      subject.should_receive(:new).with(attrs).and_return(stream)
    }
    it {
      subject.create(attrs)
    }
  end

  context "saves to the stream" do
    subject { Stream.new(:id => 1) }
    before {
      connection = mock(Redis)
      connection.should_receive(:multi).and_yield
      connection.should_receive(:lpush).with("stackapp:test:stream:1", {
          :id => 1, :message => nil, :url => nil, :created_at => nil
        }.to_json)
      connection.should_receive(:ltrim).with("stackapp:test:stream:1", 0, 99)
      Stream.should_receive(:connection).exactly(3).times.and_return(connection)
    }
    it {
      subject.save
    }
  end

  context "finds a key" do
    subject { Stream }
    before {
      connection = mock(Redis)
      connection.should_receive(:lrange).with("stackapp:#{Rails.env}:stream:1", 0, 31).and_return([])
      subject.should_receive(:connection).and_return(connection)
    }
    it {
      Stream.find(1).should == []
    }
  end
end
