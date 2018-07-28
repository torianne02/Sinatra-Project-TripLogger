module Slugifiable
  module InstanceMethods
    def slug
      self.username.strip.downcase.gsub(/\W/, '-')
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      slug_name = slug.gsub('-', ' ')
      self.where("lower(username) = ?", slug_name).first
    end
  end
end
