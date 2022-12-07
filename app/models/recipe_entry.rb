class RecipeEntry
  include ContentfulRenderable

  class << self
    def content_type_id
      'recipe'
    end

    def render_all
      client.entries(content_type: content_type_id, select: ["fields.title"])
    end
  end
end
