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
    Thesis.where(id: thesis_for_ids).map {|t| t.version_at(version_created_at)}
  end

  def theses_against
    Thesis.where(id: thesis_against_ids).map {|t| t.version_at(version_created_at)}
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

    found = 0
    page = 1
    

    while found < count
      url = "https://congress.api.sunlightfoundation.com/bills?fields=keywords,official_title&apikey=#{Rails.application.secrets.sunlight_key}&page=#{page}"
      puts url
      bills = JSON.load( open url )
      bills['results'].each do |bill|
        if bill['keywords'].any?
          # Issue.find_or_create_by( title: bill.
          return bill
        end
      end
      page += 1
    end
  end
end
