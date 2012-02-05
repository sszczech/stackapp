require 'json'

class Stream

  attr_accessor :id, :message, :url, :created_at

  def initialize(attrs = {})
    attrs.map { |attr, value|
      send("#{attr}=", value)
    }
  end

  def connection
    Stream.connection
  end

  def save
    attrs = { :id => id, :message => message,
              :url => url, :created_at => created_at }
    connection.multi do
        connection.lpush("stackapp:#{Rails.env}:stream:#{id}", attrs.to_json)
        connection.ltrim("stackapp:#{Rails.env}:stream:#{id}", 0, 99)
    end
  end

  class << self
    attr_accessor :host, :port

    def configure
      yield self
    end

    def connection
      @connection ||= Redis.new(:host => Stream.host, :port => Stream.port)
    end

    def create(attrs = {})
      Stream.new(attrs).save
    end

    def find(id, offset = 0, limit = 31)
      Stream.connection.lrange("stackapp:#{Rails.env}:stream:#{id}", offset, limit).map do |attrs|
        Stream.new(JSON.parse(attrs).merge(:id => id))
      end
    end
  end

end