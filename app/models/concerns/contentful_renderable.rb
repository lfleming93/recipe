module ContentfulRenderable
  extend ActiveSupport::Concern

  included do
    attr_accessor :contentful_id

    def initialize(id, entry: nil)
      self.contentful_id = id
      @entry = entry
    end

    private

    def entry
      @entry ||= self.class.client.entry(contentful_id, include: 1)
    end

    def method_missing(name, *args)
      if entry.respond_to?(name)
        entry.public_send(name)
      else
        super
      end
    end
  end

  class_methods do
    def client
      @client ||= Contentful::Client.new(
        access_token: Rails.application.credentials.contentful[:access_token],
        space: Rails.application.credentials.contentful[:space],
        dynamic_entries: :auto,
        raise_for_empty_fields: false
      )
    end

    def all
      render_all.map {|entry| new(entry.id, entry: entry) }
    end

    def render_all
      client.entries(content_type: content_type_id)
    end
  end
end
