module AccountAssociations
  extend ActiveSupport::Concern

  included do
    has_many :api_keys
    has_many :actions
    has_many :kudos
    has_many :sent_kudos, class_name: :Kudo, foreign_key: :sender_id
    belongs_to :markup, foreign_key: :about_markup_id, autosave: true, class_name: 'Markup'
    belongs_to :organization
    has_one :person
    has_many :topics
    has_many :ratings
    has_many :reviews
    has_many :posts
    has_many :invites, class_name: 'Invite', foreign_key: 'invitor_id'
    has_many :vitas
    belongs_to :best_vita, foreign_key: 'best_vita_id', class_name: 'Vita'
  end
end
