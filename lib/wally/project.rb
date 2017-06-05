require 'wally/topic'
require 'wally/project_customizer'

module Wally
  class Project
    include MongoMapper::Document
    
    key :name, String
    many :features, :class => Wally::Feature
    many :topics, :class => Wally::Topic
    
    class << self
      def find_by_name(name)
        Wally::Project.first(:name => name)
      end
    end
    
    def add_topic(topic)
      topics << topic
    end
    
    def feature(id)
      features.detect { |feature| feature.gherkin["id"] == id }
    end
    
    def topic(topic_path)
      topic_path = topic_path.gsub(':', '/')
      topics.detect do |t| 
        break t if (t = t.topic(topic_path))
      end
    end

    def import_content(path, io)
      markdown = nil
      if md = path.match(/(\/?readme.md$)/i)
        path = path.sub(md[1], '')
        markdown = io.read
      end
      topic = ensure_topics(path)
      if path.match(/\.feature$/)
        features << feature = Feature.parse_feature(path, io)
        topic.link_feature(feature)
      end
      topic.markdown = markdown if markdown
    end
        
    def customize(navigation_config = [])
      ProjectCustomizer.customize(self, navigation_config)
    end
    
    def clear_features
      features.clear
      topics.clear
    end
    
    def to_param
      name
    end
    
    private
    
    def ensure_topics(path)
      root_name = path.split('/').first
      unless (topic = topic(root_name))
        topics << topic = Topic.new(:path => root_name)
      end
      topic.ensure_descendents(path)
    end
  end
end
