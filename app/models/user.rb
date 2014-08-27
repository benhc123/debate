class User < Voter
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_and_belongs_to_many :organizations
  has_many :delegations, as: :voter
  has_many :delegation_entries, as: :delegate

  acts_as_voter
  acts_as_tagger

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def display
    name || 'Anon'
  end
end
