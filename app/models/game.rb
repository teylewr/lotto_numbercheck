class Game < ActiveRecord::Base
    has_many :drawings , dependent: :destroy
    validates_presence_of :name, :slug
    validates_uniqueness_of :name, :slug

end
