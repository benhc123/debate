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
end
