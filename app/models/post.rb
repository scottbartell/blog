class Post < ActiveRecord::Base

  # This seems dangerous. There has to be a better way.
  include ActionView::Helpers::DateHelper

  has_many :comments, :dependent => :destroy
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings

  validates_presence_of :title, :content
  attr_writer :tag_names
  after_save :assign_tags

  scope :published, lambda { where('published_at < ?', Time.zone.now).order('created_at DESC') }
  
  def self.per_page
    3
  end
  
  def self.paginated page = 1
    paginate :page => (page), :include => :tags, :per_page => per_page
  end

  def tag_names
    @tag_names || tags.map(&:name).join(' ')
  end
  
  def to_param
    self.permalink
  end

  def to_html
    html = content.blank? ? '' : RDiscount.new(content).to_html
    html.gsub(/\{\{gist: ([0-9]+)(?:,\s?([a-zA-Z0-9\._\+]+))?\}\}/, '<script src="http://gist.github.com/\1.js?file=\2"></script>').html_safe
  end
  
  def excerpt
    # TODO: Fix for <blockquote>
    to_html.split("</p>").first+"</p>".html_safe
  end
  
  def published?
    published_at && published_at < Time.now
  end
  
  def unpublished?
    !published?
  end
  
  def published_time_in_words
    return 'not published' unless published?
    words = time_ago_in_words(published_at)
    if published?
      "#{words} ago"
    else
      "in #{words}"
    end
  end

  private

  def assign_tags
    if @tag_names
      self.tags = @tag_names.split(/\s+/).map do |name|
        Tag.find_or_create_by_name(name)
      end
    end
  end
end
