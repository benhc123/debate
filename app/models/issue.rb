require 'open-uri'

class Issue < ActiveRecord::Base
  has_paper_trail

  belongs_to :author, class_name: 'User'

  validates :author, presence: true
  validates :title, presence: true

  acts_as_votable
  acts_as_ordered_taggable

  def theses
    theses_for + theses_against
  end

  def theses_for
    get_theses(thesis_for_ids)
  end

  def theses_against
    get_theses(thesis_against_ids)
  end

  def add_thesis_for(thesis)
    self.thesis_for_ids += [thesis.id]
    save
  end

  def add_thesis_against(thesis)
    self.thesis_against_ids += [thesis.id]
    save
  end

  def remove_thesis(thesis)
    self.thesis_for_ids -= [thesis.id]
    self.thesis_against_ids -= [thesis.id]
    save
  end

  def revert_to!(version_number)
    version = self.versions[version_number]
    reified = version.next.reify
    reified.transaction do
      reified.save
      reified.theses.each do |t|
        t.version_at(version.created_at).save
      end
    end
  end

  def version_created_at
    live? ? updated_at : version.created_at
  end

  def self.load_bills count = 10, require_keywords = true
    raise "sunlight_key must be set to load data" if not Rails.application.secrets.sunlight_key

    loaded = []
    page = 1
    loc = Organization.find_or_create_by name: 'Library of Congress'
    congress = User.find_or_create_by!( email: 'membership@congress.gov' ) do |user| # Should be an organization, but issue authors are only users currently
      pass = SecureRandom.random_bytes 20 + rand( 20 )
      user.name = 'Congress'
      user.password = pass
      user.password_confirmation = pass
    end

    ActsAsTaggableOn.delimiter = '~' # parse: false doesn't work

    while loaded.count < count
      url = "https://congress.api.sunlightfoundation.com/bills?fields=keywords,short_title,official_title,summary&apikey=#{Rails.application.secrets.sunlight_key}&page=#{page}"
      puts url
      bills = JSON.load( open url )
      bills['results'].each do |bill|
        if not require_keywords or bill['keywords'].any?
          title = bill['short_title'] || bill['official_title']
          issue = Issue.find_or_create_by!( title: title, author: congress ) do |issue|
            issue.text = bill['summary']
          end
          loc.tag( issue, with: bill['keywords'], on: :tags, parse: false )
          loaded << issue
        end
      end
      page += 1
    end
    loaded
  end

  private
  def get_theses(ids)
    Thesis.where(id: ids).map {|t| t.version_at(version_created_at)}.sort {|x,y| ids.index(x.id) <=> ids.index(y.id)}
  end
end
